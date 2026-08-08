import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/purchase_order.dart';
import 'package:uuid/uuid.dart';
import 'settings_dao.dart';

class PurchaseOrderDao {
  final AppDatabase _db;

  PurchaseOrderDao(this._db);

  Future<List<PurchaseOrder>> getAll() async {
    try {
      final rows = await _db.select(_db.purchaseOrdersTbl).get();
      if (rows.isEmpty) return [];
      final ids = rows.map((r) => r.id).toList();
      final allItems = await (_db.select(_db.poItemsTbl)
        ..where((t) => t.purchaseOrderId.isIn(ids))
      ).get();
      final itemMap = <String, List<PoItemsTblData>>{};
      for (final item in allItems) {
        itemMap.putIfAbsent(item.purchaseOrderId, () => []).add(item);
      }
      return rows.map((row) {
        final items = itemMap[row.id] ?? [];
        return _toModel(row, items.map((r) => PurchaseOrderItem(
          id: r.id,
          productId: r.productId,
          description: r.description,
          quantity: r.quantity,
          receivedQuantity: r.receivedQty,
          unitPrice: r.unitPrice,
          taxPercent: r.taxPercent,
          taxAmount: r.taxAmount,
          total: r.total,
        )).toList());
      }).toList();
    } catch (e) {
      debugPrint('PurchaseOrderDao.getAll error: $e');
      rethrow;
    }
  }

  Future<PurchaseOrder?> getById(String id) async {
    try {
      final row = await (_db.select(_db.purchaseOrdersTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      if (row == null) return null;
      final items = await _getItems(row.id);
      return _toModel(row, items);
    } catch (e) {
      debugPrint('PurchaseOrderDao.getById error: $e');
      rethrow;
    }
  }

  Future<void> insert(PurchaseOrder order) async {
    try {
      final settings = await SettingsDao(_db).getSettings();
      final markup = 1.0 + (settings.productMarkupPercent / 100.0);

      await _db.transaction(() async {
        await _db.into(_db.purchaseOrdersTbl).insert(_toCompanion(order));
        for (final item in order.items) {
          String? productId = item.productId;
          int receivedQty = 0;

          if (order.status == 'Received') {
            receivedQty = item.quantity;
            if (productId == null) {
              final existingProduct = await (_db.select(_db.productsTbl)
                ..where((t) => t.name.lower().equals(item.description.trim().toLowerCase()))
              ).getSingleOrNull();

              if (existingProduct != null) {
                productId = existingProduct.id;
                final updatedQty = existingProduct.quantity + item.quantity;
                await (_db.update(_db.productsTbl)..where((t) => t.id.equals(productId!))).write(
                  ProductsTblCompanion(
                    quantity: Value(updatedQty),
                    updatedAt: Value(DateTime.now()),
                  ),
                );
                await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                  id: Value(const Uuid().v4()),
                  productId: Value(productId),
                  productName: Value(existingProduct.name),
                  quantityChange: Value(item.quantity),
                  balanceAfter: Value(updatedQty),
                  type: const Value('Purchase'),
                  referenceNumber: Value(order.poNumber),
                  referenceId: Value(order.id),
                  description: Value('PO insert (matched existing product): ${item.description}'),
                  createdAt: Value(DateTime.now()),
                ));
              } else {
                final newId = const Uuid().v4();
                await _db.into(_db.productsTbl).insert(ProductsTblCompanion(
                  id: Value(newId),
                  name: Value(item.description.isNotEmpty ? item.description : 'PO Item'),
                  sku: Value(null),
                  barcode: Value(null),
                  description: Value(null),
                  category: Value('Purchased'),
                  costPrice: Value(item.unitPrice),
                  sellingPrice: Value(item.unitPrice > 0 ? item.unitPrice * markup : item.unitPrice),
                  quantity: Value(item.quantity),
                  reorderLevel: const Value(5),
                  unit: const Value('pcs'),
                  createdAt: Value(DateTime.now()),
                  updatedAt: Value(DateTime.now()),
                ));
                await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                  id: Value(const Uuid().v4()),
                  productId: Value(newId),
                  productName: Value(item.description.isNotEmpty ? item.description : 'PO Item'),
                  quantityChange: Value(item.quantity),
                  balanceAfter: Value(item.quantity),
                  type: const Value('Purchase'),
                  referenceNumber: Value(order.poNumber),
                  referenceId: Value(order.id),
                  description: const Value('New product from PO insert receipt'),
                  createdAt: Value(DateTime.now()),
                ));
                productId = newId;
              }
            } else {
              final product = await (_db.select(_db.productsTbl)..where((t) => t.id.equals(productId!))).getSingleOrNull();
              if (product != null) {
                final updatedQty = product.quantity + item.quantity;
                await (_db.update(_db.productsTbl)..where((t) => t.id.equals(productId!))).write(
                  ProductsTblCompanion(
                    quantity: Value(updatedQty),
                    costPrice: item.unitPrice > 0 ? Value(item.unitPrice) : const Value.absent(),
                    updatedAt: Value(DateTime.now()),
                  ),
                );
                await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                  id: Value(const Uuid().v4()),
                  productId: Value(productId),
                  productName: Value(product.name),
                  quantityChange: Value(item.quantity),
                  balanceAfter: Value(updatedQty),
                  type: const Value('Purchase'),
                  referenceNumber: Value(order.poNumber),
                  referenceId: Value(order.id),
                  description: Value('PO insert: ${item.description}'),
                  createdAt: Value(DateTime.now()),
                ));
              }
            }
          }

          await _db.into(_db.poItemsTbl).insert(PoItemsTblCompanion(
            id: Value(const Uuid().v4()),
            purchaseOrderId: Value(order.id),
            productId: Value(productId),
            description: Value(item.description),
            quantity: Value(item.quantity),
            receivedQty: Value(receivedQty),
            unitPrice: Value(item.unitPrice),
            taxPercent: Value(item.taxPercent),
            taxAmount: Value(item.taxAmount),
            total: Value(item.total),
          ));
        }
      });
    } catch (e) {
      debugPrint('PurchaseOrderDao.insert error: $e');
      rethrow;
    }
  }

  Future<void> update(PurchaseOrder order) async {
    try {
      final settings = await SettingsDao(_db).getSettings();
      final markup = 1.0 + (settings.productMarkupPercent / 100.0);

      await _db.transaction(() async {
        // 1. Fetch previous state to check if it was received
        final oldOrder = await getById(order.id);
        final wasReceived = oldOrder != null && oldOrder.status == 'Received';

        // 2. Revert stock of old items if previously received
        if (wasReceived) {
          for (final oldItem in oldOrder.items) {
            final oldQtyToRevert = oldItem.receivedQuantity > 0 ? oldItem.receivedQuantity : oldItem.quantity;
            if (oldItem.productId != null && oldQtyToRevert > 0) {
              final product = await (_db.select(_db.productsTbl)..where((t) => t.id.equals(oldItem.productId!))).getSingleOrNull();
              if (product != null) {
                final newQty = (product.quantity - oldQtyToRevert).clamp(0, 999999);
                final delta = -oldQtyToRevert;
                await (_db.update(_db.productsTbl)..where((t) => t.id.equals(oldItem.productId!))).write(
                  ProductsTblCompanion(
                    quantity: Value(newQty),
                    updatedAt: Value(DateTime.now()),
                  ),
                );
                await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                  id: Value(const Uuid().v4()),
                  productId: Value(oldItem.productId!),
                  productName: Value(product.name),
                  quantityChange: Value(delta),
                  balanceAfter: Value(newQty),
                  type: const Value('Adjustment'),
                  referenceNumber: Value(oldOrder.poNumber),
                  referenceId: Value(order.id),
                  description: const Value('PO update reversal'),
                  createdAt: Value(DateTime.now()),
                ));
              }
            }
          }
        }

        // 3. Write updated PO details and delete old items
        await (_db.update(_db.purchaseOrdersTbl)..where((t) => t.id.equals(order.id))).write(_toCompanion(order));
        await (_db.delete(_db.poItemsTbl)..where((t) => t.purchaseOrderId.equals(order.id))).go();

        // 4. Save new items and apply stock adjustments if status is 'Received'
        for (final item in order.items) {
          String? productId = item.productId;
          int receivedQty = 0;

          if (order.status == 'Received') {
            receivedQty = item.quantity;
            if (productId == null) {
              final existingProduct = await (_db.select(_db.productsTbl)
                ..where((t) => t.name.lower().equals(item.description.trim().toLowerCase()))
              ).getSingleOrNull();

              if (existingProduct != null) {
                productId = existingProduct.id;
                final updatedQty = existingProduct.quantity + item.quantity;
                await (_db.update(_db.productsTbl)..where((t) => t.id.equals(productId!))).write(
                  ProductsTblCompanion(
                    quantity: Value(updatedQty),
                    updatedAt: Value(DateTime.now()),
                  ),
                );
                await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                  id: Value(const Uuid().v4()),
                  productId: Value(productId),
                  productName: Value(existingProduct.name),
                  quantityChange: Value(item.quantity),
                  balanceAfter: Value(updatedQty),
                  type: const Value('Purchase'),
                  referenceNumber: Value(order.poNumber),
                  referenceId: Value(order.id),
                  description: Value('PO update (matched existing product): ${item.description}'),
                  createdAt: Value(DateTime.now()),
                ));
              } else {
                final newId = const Uuid().v4();
                await _db.into(_db.productsTbl).insert(ProductsTblCompanion(
                  id: Value(newId),
                  name: Value(item.description.isNotEmpty ? item.description : 'PO Item'),
                  sku: Value(null),
                  barcode: Value(null),
                  description: Value(null),
                  category: Value('Purchased'),
                  costPrice: Value(item.unitPrice),
                  sellingPrice: Value(item.unitPrice > 0 ? item.unitPrice * markup : item.unitPrice),
                  quantity: Value(item.quantity),
                  reorderLevel: const Value(5),
                  unit: const Value('pcs'),
                  createdAt: Value(DateTime.now()),
                  updatedAt: Value(DateTime.now()),
                ));
                await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                  id: Value(const Uuid().v4()),
                  productId: Value(newId),
                  productName: Value(item.description.isNotEmpty ? item.description : 'PO Item'),
                  quantityChange: Value(item.quantity),
                  balanceAfter: Value(item.quantity),
                  type: const Value('Purchase'),
                  referenceNumber: Value(order.poNumber),
                  referenceId: Value(order.id),
                  description: const Value('New product from PO update receipt'),
                  createdAt: Value(DateTime.now()),
                ));
                productId = newId;
              }
            } else {
              final product = await (_db.select(_db.productsTbl)..where((t) => t.id.equals(productId!))).getSingleOrNull();
              if (product != null) {
                final updatedQty = product.quantity + item.quantity;
                await (_db.update(_db.productsTbl)..where((t) => t.id.equals(productId!))).write(
                  ProductsTblCompanion(
                    quantity: Value(updatedQty),
                    updatedAt: Value(DateTime.now()),
                  ),
                );
                await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                  id: Value(const Uuid().v4()),
                  productId: Value(productId),
                  productName: Value(product.name),
                  quantityChange: Value(item.quantity),
                  balanceAfter: Value(updatedQty),
                  type: const Value('Purchase'),
                  referenceNumber: Value(order.poNumber),
                  referenceId: Value(order.id),
                  description: Value('PO update: ${item.description}'),
                  createdAt: Value(DateTime.now()),
                ));
              }
            }
          } else {
            receivedQty = 0;
          }

          await _db.into(_db.poItemsTbl).insert(PoItemsTblCompanion(
            id: Value(const Uuid().v4()),
            purchaseOrderId: Value(order.id),
            productId: Value(productId),
            description: Value(item.description),
            quantity: Value(item.quantity),
            receivedQty: Value(receivedQty),
            unitPrice: Value(item.unitPrice),
            taxPercent: Value(item.taxPercent),
            taxAmount: Value(item.taxAmount),
            total: Value(item.total),
          ));
        }
      });
    } catch (e) {
      debugPrint('PurchaseOrderDao.update error: $e');
      rethrow;
    }
  }

  Future<void> receive(String poId) async {
    try {
      final settings = await SettingsDao(_db).getSettings();
      final markup = 1.0 + (settings.productMarkupPercent / 100.0);
      await _db.transaction(() async {
        final existing = await getById(poId);
        if (existing == null) return;

        final updatedItems = <PurchaseOrderItem>[];

        for (final item in existing.items) {
          String? productId = item.productId;

          if (productId == null) {
            final existingProduct = await (_db.select(_db.productsTbl)
              ..where((t) => t.name.lower().equals(item.description.trim().toLowerCase()))
            ).getSingleOrNull();

            if (existingProduct != null) {
              productId = existingProduct.id;
              final updatedQty = existingProduct.quantity + item.quantity;
              await (_db.update(_db.productsTbl)..where((t) => t.id.equals(productId!))).write(
                ProductsTblCompanion(
                  quantity: Value(updatedQty),
                  updatedAt: Value(DateTime.now()),
                ),
              );
              await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                id: Value(const Uuid().v4()),
                productId: Value(productId),
                productName: Value(existingProduct.name),
                quantityChange: Value(item.quantity),
                balanceAfter: Value(updatedQty),
                type: const Value('Purchase'),
                referenceNumber: Value(existing.poNumber),
                referenceId: Value(poId),
                description: Value('PO received (matched existing product): ${item.description}'),
                createdAt: Value(DateTime.now()),
              ));
            } else {
              final newId = const Uuid().v4();
              await _db.into(_db.productsTbl).insert(ProductsTblCompanion(
                id: Value(newId),
                name: Value(item.description.isNotEmpty ? item.description : 'PO Item'),
                sku: Value(null),
                barcode: Value(null),
                description: Value(null),
                category: Value('Purchased'),
                costPrice: Value(item.unitPrice),
                sellingPrice: Value(item.unitPrice > 0 ? item.unitPrice * markup : item.unitPrice),
                quantity: Value(item.quantity),
                reorderLevel: const Value(5),
                unit: const Value('pcs'),
                createdAt: Value(DateTime.now()),
                updatedAt: Value(DateTime.now()),
              ));
              await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                id: Value(const Uuid().v4()),
                productId: Value(newId),
                productName: Value(item.description.isNotEmpty ? item.description : 'PO Item'),
                quantityChange: Value(item.quantity),
                balanceAfter: Value(item.quantity),
                type: const Value('Purchase'),
                referenceNumber: Value(existing.poNumber),
                referenceId: Value(poId),
                description: const Value('New product from PO receipt'),
                createdAt: Value(DateTime.now()),
              ));
              productId = newId;
            }
          } else {
            final product = await (_db.select(_db.productsTbl)..where((t) => t.id.equals(productId!))).getSingleOrNull();
            if (product != null) {
              final updatedQty = product.quantity + item.quantity;
              await (_db.update(_db.productsTbl)..where((t) => t.id.equals(productId!))).write(
                ProductsTblCompanion(
                  quantity: Value(updatedQty),
                  costPrice: item.unitPrice > 0 ? Value(item.unitPrice) : const Value.absent(),
                  updatedAt: Value(DateTime.now()),
                ),
              );
              await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                id: Value(const Uuid().v4()),
                productId: Value(item.productId!),
                productName: Value(product.name),
                quantityChange: Value(item.quantity),
                balanceAfter: Value(updatedQty),
                type: const Value('Purchase'),
                referenceNumber: Value(existing.poNumber),
                referenceId: Value(poId),
                description: Value('PO received: ${item.description}'),
                createdAt: Value(DateTime.now()),
              ));
            }
          }

          updatedItems.add(PurchaseOrderItem(
            id: item.id,
            productId: productId,
            description: item.description,
            quantity: item.quantity,
            receivedQuantity: item.quantity,
            unitPrice: item.unitPrice,
            taxPercent: item.taxPercent,
            taxAmount: item.taxAmount,
            total: item.total,
          ));
        }

        await (_db.update(_db.purchaseOrdersTbl)..where((t) => t.id.equals(poId))).write(
          PurchaseOrdersTblCompanion(
            status: Value('Received'),
          ),
        );

        await (_db.delete(_db.poItemsTbl)..where((t) => t.purchaseOrderId.equals(poId))).go();
        for (final item in updatedItems) {
          await _db.into(_db.poItemsTbl).insert(PoItemsTblCompanion.insert(
            id: const Uuid().v4(),
            purchaseOrderId: poId,
            productId: Value(item.productId),
            description: item.description,
            quantity: item.quantity,
            receivedQty: item.quantity,
            unitPrice: item.unitPrice,
            taxPercent: item.taxPercent,
            taxAmount: item.taxAmount,
            total: item.total,
          ));
        }
      });
    } catch (e) {
      debugPrint('PurchaseOrderDao.receive error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await _db.transaction(() async {
        final existing = await getById(id);
        if (existing != null && existing.status == 'Received') {
          for (final item in existing.items) {
            if (item.productId != null) {
              final product = await (_db.select(_db.productsTbl)..where((t) => t.id.equals(item.productId!))).getSingleOrNull();
              if (product != null) {
                final newQty = (product.quantity - item.quantity).clamp(0, 999999);
                final delta = -(item.quantity);
                await (_db.update(_db.productsTbl)..where((t) => t.id.equals(item.productId!))).write(
                  ProductsTblCompanion(
                    quantity: Value(newQty),
                    updatedAt: Value(DateTime.now()),
                  ),
                );
                await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
                  id: Value(const Uuid().v4()),
                  productId: Value(item.productId!),
                  productName: Value(product.name),
                  quantityChange: Value(delta),
                  balanceAfter: Value(newQty),
                  type: const Value('Restock'),
                  referenceNumber: Value(existing.poNumber),
                  referenceId: Value(id),
                  description: const Value('PO deleted - stock reversed'),
                  createdAt: Value(DateTime.now()),
                ));
              }
            }
          }
        }
        // Explicitly delete dependent items and payments to avoid FK constraint failures on existing DBs
        await (_db.delete(_db.poItemsTbl)..where((t) => t.purchaseOrderId.equals(id))).go();
        await (_db.delete(_db.supplierPaymentsTbl)..where((t) => t.purchaseOrderId.equals(id))).go();

        await (_db.delete(_db.purchaseOrdersTbl)..where((t) => t.id.equals(id))).go();
      });
    } catch (e) {
      debugPrint('PurchaseOrderDao.delete error: $e');
      rethrow;
    }
  }

  Future<int> fixUnlinkedItems(String poId) async {
    try {
      final settings = await SettingsDao(_db).getSettings();
      final markup = 1.0 + (settings.productMarkupPercent / 100.0);
      final existing = await getById(poId);
      if (existing == null) return 0;

      int created = 0;
      for (final item in existing.items) {
        if (item.productId != null) continue;

        final existingProduct = await (_db.select(_db.productsTbl)
          ..where((t) => t.name.lower().equals(item.description.trim().toLowerCase()))
        ).getSingleOrNull();

        String productId;
        if (existingProduct != null) {
          productId = existingProduct.id;
        } else {
          final newId = const Uuid().v4();
          await _db.into(_db.productsTbl).insert(ProductsTblCompanion(
            id: Value(newId),
            name: Value(item.description.isNotEmpty ? item.description : 'PO Item'),
            sku: Value(null),
            barcode: Value(null),
            description: Value(null),
            category: Value('Purchased'),
            costPrice: Value(item.unitPrice),
            sellingPrice: Value(item.unitPrice > 0 ? item.unitPrice * markup : item.unitPrice),
            quantity: Value(item.quantity),
            reorderLevel: const Value(5),
            unit: const Value('pcs'),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ));
          productId = newId;
          created++;
        }

        await (_db.update(_db.poItemsTbl)..where((t) => t.id.equals(item.id))).write(
          PoItemsTblCompanion(
            productId: Value(productId),
            receivedQty: Value(item.quantity),
          ),
        );
      }
      return created;
    } catch (e) {
      debugPrint('PurchaseOrderDao.fixUnlinkedItems error: $e');
      rethrow;
    }
  }

  Future<List<PurchaseOrderItem>> _getItems(String poId) async {
    final rows = await (_db.select(_db.poItemsTbl)..where((t) => t.purchaseOrderId.equals(poId))).get();
    return rows.map((r) => PurchaseOrderItem(
      id: r.id,
      productId: r.productId,
      description: r.description,
      quantity: r.quantity,
      receivedQuantity: r.receivedQty,
      unitPrice: r.unitPrice,
      taxPercent: r.taxPercent,
      taxAmount: r.taxAmount,
      total: r.total,
    )).toList();
  }

  PurchaseOrder _toModel(PurchaseOrdersTblData row, List<PurchaseOrderItem> items) {
    return PurchaseOrder(
      id: row.id,
      supplierId: row.supplierId,
      poNumber: row.poNumber,
      issueDate: row.issueDate,
      expectedDate: row.expectedDate,
      subTotal: row.subTotal,
      taxTotal: row.taxTotal,
      totalAmount: row.totalAmount,
      status: row.status,
      items: items,
      notes: row.notes,
      createdAt: row.createdAt,
    );
  }

  PurchaseOrdersTblCompanion _toCompanion(PurchaseOrder model) {
    return PurchaseOrdersTblCompanion(
      id: Value(model.id),
      supplierId: Value(model.supplierId),
      poNumber: Value(model.poNumber),
      issueDate: Value(model.issueDate),
      expectedDate: Value(model.expectedDate),
      subTotal: Value(model.subTotal),
      taxTotal: Value(model.taxTotal),
      totalAmount: Value(model.totalAmount),
      status: Value(model.status),
      notes: Value(model.notes),
      createdAt: Value(model.createdAt),
    );
  }
}
