import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/supplier.dart';

class SupplierDao {
  final AppDatabase _db;

  SupplierDao(this._db);

  Future<List<Supplier>> getAll() async {
    try {
      final rows = await _db.select(_db.suppliersTbl).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('SupplierDao.getAll error: $e');
      rethrow;
    }
  }

  Future<Supplier?> getById(String id) async {
    try {
      final row = await (_db.select(_db.suppliersTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      return row != null ? _toModel(row) : null;
    } catch (e) {
      debugPrint('SupplierDao.getById error: $e');
      rethrow;
    }
  }

  Future<void> insert(Supplier supplier) async {
    try {
      await _db.into(_db.suppliersTbl).insert(_toCompanion(supplier));
    } catch (e) {
      debugPrint('SupplierDao.insert error: $e');
      rethrow;
    }
  }

  Future<void> update(Supplier supplier) async {
    try {
      await (_db.update(_db.suppliersTbl)..where((t) => t.id.equals(supplier.id))).write(_toCompanion(supplier));
    } catch (e) {
      debugPrint('SupplierDao.update error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await _db.transaction(() async {
        // Check if there are any purchase orders
        final poCount = await (_db.select(_db.purchaseOrdersTbl)..where((t) => t.supplierId.equals(id))).get();
        if (poCount.isNotEmpty) {
          throw Exception(
            'Cannot delete supplier because they have existing history '
            '(${poCount.length} Purchase Orders). '
            'Please delete these purchase orders first.'
          );
        }
        await (_db.delete(_db.suppliersTbl)..where((t) => t.id.equals(id))).go();
      });
    } catch (e) {
      debugPrint('SupplierDao.delete error: $e');
      rethrow;
    }
  }

  Supplier _toModel(SuppliersTblData row) {
    return Supplier(
      id: row.id,
      name: row.name,
      email: row.email,
      phone: row.phone,
      address: row.address,
      contactPerson: row.contactPerson,
      taxId: row.taxId,
      createdAt: row.createdAt,
    );
  }

  SuppliersTblCompanion _toCompanion(Supplier model) {
    return SuppliersTblCompanion(
      id: Value(model.id),
      name: Value(model.name),
      email: Value(model.email),
      phone: Value(model.phone),
      address: Value(model.address),
      contactPerson: Value(model.contactPerson),
      taxId: Value(model.taxId),
      createdAt: Value(model.createdAt),
    );
  }
}
