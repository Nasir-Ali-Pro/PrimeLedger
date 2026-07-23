import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/supplier_payment.dart';
import '../database/database_provider.dart';
import 'purchase_order_provider.dart';

final supplierPaymentsProvider = NotifierProvider<SupplierPaymentsNotifier, List<SupplierPayment>>(() {
  return SupplierPaymentsNotifier();
});

class SupplierPaymentsNotifier extends Notifier<List<SupplierPayment>> {
  @override
  List<SupplierPayment> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final payments = await ref.read(supplierPaymentDaoProvider).getAll();
      state = payments;
    } catch (e) {
      debugPrint('Error loading supplier payments: $e');
    }
  }

  Future<void> refresh() async {
    await _load();
  }

  Future<void> addPayment(SupplierPayment payment) async {
    try {
      await ref.read(supplierPaymentDaoProvider).insert(payment);
      await ref.read(purchaseOrdersProvider.notifier).refresh();
      await _load();
    } catch (e) {
      debugPrint('Error adding supplier payment: $e');
      rethrow;
    }
  }

  Future<void> updatePayment(SupplierPayment payment) async {
    try {
      await ref.read(supplierPaymentDaoProvider).update(payment);
      await ref.read(purchaseOrdersProvider.notifier).refresh();
      await _load();
    } catch (e) {
      debugPrint('Error updating supplier payment: $e');
      rethrow;
    }
  }

  Future<void> deletePayment(String id) async {
    try {
      await ref.read(supplierPaymentDaoProvider).delete(id);
      await ref.read(purchaseOrdersProvider.notifier).refresh();
      await _load();
    } catch (e) {
      debugPrint('Error deleting supplier payment: $e');
      rethrow;
    }
  }
}
