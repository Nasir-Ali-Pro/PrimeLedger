import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
import '../models/recurring_profile.dart';
import '../models/invoice.dart';
import '../database/database_provider.dart';
import 'invoice_provider.dart';

final recurringProfilesProvider = NotifierProvider<RecurringProfileNotifier, List<RecurringProfile>>(() {
  return RecurringProfileNotifier();
});

class RecurringProfileNotifier extends Notifier<List<RecurringProfile>> {
  @override
  List<RecurringProfile> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final profiles = await ref.read(recurringProfileDaoProvider).getAll();
      state = profiles;
      await checkAndGenerateInvoices();
    } catch (e) {
      debugPrint('Error loading recurring profiles: $e');
    }
  }

  Future<int> checkAndGenerateInvoices() async {
    try {
      final now = DateTime.now();
      int totalGenerated = 0;
      bool updated = false;
      final db = ref.read(databaseProvider);
      final profiles = await ref.read(recurringProfileDaoProvider).getAll();

      for (final profile in profiles) {
        if (profile.isActive && (profile.nextIssueDate.isBefore(now) || profile.nextIssueDate.isAtSameMomentAs(now))) {
          await db.transaction(() async {
            DateTime nextDate = profile.nextIssueDate;
            List<Invoice> generatedInvoices = [];

            while (nextDate.isBefore(now) || nextDate.isAtSameMomentAs(now)) {
              final uniqueSuffix = '${nextDate.year}${nextDate.month.toString().padLeft(2, '0')}${nextDate.day.toString().padLeft(2, '0')}';
              final invoiceNum = 'REC-$uniqueSuffix-${const Uuid().v4().substring(0, 4).toUpperCase()}';

              final newInvoice = Invoice(
                id: const Uuid().v4(),
                clientId: profile.clientId,
                invoiceNumber: invoiceNum,
                issueDate: nextDate,
                dueDate: nextDate.add(const Duration(days: 14)),
                subTotal: profile.amount,
                taxTotal: 0,
                totalAmount: profile.amount,
                status: 'Draft',
                items: [
                  InvoiceItem(description: profile.description, quantity: 1, rate: profile.amount, taxPercent: 0, taxAmount: 0, total: profile.amount)
                ],
              );
              generatedInvoices.add(newInvoice);

              if (profile.frequency == 'Weekly') {
                nextDate = nextDate.add(const Duration(days: 7));
              } else if (profile.frequency == 'Monthly') {
                final nextMonth = nextDate.month + 1;
                final nextYear = nextDate.year + (nextMonth > 12 ? 1 : 0);
                final month = nextMonth > 12 ? nextMonth - 12 : nextMonth;
                final lastDayOfMonth = DateTime(nextYear, month + 1, 0).day;
                final day = nextDate.day > lastDayOfMonth ? lastDayOfMonth : nextDate.day;
                nextDate = DateTime(nextYear, month, day);
              } else if (profile.frequency == 'Yearly') {
                nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
              }
            }

            for (final inv in generatedInvoices) {
              await ref.read(invoiceDaoProvider).insert(inv);
              totalGenerated++;
            }

            final updatedProfile = profile.copyWith(nextIssueDate: nextDate);
            await ref.read(recurringProfileDaoProvider).update(updatedProfile);
          });
          updated = true;
        }
      }

      if (updated) {
        await ref.read(invoicesProvider.notifier).refresh();
        final profiles = await ref.read(recurringProfileDaoProvider).getAll();
        state = profiles;
      }
      return totalGenerated;
    } catch (e) {
      debugPrint('Error checking/generating recurring invoices: $e');
      rethrow;
    }
  }

  Future<void> addProfile(RecurringProfile profile) async {
    try {
      await ref.read(recurringProfileDaoProvider).insert(profile);
      await _load();
    } catch (e) {
      debugPrint('Error adding recurring profile: $e');
      rethrow;
    }
  }

  Future<void> updateProfile(RecurringProfile profile) async {
    try {
      await ref.read(recurringProfileDaoProvider).update(profile);
      await _load();
    } catch (e) {
      debugPrint('Error updating recurring profile: $e');
      rethrow;
    }
  }

  Future<void> deleteProfile(String id) async {
    try {
      await ref.read(recurringProfileDaoProvider).delete(id);
      await _load();
    } catch (e) {
      debugPrint('Error deleting recurring profile: $e');
      rethrow;
    }
  }
}
