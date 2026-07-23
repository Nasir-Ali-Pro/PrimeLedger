import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/payment.dart';
import '../database/database_provider.dart';
import 'invoice_provider.dart';

final paymentsProvider = NotifierProvider<PaymentsNotifier, List<Payment>>(() {
  return PaymentsNotifier();
});

class PaymentsNotifier extends Notifier<List<Payment>> {
  @override
  List<Payment> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final payments = await ref.read(paymentDaoProvider).getAll();
      state = payments;
    } catch (e) {
      debugPrint('Error loading payments: $e');
    }
  }

  Future<void> refresh() async {
    await _load();
  }

  Future<void> addPayment(Payment payment) async {
    try {
      await ref.read(paymentDaoProvider).insert(payment);
      await ref.read(invoicesProvider.notifier).refresh();
      await _load();
    } catch (e) {
      debugPrint('Error adding payment: $e');
      rethrow;
    }
  }

  Future<void> updatePayment(Payment payment) async {
    try {
      await ref.read(paymentDaoProvider).update(payment);
      await ref.read(invoicesProvider.notifier).refresh();
      await _load();
    } catch (e) {
      debugPrint('Error updating payment: $e');
      rethrow;
    }
  }

  Future<void> deletePayment(String id) async {
    try {
      await ref.read(paymentDaoProvider).delete(id);
      await ref.read(invoicesProvider.notifier).refresh();
      await _load();
    } catch (e) {
      debugPrint('Error deleting payment: $e');
      rethrow;
    }
  }
}
