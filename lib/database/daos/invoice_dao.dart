import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/invoice.dart';
import 'package:uuid/uuid.dart';

class InvoiceDao {
  final AppDatabase _db;

  InvoiceDao(this._db);

  Future<List<Invoice>> getAll() async {
    try {
      final rows = await _db.select(_db.invoicesTbl).get();
      if (rows.isEmpty) return [];
      final ids = rows.map((r) => r.id).toList();
      final allItems = await (_db.select(_db.invoiceItemsTbl)
        ..where((t) => t.invoiceId.isIn(ids))
      ).get();
      final itemMap = <String, List<InvoiceItemsTblData>>{};
      for (final item in allItems) {
        itemMap.putIfAbsent(item.invoiceId, () => []).add(item);
      }
      return rows.map((row) {
        final items = itemMap[row.id] ?? [];
        return _toModel(row, items.map((r) => InvoiceItem(
          id: r.id,
          productId: r.productId,
          description: r.description,
          quantity: r.quantity,
          rate: r.rate,
          taxPercent: r.taxPercent,
          taxAmount: r.taxAmount,
          discountPercent: r.discountPercent,
          total: r.total,
        )).toList());
      }).toList();
    } catch (e) {
      debugPrint('InvoiceDao.getAll error: $e');
      rethrow;
    }
  }

  Future<Invoice?> getById(String id) async {
    try {
      final row = await (_db.select(_db.invoicesTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      if (row == null) return null;
      final items = await _getItems(row.id);
      return _toModel(row, items);
    } catch (e) {
      debugPrint('InvoiceDao.getById error: $e');
      rethrow;
    }
  }

  Future<List<Invoice>> getByClientId(String clientId) async {
    try {
      final rows = await (_db.select(_db.invoicesTbl)..where((t) => t.clientId.equals(clientId))).get();
      if (rows.isEmpty) return [];
      final ids = rows.map((r) => r.id).toList();
      final allItems = await (_db.select(_db.invoiceItemsTbl)
        ..where((t) => t.invoiceId.isIn(ids))
      ).get();
      final itemMap = <String, List<InvoiceItemsTblData>>{};
      for (final item in allItems) {
        itemMap.putIfAbsent(item.invoiceId, () => []).add(item);
      }
      return rows.map((row) {
        final items = itemMap[row.id] ?? [];
        return _toModel(row, items.map((r) => InvoiceItem(
          id: r.id,
          productId: r.productId,
          description: r.description,
          quantity: r.quantity,
          rate: r.rate,
          taxPercent: r.taxPercent,
          taxAmount: r.taxAmount,
          discountPercent: r.discountPercent,
          total: r.total,
        )).toList());
      }).toList();
    } catch (e) {
      debugPrint('InvoiceDao.getByClientId error: $e');
      rethrow;
    }
  }

  Future<void> insert(Invoice invoice) async {
    try {
      await _db.transaction(() async {
        await _db.into(_db.invoicesTbl).insert(_toCompanion(invoice));
        for (final item in invoice.items) {
          await _db.into(_db.invoiceItemsTbl).insert(InvoiceItemsTblCompanion(
            id: Value(item.id.isNotEmpty ? item.id : _generateId()),
            invoiceId: Value(invoice.id),
            productId: Value(item.productId),
            description: Value(item.description),
            quantity: Value(item.quantity),
            rate: Value(item.rate),
            taxPercent: Value(item.taxPercent),
            taxAmount: Value(item.taxAmount),
            discountPercent: Value(item.discountPercent),
            total: Value(item.total),
          ));
          final isDeducting = _isDeductingStatus(invoice.status);
          if (item.productId != null && isDeducting) {
            await _adjustProductStock(item.productId!, -item.quantity,
              type: 'Sale',
              referenceNumber: invoice.invoiceNumber,
              description: item.description.isNotEmpty ? item.description : invoice.invoiceNumber);
          }
        }
      });
    } catch (e) {
      debugPrint('InvoiceDao.insert error: $e');
      rethrow;
    }
  }

  bool _isDeductingStatus(String status) => status != 'Draft' && status != 'Cancelled';

  Future<void> update(Invoice invoice) async {
    try {
      await _db.transaction(() async {
        final oldInvoice = await (_db.select(_db.invoicesTbl)..where((t) => t.id.equals(invoice.id))).getSingleOrNull();
        final oldItems = await _getItems(invoice.id);
        final newStatus = invoice.status;

        final wasDeducting = oldInvoice != null && _isDeductingStatus(oldInvoice.status);
        final isNowDeducting = _isDeductingStatus(newStatus);
        final itemsChanged = _haveItemsChanged(oldItems, invoice.items);

        final shouldRestock = wasDeducting && (!isNowDeducting || itemsChanged);
        if (shouldRestock) {
          for (final old in oldItems) {
            if (old.productId != null) {
              await _adjustProductStock(old.productId!, old.quantity,
                type: 'Restock',
                referenceNumber: invoice.invoiceNumber,
                description: !isNowDeducting ? 'Invoice status updated to $newStatus' : 'Reversal from invoice update');
            }
          }
        }

        final updatedInvoice = invoice.copyWith(status: newStatus);

        await (_db.update(_db.invoicesTbl)..where((t) => t.id.equals(invoice.id))).write(_toCompanion(updatedInvoice));
        await (_db.delete(_db.invoiceItemsTbl)..where((t) => t.invoiceId.equals(invoice.id))).go();
        for (final item in invoice.items) {
          await _db.into(_db.invoiceItemsTbl).insert(InvoiceItemsTblCompanion(
            id: Value(item.id.isNotEmpty ? item.id : _generateId()),
            invoiceId: Value(invoice.id),
            productId: Value(item.productId),
            description: Value(item.description),
            quantity: Value(item.quantity),
            rate: Value(item.rate),
            taxPercent: Value(item.taxPercent),
            taxAmount: Value(item.taxAmount),
            discountPercent: Value(item.discountPercent),
            total: Value(item.total),
          ));
          final shouldDeduct = isNowDeducting && (!wasDeducting || itemsChanged);
          if (item.productId != null && shouldDeduct) {
            await _adjustProductStock(item.productId!, -item.quantity,
              type: 'Sale',
              referenceNumber: invoice.invoiceNumber,
              description: item.description.isNotEmpty ? item.description : invoice.invoiceNumber);
          }
        }
      });
    } catch (e) {
      debugPrint('InvoiceDao.update error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await _db.transaction(() async {
        final items = await _getItems(id);
        final invoice = await (_db.select(_db.invoicesTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
        if (invoice != null && _isDeductingStatus(invoice.status)) {
          for (final item in items) {
            if (item.productId != null) {
              await _adjustProductStock(item.productId!, item.quantity,
                type: 'Restock',
                referenceNumber: invoice.invoiceNumber,
                description: 'Invoice deleted');
            }
          }
        }
        // Manually delete child records first to prevent foreign key constraint violations
        await (_db.delete(_db.paymentsTbl)..where((t) => t.invoiceId.equals(id))).go();
        await (_db.delete(_db.invoiceItemsTbl)..where((t) => t.invoiceId.equals(id))).go();
        await (_db.delete(_db.invoicesTbl)..where((t) => t.id.equals(id))).go();
      });
    } catch (e) {
      debugPrint('InvoiceDao.delete error: $e');
      rethrow;
    }
  }

  Future<void> _adjustProductStock(String productId, int delta, {String type = 'Sale', String referenceNumber = '', String description = ''}) async {
    final product = await (_db.select(_db.productsTbl)..where((t) => t.id.equals(productId))).getSingleOrNull();
    if (product != null) {
      final newQty = (product.quantity + delta).clamp(0, 999999);
      await (_db.update(_db.productsTbl)..where((t) => t.id.equals(productId))).write(
        ProductsTblCompanion(
          quantity: Value(newQty),
          updatedAt: Value(DateTime.now()),
        ),
      );
      await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
        id: Value(_generateId()),
        productId: Value(productId),
        productName: Value(product.name),
        quantityChange: Value(delta),
        balanceAfter: Value(newQty),
        type: Value(type),
        referenceNumber: Value(referenceNumber),
        referenceId: Value(null),
        description: Value(description),
        createdAt: Value(DateTime.now()),
      ));
    }
  }

  Future<List<InvoiceItem>> _getItems(String invoiceId) async {
    final rows = await (_db.select(_db.invoiceItemsTbl)..where((t) => t.invoiceId.equals(invoiceId))).get();
    return rows.map((r) => InvoiceItem(
      id: r.id,
      productId: r.productId,
      description: r.description,
      quantity: r.quantity,
      rate: r.rate,
      taxPercent: r.taxPercent,
      taxAmount: r.taxAmount,
      discountPercent: r.discountPercent,
      total: r.total,
    )).toList();
  }

  Invoice _toModel(InvoicesTblData row, List<InvoiceItem> items) {
    return Invoice(
      id: row.id,
      clientId: row.clientId,
      invoiceNumber: row.invoiceNumber,
      issueDate: row.issueDate,
      dueDate: row.dueDate,
      subTotal: row.subTotal,
      taxTotal: row.taxTotal,
      totalAmount: row.totalAmount,
      status: row.status,
      items: items,
      notes: row.notes,
      createdAt: row.createdAt,
      discountPercent: row.discountPercent,
      discountAmount: row.discountAmount,
      withholdingTaxPercent: row.withholdingTaxPercent,
      withholdingTaxAmount: row.withholdingTaxAmount,
      tax2Percent: row.tax2Percent,
    );
  }

  InvoicesTblCompanion _toCompanion(Invoice model) {
    return InvoicesTblCompanion(
      id: Value(model.id),
      clientId: Value(model.clientId),
      invoiceNumber: Value(model.invoiceNumber),
      issueDate: Value(model.issueDate),
      dueDate: Value(model.dueDate),
      subTotal: Value(model.subTotal),
      taxTotal: Value(model.taxTotal),
      totalAmount: Value(model.totalAmount),
      status: Value(model.status),
      notes: Value(model.notes),
      createdAt: Value(model.createdAt),
      discountPercent: Value(model.discountPercent),
      discountAmount: Value(model.discountAmount),
      withholdingTaxPercent: Value(model.withholdingTaxPercent),
      withholdingTaxAmount: Value(model.withholdingTaxAmount),
      tax2Percent: Value(model.tax2Percent),
    );
  }

  String _generateId() => const Uuid().v4();

  bool _haveItemsChanged(List<InvoiceItem> oldItems, List<InvoiceItem> newItems) {
    if (oldItems.length != newItems.length) return true;
    for (int i = 0; i < oldItems.length; i++) {
      if (oldItems[i].productId != newItems[i].productId ||
          oldItems[i].quantity != newItems[i].quantity) {
        return true;
      }
    }
    return false;
  }
}
