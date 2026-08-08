import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/recurring_profile.dart';

class RecurringProfileDao {
  final AppDatabase _db;

  RecurringProfileDao(this._db);

  Future<List<RecurringProfile>> getAll() async {
    try {
      final rows = await _db.select(_db.recurringProfilesTbl).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('RecurringProfileDao.getAll error: $e');
      rethrow;
    }
  }

  Future<RecurringProfile?> getById(String id) async {
    try {
      final row = await (_db.select(_db.recurringProfilesTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      return row != null ? _toModel(row) : null;
    } catch (e) {
      debugPrint('RecurringProfileDao.getById error: $e');
      rethrow;
    }
  }

  Future<List<RecurringProfile>> getDueProfiles() async {
    try {
      final now = DateTime.now();
      final rows = await (_db.select(_db.recurringProfilesTbl)
        ..where((t) => t.isActive.equals(true))
        ..where((t) => t.nextIssueDate.isSmallerThan(Variable<DateTime>(now)))
      ).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('RecurringProfileDao.getDueProfiles error: $e');
      rethrow;
    }
  }

  Future<void> insert(RecurringProfile profile) async {
    try {
      await _db.into(_db.recurringProfilesTbl).insert(_toCompanion(profile));
    } catch (e) {
      debugPrint('RecurringProfileDao.insert error: $e');
      rethrow;
    }
  }

  Future<void> update(RecurringProfile profile) async {
    try {
      await (_db.update(_db.recurringProfilesTbl)..where((t) => t.id.equals(profile.id))).write(_toCompanion(profile));
    } catch (e) {
      debugPrint('RecurringProfileDao.update error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await (_db.delete(_db.recurringProfilesTbl)..where((t) => t.id.equals(id))).go();
    } catch (e) {
      debugPrint('RecurringProfileDao.delete error: $e');
      rethrow;
    }
  }

  RecurringProfile _toModel(RecurringProfilesTblData row) {
    return RecurringProfile(
      id: row.id,
      clientId: row.clientId,
      frequency: row.frequency,
      startDate: row.startDate ?? row.nextIssueDate,
      endDate: row.endDate,
      nextIssueDate: row.nextIssueDate,
      amount: row.amount,
      description: row.description,
      isActive: row.isActive,
      createdAt: row.createdAt,
    );
  }

  RecurringProfilesTblCompanion _toCompanion(RecurringProfile model) {
    return RecurringProfilesTblCompanion(
      id: Value(model.id),
      clientId: Value(model.clientId),
      frequency: Value(model.frequency),
      startDate: Value(model.startDate),
      endDate: Value(model.endDate),
      nextIssueDate: Value(model.nextIssueDate),
      amount: Value(model.amount),
      description: Value(model.description),
      isActive: Value(model.isActive),
      createdAt: Value(model.createdAt),
    );
  }
}
