import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/expense.dart';
import '../database/database_provider.dart';

final expensesProvider = NotifierProvider<ExpensesNotifier, List<Expense>>(() {
  return ExpensesNotifier();
});

class ExpensesNotifier extends Notifier<List<Expense>> {
  @override
  List<Expense> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final expenses = await ref.read(expenseDaoProvider).getAll();
      state = expenses;
    } catch (e) {
      debugPrint('Error loading expenses: $e');
    }
  }

  Future<void> refresh() async {
    await _load();
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await ref.read(expenseDaoProvider).insert(expense);
      await _load();
    } catch (e) {
      debugPrint('Error adding expense: $e');
      rethrow;
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      await ref.read(expenseDaoProvider).update(expense);
      await _load();
    } catch (e) {
      debugPrint('Error updating expense: $e');
      rethrow;
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await ref.read(expenseDaoProvider).delete(id);
      await _load();
    } catch (e) {
      debugPrint('Error deleting expense: $e');
      rethrow;
    }
  }
}
