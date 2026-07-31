import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/invoice.dart';
import '../database/database_provider.dart';
import 'product_provider.dart';
import 'payment_provider.dart';
import 'expense_provider.dart';
import '../models/payment.dart';
import 'package:uuid/uuid.dart';

final invoicesProvider = NotifierProvider<InvoicesNotifier, List<Invoice>>(() {
  return InvoicesNotifier();
});

class InvoicesNotifier extends Notifier<List<Invoice>> {
  @override
  List<Invoice> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final invoices = await ref.read(invoiceDaoProvider).getAll();
      state = invoices;
    } catch (e) {
      debugPrint('Error loading invoices: $e');
    }
  }

  Future<void> refresh() async {
    await _load();
  }

  Future<void> addInvoice(Invoice invoice, {List<String> linkedExpenseIds = const [], double? paymentAmount}) async {
    try {
      final db = ref.read(databaseProvider);
      await db.transaction(() async {
        await ref.read(invoiceDaoProvider).insert(invoice);
        
        // Link expenses
        for (final expId in linkedExpenseIds) {
          final exp = ref.read(expensesProvider).where((e) => e.id == expId).firstOrNull;
          if (exp != null) {
            await ref.read(expenseDaoProvider).update(exp.copyWith(invoiceId: invoice.id));
          }
        }
        
        // Handle payments
        if (invoice.status == 'Paid') {
          final payment = Payment(
            id: const Uuid().v4(),
            invoiceId: invoice.id,
            clientId: invoice.clientId,
            amount: invoice.totalAmount,
            date: invoice.issueDate,
            paymentMethod: 'Cash',
            notes: 'Auto-recorded full payment',
            createdAt: DateTime.now(),
          );
          await ref.read(paymentDaoProvider).insert(payment);
        } else if (invoice.status == 'Partially Paid' && paymentAmount != null && paymentAmount > 0.01) {
          final payment = Payment(
            id: const Uuid().v4(),
            invoiceId: invoice.id,
            clientId: invoice.clientId,
            amount: paymentAmount,
            date: invoice.issueDate,
            paymentMethod: 'Cash',
            notes: 'Auto-recorded partial payment',
            createdAt: DateTime.now(),
          );
          await ref.read(paymentDaoProvider).insert(payment);
        }
      });

      await _load();
      await ref.read(expensesProvider.notifier).refresh();
      await ref.read(paymentsProvider.notifier).refresh();
      await ref.read(productsProvider.notifier).refresh();
    } catch (e) {
      debugPrint('Error adding invoice: $e');
      rethrow;
    }
  }

  Future<void> updateInvoice(Invoice invoice, {List<String> linkedExpenseIds = const [], double? paymentAmount}) async {
    try {
      // Unlink all expenses currently linked to this invoice
      final allExpenses = ref.read(expensesProvider);
      final previouslyLinked = allExpenses.where((e) => e.invoiceId == invoice.id).toList();
      for (final exp in previouslyLinked) {
        await ref.read(expenseDaoProvider).update(exp.copyWith(invoiceId: null));
      }
      // Link the new ones
      for (final expId in linkedExpenseIds) {
        final exp = allExpenses.where((e) => e.id == expId).firstOrNull;
        if (exp != null) {
          await ref.read(expenseDaoProvider).update(exp.copyWith(invoiceId: invoice.id));
        }
      }

      // Check current payments for this invoice
      final payments = await ref.read(paymentDaoProvider).getAll();
      final thisInvoicePayments = payments.where((p) => p.invoiceId == invoice.id).toList();
      final totalPaidBefore = thisInvoicePayments.fold(0.0, (sum, p) => sum + p.amount);

      final db = ref.read(databaseProvider);
      await db.transaction(() async {
        // Update the invoice in database first so that subsequent payment validations see the new totalAmount
        await ref.read(invoiceDaoProvider).update(invoice);

        // Update status and payments
        if (invoice.status == 'Paid') {
          final diff = invoice.totalAmount - totalPaidBefore;
          if (diff > 0.01) {
            final payment = Payment(
              id: const Uuid().v4(),
              invoiceId: invoice.id,
              clientId: invoice.clientId,
              amount: diff,
              date: invoice.issueDate,
              paymentMethod: 'Cash',
              notes: 'Auto-recorded remaining payment on invoice edit',
              createdAt: DateTime.now(),
            );
            await ref.read(paymentDaoProvider).insert(payment);
          } else if (diff < -0.01) {
            // Total paid exceeds new invoice total, delete existing and recreate a single full payment
            for (final p in thisInvoicePayments) {
              await ref.read(paymentDaoProvider).delete(p.id);
            }
            final payment = Payment(
              id: const Uuid().v4(),
              invoiceId: invoice.id,
              clientId: invoice.clientId,
              amount: invoice.totalAmount,
              date: invoice.issueDate,
              paymentMethod: 'Cash',
              notes: 'Auto-recorded full payment on invoice edit',
              createdAt: DateTime.now(),
            );
            await ref.read(paymentDaoProvider).insert(payment);
          }
        } else if (invoice.status == 'Partially Paid' && paymentAmount != null && paymentAmount > 0.01) {
          final diff = paymentAmount - totalPaidBefore;
          if (diff > 0.01) {
            final payment = Payment(
              id: const Uuid().v4(),
              invoiceId: invoice.id,
              clientId: invoice.clientId,
              amount: diff,
              date: invoice.issueDate,
              paymentMethod: 'Cash',
              notes: 'Auto-recorded partial payment on invoice edit',
              createdAt: DateTime.now(),
            );
            await ref.read(paymentDaoProvider).insert(payment);
          } else if (diff < -0.01) {
            // Paid amount is reduced, delete existing and recreate a single partial payment
            for (final p in thisInvoicePayments) {
              await ref.read(paymentDaoProvider).delete(p.id);
            }
            final payment = Payment(
              id: const Uuid().v4(),
              invoiceId: invoice.id,
              clientId: invoice.clientId,
              amount: paymentAmount,
              date: invoice.issueDate,
              paymentMethod: 'Cash',
              notes: 'Auto-recorded partial payment on invoice edit',
              createdAt: DateTime.now(),
            );
            await ref.read(paymentDaoProvider).insert(payment);
          }
        } else if (invoice.status == 'Draft' || invoice.status == 'Cancelled' || invoice.status == 'Sent' || invoice.status == 'Overdue') {
          // Delete all payments if status is not paid/partially paid
          for (final p in thisInvoicePayments) {
            await ref.read(paymentDaoProvider).delete(p.id);
          }
        }
      });

      await _load();
      await ref.read(expensesProvider.notifier).refresh();
      await ref.read(paymentsProvider.notifier).refresh();
      await ref.read(productsProvider.notifier).refresh();
    } catch (e) {
      debugPrint('Error updating invoice: $e');
      rethrow;
    }
  }

  Future<void> deleteInvoice(String id) async {
    try {
      await ref.read(invoiceDaoProvider).delete(id);
      await _load();
      await ref.read(expensesProvider.notifier).refresh();
      await ref.read(productsProvider.notifier).refresh();
      await ref.read(paymentsProvider.notifier).refresh();
    } catch (e) {
      debugPrint('Error deleting invoice: $e');
      rethrow;
    }
  }
}
