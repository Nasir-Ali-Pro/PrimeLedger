import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/time_entry.dart';

class TimeEntryDao {
  final AppDatabase _db;

  TimeEntryDao(this._db);

  Future<List<TimeEntry>> getAll() async {
    try {
      final rows = await _db.select(_db.timeEntriesTbl).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('TimeEntryDao.getAll error: $e');
      rethrow;
    }
  }

  Future<TimeEntry?> getById(String id) async {
    try {
      final row = await (_db.select(_db.timeEntriesTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      return row != null ? _toModel(row) : null;
    } catch (e) {
      debugPrint('TimeEntryDao.getById error: $e');
      rethrow;
    }
  }

  Future<List<TimeEntry>> getByClientId(String clientId) async {
    try {
      final rows = await (_db.select(_db.timeEntriesTbl)..where((t) => t.clientId.equals(clientId))).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('TimeEntryDao.getByClientId error: $e');
      rethrow;
    }
  }

  Future<void> insert(TimeEntry entry) async {
    try {
      await _db.into(_db.timeEntriesTbl).insert(_toCompanion(entry));
    } catch (e) {
      debugPrint('TimeEntryDao.insert error: $e');
      rethrow;
    }
  }

  Future<void> update(TimeEntry entry) async {
    try {
      await (_db.update(_db.timeEntriesTbl)..where((t) => t.id.equals(entry.id))).write(_toCompanion(entry));
    } catch (e) {
      debugPrint('TimeEntryDao.update error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await (_db.delete(_db.timeEntriesTbl)..where((t) => t.id.equals(id))).go();
    } catch (e) {
      debugPrint('TimeEntryDao.delete error: $e');
      rethrow;
    }
  }

  TimeEntry _toModel(TimeEntriesTblData row) {
    return TimeEntry(
      id: row.id,
      clientId: row.clientId,
      taskName: row.taskName,
      description: row.description,
      date: row.date,
      hours: row.hours,
      rate: row.rate,
      isBillable: row.isBillable,
      isInvoiced: row.isInvoiced,
      createdAt: row.createdAt,
    );
  }

  TimeEntriesTblCompanion _toCompanion(TimeEntry model) {
    return TimeEntriesTblCompanion(
      id: Value(model.id),
      clientId: Value(model.clientId),
      taskName: Value(model.taskName),
      description: Value(model.description),
      date: Value(model.date),
      hours: Value(model.hours),
      rate: Value(model.rate),
      isBillable: Value(model.isBillable),
      isInvoiced: Value(model.isInvoiced),
      createdAt: Value(model.createdAt),
    );
  }
}
