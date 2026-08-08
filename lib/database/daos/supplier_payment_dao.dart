import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/supplier_payment.dart';

class SupplierPaymentDao {
  final AppDatabase _db;

  SupplierPaymentDao(this._db);

  Future<List<SupplierPayment>> getAll() async {
    try {
      final rows = await (_db.select(_db.supplierPaymentsTbl)
        ..orderBy([
          (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ])
      ).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('SupplierPaymentDao.getAll error: $e');
      rethrow;
    }
  }

  Future<SupplierPayment?> getById(String id) async {
    try {
      final row = await (_db.select(_db.supplierPaymentsTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      return row != null ? _toModel(row) : null;
    } catch (e) {
      debugPrint('SupplierPaymentDao.getById error: $e');
      rethrow;
    }
  }

  Future<List<SupplierPayment>> getByPurchaseOrderId(String poId) async {
    try {
      final rows = await (_db.select(_db.supplierPaymentsTbl)..where((t) => t.purchaseOrderId.equals(poId))).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('SupplierPaymentDao.getByPurchaseOrderId error: $e');
      rethrow;
    }
  }

  Future<double> getTotalByPurchaseOrderId(String poId) async {
    try {
      final rows = await (_db.select(_db.supplierPaymentsTbl)..where((t) => t.purchaseOrderId.equals(poId))).get();
      return rows.fold<double>(0.0, (sum, p) => sum + p.amount);
    } catch (e) {
      debugPrint('SupplierPaymentDao.getTotalByPurchaseOrderId error: $e');
      rethrow;
    }
  }

  Future<void> insert(SupplierPayment payment) async {
    try {
      await _db.transaction(() async {
        // Verify payment won't exceed purchase order balance
        final poRow = await (_db.select(_db.purchaseOrdersTbl)..where((t) => t.id.equals(payment.purchaseOrderId))).getSingleOrNull();
        if (poRow != null) {
          final existingPayments = await (_db.select(_db.supplierPaymentsTbl)..where((t) => t.purchaseOrderId.equals(payment.purchaseOrderId))).get();
          final totalPaid = existingPayments.fold<double>(0.0, (sum, p) => sum + p.amount);
          if (totalPaid + payment.amount > poRow.totalAmount + 0.01) {
            throw Exception('Payment of ${payment.amount} would exceed Purchase Order balance. Already paid: $totalPaid, Purchase Order total: ${poRow.totalAmount}');
          }
        }

        await _db.into(_db.supplierPaymentsTbl).insert(_toCompanion(payment));
      });
    } catch (e) {
      debugPrint('SupplierPaymentDao.insert error: $e');
      rethrow;
    }
  }

  Future<void> update(SupplierPayment payment) async {
    try {
      await _db.transaction(() async {
        // Verify payment won't exceed the target purchase order balance
        final poRow = await (_db.select(_db.purchaseOrdersTbl)..where((t) => t.id.equals(payment.purchaseOrderId))).getSingleOrNull();
        if (poRow != null) {
          final existingPayments = await (_db.select(_db.supplierPaymentsTbl)
            ..where((t) => t.purchaseOrderId.equals(payment.purchaseOrderId) & t.id.equals(payment.id).not())
          ).get();
          final totalPaidOther = existingPayments.fold<double>(0.0, (sum, p) => sum + p.amount);
          if (totalPaidOther + payment.amount > poRow.totalAmount + 0.01) {
            throw Exception('Payment of ${payment.amount} would exceed Purchase Order balance. Already paid by others: $totalPaidOther, Purchase Order total: ${poRow.totalAmount}');
          }
        }

        // Update the payment record
        await (_db.update(_db.supplierPaymentsTbl)..where((t) => t.id.equals(payment.id))).write(_toCompanion(payment));
      });
    } catch (e) {
      debugPrint('SupplierPaymentDao.update error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await _db.transaction(() async {
        await (_db.delete(_db.supplierPaymentsTbl)..where((t) => t.id.equals(id))).go();
      });
    } catch (e) {
      debugPrint('SupplierPaymentDao.delete error: $e');
      rethrow;
    }
  }

  SupplierPayment _toModel(SupplierPaymentsTblData row) {
    return SupplierPayment(
      id: row.id,
      purchaseOrderId: row.purchaseOrderId,
      supplierId: row.supplierId,
      amount: row.amount,
      date: row.date,
      paymentMethod: row.paymentMethod,
      referenceNumber: row.referenceNumber,
      notes: row.notes,
      createdAt: row.createdAt,
    );
  }

  SupplierPaymentsTblCompanion _toCompanion(SupplierPayment model) {
    return SupplierPaymentsTblCompanion(
      id: Value(model.id),
      purchaseOrderId: Value(model.purchaseOrderId),
      supplierId: Value(model.supplierId),
      amount: Value(model.amount),
      date: Value(model.date),
      paymentMethod: Value(model.paymentMethod),
      referenceNumber: Value(model.referenceNumber),
      notes: Value(model.notes),
      createdAt: Value(model.createdAt),
    );
  }
}
