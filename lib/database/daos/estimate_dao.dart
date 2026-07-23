import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/estimate.dart';
import 'package:uuid/uuid.dart';

class EstimateDao {
  final AppDatabase _db;

  EstimateDao(this._db);

  Future<List<Estimate>> getAll() async {
    try {
      final rows = await _db.select(_db.estimatesTbl).get();
      if (rows.isEmpty) return [];
      final ids = rows.map((r) => r.id).toList();
      final allItems = await (_db.select(_db.estimateItemsTbl)
        ..where((t) => t.estimateId.isIn(ids))
      ).get();
      final itemMap = <String, List<EstimateItemsTblData>>{};
      for (final item in allItems) {
        itemMap.putIfAbsent(item.estimateId, () => []).add(item);
      }
      return rows.map((row) {
        final items = itemMap[row.id] ?? [];
        return _toModel(row, items.map((r) => EstimateItem(
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
      debugPrint('EstimateDao.getAll error: $e');
      rethrow;
    }
  }

  Future<Estimate?> getById(String id) async {
    try {
      final row = await (_db.select(_db.estimatesTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      if (row == null) return null;
      final items = await _getItems(row.id);
      return _toModel(row, items);
    } catch (e) {
      debugPrint('EstimateDao.getById error: $e');
      rethrow;
    }
  }

  Future<List<Estimate>> getByClientId(String clientId) async {
    try {
      final rows = await (_db.select(_db.estimatesTbl)..where((t) => t.clientId.equals(clientId))).get();
      if (rows.isEmpty) return [];
      final ids = rows.map((r) => r.id).toList();
      final allItems = await (_db.select(_db.estimateItemsTbl)
        ..where((t) => t.estimateId.isIn(ids))
      ).get();
      final itemMap = <String, List<EstimateItemsTblData>>{};
      for (final item in allItems) {
        itemMap.putIfAbsent(item.estimateId, () => []).add(item);
      }
      return rows.map((row) {
        final items = itemMap[row.id] ?? [];
        return _toModel(row, items.map((r) => EstimateItem(
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
      debugPrint('EstimateDao.getByClientId error: $e');
      rethrow;
    }
  }

  Future<void> insert(Estimate estimate) async {
    try {
      await _db.transaction(() async {
        await _db.into(_db.estimatesTbl).insert(_toCompanion(estimate));
        for (final item in estimate.items) {
          await _db.into(_db.estimateItemsTbl).insert(EstimateItemsTblCompanion(
            id: Value(const Uuid().v4()),
            estimateId: Value(estimate.id),
            productId: Value(item.productId),
            description: Value(item.description),
            quantity: Value(item.quantity),
            rate: Value(item.rate),
            taxPercent: Value(item.taxPercent),
            taxAmount: Value(item.taxAmount),
            discountPercent: Value(item.discountPercent),
            total: Value(item.total),
          ));
        }
      });
    } catch (e) {
      debugPrint('EstimateDao.insert error: $e');
      rethrow;
    }
  }

  Future<void> update(Estimate estimate) async {
    try {
      await _db.transaction(() async {
        await (_db.update(_db.estimatesTbl)..where((t) => t.id.equals(estimate.id))).write(_toCompanion(estimate));
        await (_db.delete(_db.estimateItemsTbl)..where((t) => t.estimateId.equals(estimate.id))).go();
        for (final item in estimate.items) {
          await _db.into(_db.estimateItemsTbl).insert(EstimateItemsTblCompanion(
            id: Value(const Uuid().v4()),
            estimateId: Value(estimate.id),
            productId: Value(item.productId),
            description: Value(item.description),
            quantity: Value(item.quantity),
            rate: Value(item.rate),
            taxPercent: Value(item.taxPercent),
            taxAmount: Value(item.taxAmount),
            discountPercent: Value(item.discountPercent),
            total: Value(item.total),
          ));
        }
      });
    } catch (e) {
      debugPrint('EstimateDao.update error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await (_db.delete(_db.estimatesTbl)..where((t) => t.id.equals(id))).go();
    } catch (e) {
      debugPrint('EstimateDao.delete error: $e');
      rethrow;
    }
  }

  Future<List<EstimateItem>> _getItems(String estimateId) async {
    final rows = await (_db.select(_db.estimateItemsTbl)..where((t) => t.estimateId.equals(estimateId))).get();
    return rows.map((r) => EstimateItem(
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

  Estimate _toModel(EstimatesTblData row, List<EstimateItem> items) {
    return Estimate(
      id: row.id,
      clientId: row.clientId,
      estimateNumber: row.estimateNumber,
      issueDate: row.issueDate,
      expiryDate: row.expiryDate,
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

  EstimatesTblCompanion _toCompanion(Estimate model) {
    return EstimatesTblCompanion(
      id: Value(model.id),
      clientId: Value(model.clientId),
      estimateNumber: Value(model.estimateNumber),
      issueDate: Value(model.issueDate),
      expiryDate: Value(model.expiryDate),
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
}
