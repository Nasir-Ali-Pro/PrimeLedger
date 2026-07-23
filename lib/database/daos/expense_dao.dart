import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/expense.dart';

class ExpenseDao {
  final AppDatabase _db;

  ExpenseDao(this._db);

  Future<List<Expense>> getAll() async {
    try {
      final rows = await _db.select(_db.expensesTbl).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('ExpenseDao.getAll error: $e');
      rethrow;
    }
  }

  Future<Expense?> getById(String id) async {
    try {
      final row = await (_db.select(_db.expensesTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      return row != null ? _toModel(row) : null;
    } catch (e) {
      debugPrint('ExpenseDao.getById error: $e');
      rethrow;
    }
  }

  Future<List<Expense>> getByCategory(String category) async {
    try {
      final rows = await (_db.select(_db.expensesTbl)..where((t) => t.category.equals(category))).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('ExpenseDao.getByCategory error: $e');
      rethrow;
    }
  }

  Future<List<Expense>> getByDateRange(DateTime start, DateTime end) async {
    try {
      final rows = await (_db.select(_db.expensesTbl)..where((t) => t.date.isBetweenValues(start, end))).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('ExpenseDao.getByDateRange error: $e');
      rethrow;
    }
  }

  Future<void> insert(Expense expense) async {
    try {
      await _db.into(_db.expensesTbl).insert(_toCompanion(expense));
    } catch (e) {
      debugPrint('ExpenseDao.insert error: $e');
      rethrow;
    }
  }

  Future<void> update(Expense expense) async {
    try {
      await (_db.update(_db.expensesTbl)..where((t) => t.id.equals(expense.id))).write(_toCompanion(expense));
    } catch (e) {
      debugPrint('ExpenseDao.update error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await (_db.delete(_db.expensesTbl)..where((t) => t.id.equals(id))).go();
    } catch (e) {
      debugPrint('ExpenseDao.delete error: $e');
      rethrow;
    }
  }

  Expense _toModel(ExpensesTblData row) {
    return Expense(
      id: row.id,
      description: row.description,
      amount: row.amount,
      category: row.category,
      date: row.date,
      clientId: row.clientId,
      isBillable: row.isBillable,
      receiptPath: row.receiptPath,
      notes: row.notes,
      createdAt: row.createdAt,
      markupPercent: row.markupPercent,
      invoiceId: row.invoiceId,
    );
  }

  ExpensesTblCompanion _toCompanion(Expense model) {
    return ExpensesTblCompanion(
      id: Value(model.id),
      description: Value(model.description),
      amount: Value(model.amount),
      category: Value(model.category),
      date: Value(model.date),
      clientId: Value(model.clientId),
      isBillable: Value(model.isBillable),
      receiptPath: Value(model.receiptPath),
      notes: Value(model.notes),
      createdAt: Value(model.createdAt),
      markupPercent: Value(model.markupPercent),
      invoiceId: Value(model.invoiceId),
    );
  }
}
