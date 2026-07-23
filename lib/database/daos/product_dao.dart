import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../database.dart';
import '../../models/product.dart';

class ProductDao {
  final AppDatabase _db;

  ProductDao(this._db);

  Future<List<Product>> getAll() async {
    try {
      final rows = await _db.select(_db.productsTbl).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('ProductDao.getAll error: $e');
      rethrow;
    }
  }

  Future<Product?> getById(String id) async {
    try {
      final row = await (_db.select(_db.productsTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      return row != null ? _toModel(row) : null;
    } catch (e) {
      debugPrint('ProductDao.getById error: $e');
      rethrow;
    }
  }

  Future<Product?> getByBarcode(String barcode) async {
    try {
      final row = await (_db.select(_db.productsTbl)..where((t) => t.barcode.equals(barcode))).getSingleOrNull();
      return row != null ? _toModel(row) : null;
    } catch (e) {
      debugPrint('ProductDao.getByBarcode error: $e');
      rethrow;
    }
  }

  Future<void> insert(Product product) async {
    try {
      await _db.into(_db.productsTbl).insert(_toCompanion(product));
    } catch (e) {
      debugPrint('ProductDao.insert error: $e');
      rethrow;
    }
  }

  Future<void> update(Product product) async {
    try {
      await (_db.update(_db.productsTbl)..where((t) => t.id.equals(product.id))).write(_toCompanion(product));
    } catch (e) {
      debugPrint('ProductDao.update error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await _db.transaction(() async {
        final invoiceCount = await (_db.select(_db.invoiceItemsTbl)..where((t) => t.productId.equals(id))).get();
        final estimateCount = await (_db.select(_db.estimateItemsTbl)..where((t) => t.productId.equals(id))).get();
        final poCount = await (_db.select(_db.poItemsTbl)..where((t) => t.productId.equals(id))).get();

        if (invoiceCount.isNotEmpty || estimateCount.isNotEmpty || poCount.isNotEmpty) {
          throw Exception(
            'Cannot delete product because it has existing history '
            '(${invoiceCount.length} Invoices, ${estimateCount.length} Estimates, '
            '${poCount.length} Purchase Orders). '
            'Please delete these transactions first.'
          );
        }

        // Delete associated stock movements
        await (_db.delete(_db.stockMovementsTbl)..where((t) => t.productId.equals(id))).go();
        // Delete the product itself
        await (_db.delete(_db.productsTbl)..where((t) => t.id.equals(id))).go();
      });
    } catch (e) {
      debugPrint('ProductDao.delete error: $e');
      rethrow;
    }
  }

  Future<void> adjustStock(String id, int adjustment) async {
    try {
      await _db.transaction(() async {
        final product = await getById(id);
        if (product != null) {
          final newQty = (product.quantity + adjustment).clamp(0, 999999);
          final updated = Product(
            id: product.id,
            name: product.name,
            sku: product.sku,
            barcode: product.barcode,
            description: product.description,
            category: product.category,
            costPrice: product.costPrice,
            sellingPrice: product.sellingPrice,
            quantity: newQty,
            reorderLevel: product.reorderLevel,
            unit: product.unit,
            createdAt: product.createdAt,
            updatedAt: DateTime.now(),
          );
          await update(updated);
          await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
            id: Value(const Uuid().v4()),
            productId: Value(product.id),
            productName: Value(product.name),
            quantityChange: Value(adjustment),
            balanceAfter: Value(newQty),
            type: const Value('Adjustment'),
            referenceNumber: const Value(''),
            referenceId: Value(null),
            description: Value(adjustment > 0 ? 'Manual stock increase' : 'Manual stock reduction'),
            createdAt: Value(DateTime.now()),
          ));
        }
      });
    } catch (e) {
      debugPrint('ProductDao.adjustStock error: $e');
      rethrow;
    }
  }

  Product _toModel(ProductsTblData row) {
    return Product(
      id: row.id,
      name: row.name,
      sku: row.sku,
      barcode: row.barcode,
      description: row.description,
      category: row.category,
      costPrice: row.costPrice,
      sellingPrice: row.sellingPrice,
      quantity: row.quantity,
      reorderLevel: row.reorderLevel,
      unit: row.unit,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  ProductsTblCompanion _toCompanion(Product model) {
    return ProductsTblCompanion(
      id: Value(model.id),
      name: Value(model.name),
      sku: Value(model.sku),
      barcode: Value(model.barcode),
      description: Value(model.description),
      category: Value(model.category),
      costPrice: Value(model.costPrice),
      sellingPrice: Value(model.sellingPrice),
      quantity: Value(model.quantity),
      reorderLevel: Value(model.reorderLevel),
      unit: Value(model.unit),
      createdAt: Value(model.createdAt),
      updatedAt: Value(model.updatedAt),
    );
  }
}
