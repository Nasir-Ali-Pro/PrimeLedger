import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/expense.dart';
import '../database/database_provider.dart';
import 'invoice_provider.dart';

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
      final expense = await ref.read(expenseDaoProvider).getById(id);
      if (expense != null && expense.invoiceId != null) {
        final linkedInv = await ref.read(invoiceDaoProvider).getById(expense.invoiceId!);
        if (linkedInv != null) {
          final markedUpPrice = expense.amount * (1 + expense.markupPercent / 100);
          final updatedItems = linkedInv.items.where((item) {
            if (item.expenseId == id) return false;
            if (item.expenseId == null && item.description == expense.description && (item.rate - markedUpPrice).abs() < 0.05) {
              return false;
            }
            return true;
          }).toList();

          if (updatedItems.length != linkedInv.items.length) {
            double subTotal = 0;
            double taxTotal = 0;
            for (final item in updatedItems) {
              subTotal += item.quantity * item.rate;
              taxTotal += item.taxAmount;
            }
            final discountAmt = subTotal * (linkedInv.discountPercent / 100);
            final netAfterDiscount = subTotal - discountAmt;
            final withholdingAmt = netAfterDiscount * (linkedInv.withholdingTaxPercent / 100);
            final totalAmount = netAfterDiscount + taxTotal - withholdingAmt;

            final updatedInvoice = linkedInv.copyWith(
              items: updatedItems,
              subTotal: subTotal,
              taxTotal: taxTotal,
              totalAmount: totalAmount,
              discountAmount: discountAmt,
              withholdingTaxAmount: withholdingAmt,
            );
            await ref.read(invoiceDaoProvider).update(updatedInvoice);
            await ref.read(invoicesProvider.notifier).refresh();
          }
        }
      }

      await ref.read(expenseDaoProvider).delete(id);
      await _load();
    } catch (e) {
      debugPrint('Error deleting expense: $e');
      rethrow;
    }
  }
}
