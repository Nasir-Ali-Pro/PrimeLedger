import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../database.dart';
import '../../models/stock_movement.dart';

class StockMovementDao {
  final AppDatabase _db;

  StockMovementDao(this._db);

  Future<List<StockMovement>> getByProductId(String productId) async {
    try {
      final rows = await (_db.select(_db.stockMovementsTbl)
        ..where((t) => t.productId.equals(productId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('StockMovementDao.getByProductId error: $e');
      rethrow;
    }
  }

  Future<List<StockMovement>> getAll() async {
    try {
      final rows = await (_db.select(_db.stockMovementsTbl)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('StockMovementDao.getAll error: $e');
      rethrow;
    }
  }

  Future<void> logMovement({
    required String productId,
    required String productName,
    required int quantityChange,
    required int balanceAfter,
    required String type,
    String referenceNumber = '',
    String? referenceId,
    String description = '',
  }) async {
    try {
      await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
        id: Value(const Uuid().v4()),
        productId: Value(productId),
        productName: Value(productName),
        quantityChange: Value(quantityChange),
        balanceAfter: Value(balanceAfter),
        type: Value(type),
        referenceNumber: Value(referenceNumber),
        referenceId: Value(referenceId),
        description: Value(description),
        createdAt: Value(DateTime.now()),
      ));
    } catch (e) {
      debugPrint('StockMovementDao.logMovement error: $e');
      rethrow;
    }
  }

  StockMovement _toModel(StockMovementsTblData row) {
    return StockMovement(
      id: row.id,
      productId: row.productId,
      productName: row.productName,
      quantityChange: row.quantityChange,
      balanceAfter: row.balanceAfter,
      type: row.type,
      referenceNumber: row.referenceNumber,
      referenceId: row.referenceId,
      description: row.description,
      createdAt: row.createdAt,
    );
  }
}
