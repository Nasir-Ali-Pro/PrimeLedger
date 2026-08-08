import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/payment.dart';
import 'package:uuid/uuid.dart';

class PaymentDao {
  final AppDatabase _db;

  PaymentDao(this._db);

  Future<List<Payment>> getAll() async {
    try {
      final rows = await (_db.select(_db.paymentsTbl)
        ..orderBy([
          (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ])
      ).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('PaymentDao.getAll error: $e');
      rethrow;
    }
  }

  Future<Payment?> getById(String id) async {
    try {
      final row = await (_db.select(_db.paymentsTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      return row != null ? _toModel(row) : null;
    } catch (e) {
      debugPrint('PaymentDao.getById error: $e');
      rethrow;
    }
  }

  Future<List<Payment>> getByInvoiceId(String invoiceId) async {
    try {
      final rows = await (_db.select(_db.paymentsTbl)
        ..where((t) => t.invoiceId.equals(invoiceId))
        ..orderBy([
          (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ])
      ).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('PaymentDao.getByInvoiceId error: $e');
      rethrow;
    }
  }

  Future<double> getTotalByInvoiceId(String invoiceId) async {
    try {
      final rows = await (_db.select(_db.paymentsTbl)..where((t) => t.invoiceId.equals(invoiceId))).get();
      return rows.fold<double>(0.0, (sum, p) => sum + p.amount);
    } catch (e) {
      debugPrint('PaymentDao.getTotalByInvoiceId error: $e');
      rethrow;
    }
  }

  Future<void> _syncInvoiceStatus(String invoiceId) async {
    final invoiceRow = await (_db.select(_db.invoicesTbl)..where((t) => t.id.equals(invoiceId))).getSingleOrNull();
    if (invoiceRow == null) return;

    final paymentsRows = await (_db.select(_db.paymentsTbl)..where((t) => t.invoiceId.equals(invoiceId))).get();
    final totalPaid = paymentsRows.fold<double>(0.0, (sum, p) => sum + p.amount);

    String newStatus;
    if (totalPaid >= invoiceRow.totalAmount - 0.01) {
      newStatus = 'Paid';
    } else if (totalPaid > 0.01) {
      newStatus = 'Partially Paid';
    } else {
      if (invoiceRow.status == 'Draft' || invoiceRow.status == 'Cancelled') {
        newStatus = invoiceRow.status;
      } else {
        final isOverdue = DateTime.now().isAfter(invoiceRow.dueDate);
        newStatus = isOverdue ? 'Overdue' : 'Unpaid';
      }
    }

    final wasDeducting = invoiceRow.status != 'Draft' && invoiceRow.status != 'Cancelled';
    final isNowDeducting = newStatus != 'Draft' && newStatus != 'Cancelled';

    if (!wasDeducting && isNowDeducting) {
      final items = await (_db.select(_db.invoiceItemsTbl)..where((t) => t.invoiceId.equals(invoiceId))).get();
      for (final item in items) {
        final pid = item.productId;
        if (pid != null) {
          final productRow = await (_db.select(_db.productsTbl)..where((t) => t.id.equals(pid))).getSingleOrNull();
          if (productRow != null) {
            final newQty = (productRow.quantity - item.quantity).clamp(0, 999999);
            await (_db.update(_db.productsTbl)..where((t) => t.id.equals(pid))).write(
              ProductsTblCompanion(quantity: Value(newQty), updatedAt: Value(DateTime.now())),
            );
            await _db.into(_db.stockMovementsTbl).insert(StockMovementsTblCompanion(
              id: Value(const Uuid().v4()),
              productId: Value(pid),
              productName: Value(productRow.name),
              quantityChange: Value(-item.quantity),
              balanceAfter: Value(newQty),
              type: Value('Sale'),
              referenceNumber: Value(invoiceRow.invoiceNumber),
              referenceId: Value(invoiceRow.id),
              description: Value('Stock deducted on $newStatus status transition'),
              createdAt: Value(DateTime.now()),
            ));
          }
        }
      }
    }

    await (_db.update(_db.invoicesTbl)
      ..where((t) => t.id.equals(invoiceId))
    ).write(InvoicesTblCompanion(
      status: Value(newStatus),
    ));
  }

  Future<void> syncAllInvoicesStatus() async {
    try {
      final invoices = await _db.select(_db.invoicesTbl).get();
      for (final inv in invoices) {
        await _syncInvoiceStatus(inv.id);
      }
    } catch (e) {
      debugPrint('PaymentDao.syncAllInvoicesStatus error: $e');
    }
  }

  Future<void> insert(Payment payment) async {
    try {
      await _db.transaction(() async {
        // Verify payment won't exceed total client outstanding dues
        final invoiceRow = await (_db.select(_db.invoicesTbl)..where((t) => t.id.equals(payment.invoiceId))).getSingleOrNull();
        if (invoiceRow == null) {
          await _db.into(_db.paymentsTbl).insert(_toCompanion(payment));
          return;
        }

        final clientId = invoiceRow.clientId;
        final clientInvoices = await (_db.select(_db.invoicesTbl)
          ..where((t) => t.clientId.equals(clientId) & t.status.equals('Draft').not() & t.status.equals('Cancelled').not())
        ).get();
        final hasTargetInvoice = clientInvoices.any((i) => i.id == invoiceRow.id);
        double totalBilled = clientInvoices.fold<double>(0.0, (sum, i) => sum + i.totalAmount);
        if (!hasTargetInvoice) {
          totalBilled += invoiceRow.totalAmount;
        }

        final clientPayments = await (_db.select(_db.paymentsTbl)
          ..where((t) => t.clientId.equals(clientId))
        ).get();
        final totalPaid = clientPayments.fold<double>(0.0, (sum, p) => sum + p.amount);

        final clientExpenses = await (_db.select(_db.expensesTbl)
          ..where((t) => t.clientId.equals(clientId) & t.isBillable.equals(true))
        ).get();
        final activeInvoiceIds = clientInvoices.map((i) => i.id).toSet();
        final unbilledExpenses = clientExpenses.where((e) {
          if (e.invoiceId == null) return true;
          return !activeInvoiceIds.contains(e.invoiceId);
        }).toList();
        final billableExpenses = unbilledExpenses.fold<double>(0.0, (sum, e) => sum + e.amount * (1 + e.markupPercent / 100));

        final totalClientDues = totalBilled + billableExpenses - totalPaid;

        if (payment.amount > totalClientDues + 0.01) {
          throw Exception('Payment of ${payment.amount} would exceed total client outstanding dues of $totalClientDues. Already paid: $totalPaid, Total billed + expenses: ${totalBilled + billableExpenses}');
        }

        // Optimize: Build a map of invoiceId -> totalPaid from clientPayments
        final paymentMap = <String, double>{};
        for (final p in clientPayments) {
          paymentMap[p.invoiceId] = (paymentMap[p.invoiceId] ?? 0.0) + p.amount;
        }

        final totalPaidTarget = paymentMap[payment.invoiceId] ?? 0.0;
        final remainingTarget = (invoiceRow.totalAmount - totalPaidTarget).clamp(0.0, double.infinity);

        if (payment.amount <= remainingTarget + 0.01) {
          // Normal insert
          await _db.into(_db.paymentsTbl).insert(_toCompanion(payment));
          await _syncInvoiceStatus(payment.invoiceId);
        } else {
          // Excess payment to be allocated to other invoices
          double excess = payment.amount - remainingTarget;
          
          // Insert payment up to remainingTarget on the target invoice
          if (remainingTarget > 0.01) {
            await _db.into(_db.paymentsTbl).insert(_toCompanion(payment.copyWith(
              amount: remainingTarget,
              notes: payment.notes != null ? '${payment.notes} (Partial allocation)' : 'Partial allocation of Rs $remainingTarget',
            )));
            await _syncInvoiceStatus(payment.invoiceId);
          }
          
          // Find other invoices of the client that are unpaid/partially paid, sorted by oldest first
          final otherInvoices = await (_db.select(_db.invoicesTbl)
            ..where((t) => t.clientId.equals(clientId) & t.id.equals(payment.invoiceId).not() & t.status.equals('Draft').not() & t.status.equals('Cancelled').not() & t.status.equals('Paid').not())
            ..orderBy([(t) => OrderingTerm(expression: t.issueDate, mode: OrderingMode.asc)])
          ).get();
          
          for (final inv in otherInvoices) {
            if (excess <= 0.01) break;
            
            final invPaid = paymentMap[inv.id] ?? 0.0;
            final invRemaining = (inv.totalAmount - invPaid).clamp(0.0, double.infinity);
            
            if (invRemaining > 0.01) {
              final payAmt = excess > invRemaining ? invRemaining : excess;
              final allocatedPmt = Payment(
                id: const Uuid().v4(),
                invoiceId: inv.id,
                clientId: clientId,
                amount: payAmt,
                date: payment.date,
                paymentMethod: payment.paymentMethod,
                referenceNumber: payment.referenceNumber,
                notes: 'Excess payment allocated from Invoice #${invoiceRow.invoiceNumber}',
                createdAt: DateTime.now(),
              );
              await _db.into(_db.paymentsTbl).insert(_toCompanion(allocatedPmt));
              await _syncInvoiceStatus(inv.id);
              excess -= payAmt;
            }
          }
          
          // If there is still excess left, add it to the target invoice as an overpayment
          if (excess > 0.01) {
            final overpaymentAmt = remainingTarget > 0.01 ? excess : payment.amount;
            if (remainingTarget > 0.01) {
              // Add a second payment to target invoice representing the overpayment
              final overpaymentPmt = Payment(
                id: const Uuid().v4(),
                invoiceId: payment.invoiceId,
                clientId: payment.clientId,
                amount: overpaymentAmt,
                date: payment.date,
                paymentMethod: payment.paymentMethod,
                referenceNumber: payment.referenceNumber,
                notes: payment.notes != null ? '${payment.notes} (Overpayment allocation)' : 'Overpayment allocation of Rs $overpaymentAmt',
                createdAt: DateTime.now(),
              );
              await _db.into(_db.paymentsTbl).insert(_toCompanion(overpaymentPmt));
            } else {
              // Target invoice remaining was 0, just insert the full overpayment
              await _db.into(_db.paymentsTbl).insert(_toCompanion(payment));
            }
            await _syncInvoiceStatus(payment.invoiceId);
          }
        }
      });
    } catch (e) {
      debugPrint('PaymentDao.insert error: $e');
      rethrow;
    }
  }

  Future<void> update(Payment payment) async {
    try {
      await _db.transaction(() async {
        // Find the old payment record to check if invoiceId was changed
        final oldPayment = await (_db.select(_db.paymentsTbl)..where((t) => t.id.equals(payment.id))).getSingleOrNull();
        final String? oldInvoiceId = oldPayment?.invoiceId;

        // Verify payment won't exceed the target client outstanding dues
        final invoiceRow = await (_db.select(_db.invoicesTbl)..where((t) => t.id.equals(payment.invoiceId))).getSingleOrNull();
        if (invoiceRow != null) {
          final clientId = invoiceRow.clientId;
          final clientInvoices = await (_db.select(_db.invoicesTbl)
            ..where((t) => t.clientId.equals(clientId) & t.status.equals('Draft').not() & t.status.equals('Cancelled').not())
          ).get();
          final hasTargetInvoice = clientInvoices.any((i) => i.id == invoiceRow.id);
          double totalBilled = clientInvoices.fold<double>(0.0, (sum, i) => sum + i.totalAmount);
          if (!hasTargetInvoice) {
            totalBilled += invoiceRow.totalAmount;
          }

          final clientPaymentsOther = await (_db.select(_db.paymentsTbl)
            ..where((t) => t.clientId.equals(clientId) & t.id.equals(payment.id).not())
          ).get();
          final totalPaidOther = clientPaymentsOther.fold<double>(0.0, (sum, p) => sum + p.amount);

          final clientExpenses = await (_db.select(_db.expensesTbl)
            ..where((t) => t.clientId.equals(clientId) & t.isBillable.equals(true))
          ).get();
          final activeInvoiceIds = clientInvoices.map((i) => i.id).toSet();
          final unbilledExpenses = clientExpenses.where((e) {
            if (e.invoiceId == null) return true;
            return !activeInvoiceIds.contains(e.invoiceId);
          }).toList();
          final billableExpenses = unbilledExpenses.fold<double>(0.0, (sum, e) => sum + e.amount * (1 + e.markupPercent / 100));

          final totalClientDues = totalBilled + billableExpenses - totalPaidOther;

          if (payment.amount > totalClientDues + 0.01) {
            throw Exception('Payment of ${payment.amount} would exceed total client outstanding dues of $totalClientDues. Already paid other: $totalPaidOther, Total billed + expenses: ${totalBilled + billableExpenses}');
          }
        }

        // Update the payment record
        await (_db.update(_db.paymentsTbl)..where((t) => t.id.equals(payment.id))).write(_toCompanion(payment));
        
        // Sync invoice statuses
        await _syncInvoiceStatus(payment.invoiceId);
        if (oldInvoiceId != null && oldInvoiceId != payment.invoiceId) {
          await _syncInvoiceStatus(oldInvoiceId);
        }
      });
    } catch (e) {
      debugPrint('PaymentDao.update error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await _db.transaction(() async {
        final paymentRow = await (_db.select(_db.paymentsTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
        if (paymentRow != null) {
          await (_db.delete(_db.paymentsTbl)..where((t) => t.id.equals(id))).go();
          await _syncInvoiceStatus(paymentRow.invoiceId);
        }
      });
    } catch (e) {
      debugPrint('PaymentDao.delete error: $e');
      rethrow;
    }
  }

  Payment _toModel(PaymentsTblData row) {
    return Payment(
      id: row.id,
      invoiceId: row.invoiceId,
      clientId: row.clientId,
      amount: row.amount,
      date: row.date,
      paymentMethod: row.paymentMethod,
      referenceNumber: row.referenceNumber,
      notes: row.notes,
      createdAt: row.createdAt,
    );
  }

  PaymentsTblCompanion _toCompanion(Payment model) {
    return PaymentsTblCompanion(
      id: Value(model.id),
      invoiceId: Value(model.invoiceId),
      clientId: Value(model.clientId),
      amount: Value(model.amount),
      date: Value(model.date),
      paymentMethod: Value(model.paymentMethod),
      referenceNumber: Value(model.referenceNumber),
      notes: Value(model.notes),
      createdAt: Value(model.createdAt),
    );
  }
}
