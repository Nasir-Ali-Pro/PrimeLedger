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
  bool _isChecking = false;

  @override
  List<RecurringProfile> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final profiles = await ref.read(recurringProfileDaoProvider).getAll();
      state = profiles;
    } catch (e) {
      debugPrint('Error loading recurring profiles: $e');
    }
  }

  DateTime _stripTime(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }

  DateTime _getNextDateForFrequency(DateTime currentDate, String frequency) {
    final d = DateTime(currentDate.year, currentDate.month, currentDate.day);
    switch (frequency) {
      case 'Daily':
        return d.add(const Duration(days: 1));
      case 'Weekly':
        return d.add(const Duration(days: 7));
      case 'Monthly':
        final nextMonth = d.month + 1;
        final nextYear = d.year + (nextMonth > 12 ? 1 : 0);
        final month = nextMonth > 12 ? nextMonth - 12 : nextMonth;
        final lastDayOfMonth = DateTime(nextYear, month + 1, 0).day;
        final day = d.day > lastDayOfMonth ? lastDayOfMonth : d.day;
        return DateTime(nextYear, month, day);
      case 'Quarterly':
        final nextMonth = d.month + 3;
        final nextYear = d.year + (nextMonth > 12 ? 1 : 0);
        final month = nextMonth > 12 ? nextMonth - 12 : nextMonth;
        final lastDayOfMonth = DateTime(nextYear, month + 1, 0).day;
        final day = d.day > lastDayOfMonth ? lastDayOfMonth : d.day;
        return DateTime(nextYear, month, day);
      case 'Yearly':
        return DateTime(d.year + 1, d.month, d.day);
      default:
        return d.add(const Duration(days: 30));
    }
  }

  Future<int> checkAndGenerateInvoices() async {
    if (_isChecking) return 0;
    _isChecking = true;
    try {
      final nowRaw = DateTime.now();
      final todayDate = _stripTime(nowRaw);
      int totalGenerated = 0;
      bool updated = false;
      final db = ref.read(databaseProvider);
      final profiles = await ref.read(recurringProfileDaoProvider).getAll();

      for (final profile in profiles) {
        if (!profile.isActive) continue;

        final startDate = _stripTime(profile.startDate);
        final endDate = profile.endDate != null ? _stripTime(profile.endDate!) : null;

        // Skip if start date is in the future
        if (todayDate.isBefore(startDate)) continue;

        // Auto-deactivate if end date has passed
        if (endDate != null && todayDate.isAfter(endDate)) {
          await ref.read(recurringProfileDaoProvider).update(profile.copyWith(isActive: false));
          updated = true;
          continue;
        }

        DateTime nextDate = _stripTime(profile.nextIssueDate);

        if (nextDate.isBefore(todayDate) || nextDate.isAtSameMomentAs(todayDate)) {
          await db.transaction(() async {
            List<Invoice> generatedInvoices = [];

            while (nextDate.isBefore(todayDate) || nextDate.isAtSameMomentAs(todayDate)) {
              if (endDate != null && nextDate.isAfter(endDate)) {
                break;
              }

              // Verify if an invoice for this client, issueDate, and description was already created
              final existingInvoices = await ref.read(invoiceDaoProvider).getAll();
              final alreadyGenerated = existingInvoices.any((i) =>
                i.clientId == profile.clientId &&
                _stripTime(i.issueDate).isAtSameMomentAs(nextDate) &&
                (i.subTotal - profile.amount).abs() < 0.01 &&
                i.items.any((item) => item.description == profile.description)
              );

              if (!alreadyGenerated) {
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
              }

              nextDate = _getNextDateForFrequency(nextDate, profile.frequency);
            }

            for (final inv in generatedInvoices) {
              await ref.read(invoiceDaoProvider).insert(inv);
              totalGenerated++;
            }

            final isCompleted = endDate != null && nextDate.isAfter(endDate);
            final updatedProfile = profile.copyWith(
              startDate: startDate,
              endDate: profile.endDate != null ? endDate : null,
              nextIssueDate: nextDate,
              isActive: isCompleted ? false : profile.isActive,
            );
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
    } finally {
      _isChecking = false;
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
