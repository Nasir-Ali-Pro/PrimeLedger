import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/purchase_order.dart';
import '../database/database_provider.dart';
import 'product_provider.dart';
import 'supplier_payment_provider.dart';

final purchaseOrdersProvider = NotifierProvider<PurchaseOrdersNotifier, List<PurchaseOrder>>(() {
  return PurchaseOrdersNotifier();
});

class PurchaseOrdersNotifier extends Notifier<List<PurchaseOrder>> {
  @override
  List<PurchaseOrder> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final dao = ref.read(purchaseOrderDaoProvider);
      var orders = await dao.getAll();
      bool fixed = false;
      for (final po in orders) {
        if (po.status == 'Received' && po.items.any((i) => i.productId == null)) {
          await dao.fixUnlinkedItems(po.id);
          fixed = true;
        }
      }
      if (fixed) orders = await dao.getAll();
      state = orders;
    } catch (e) {
      debugPrint('Error loading purchase orders: $e');
    }
  }

  Future<void> refresh() async {
    await _load();
  }

  Future<void> addPurchaseOrder(PurchaseOrder order) async {
    try {
      await ref.read(purchaseOrderDaoProvider).insert(order);
      await _load();
      await ref.read(productsProvider.notifier).refresh();
    } catch (e) {
      debugPrint('Error adding purchase order: $e');
      rethrow;
    }
  }

  Future<void> updatePurchaseOrder(PurchaseOrder order) async {
    try {
      await ref.read(purchaseOrderDaoProvider).update(order);
      await _load();
      await ref.read(productsProvider.notifier).refresh();
    } catch (e) {
      debugPrint('Error updating purchase order: $e');
      rethrow;
    }
  }

  Future<void> deletePurchaseOrder(String id) async {
    try {
      await ref.read(purchaseOrderDaoProvider).delete(id);
      await _load();
      await ref.read(supplierPaymentsProvider.notifier).refresh();
      await ref.read(productsProvider.notifier).refresh();
    } catch (e) {
      debugPrint('Error deleting purchase order: $e');
      rethrow;
    }
  }

  Future<void> receivePurchaseOrder(String id) async {
    try {
      await ref.read(purchaseOrderDaoProvider).receive(id);
      await _load();
      await ref.read(productsProvider.notifier).refresh();
    } catch (e) {
      debugPrint('Error receiving purchase order: $e');
      rethrow;
    }
  }

  Future<int> fixUnlinkedItems(String id) async {
    try {
      final count = await ref.read(purchaseOrderDaoProvider).fixUnlinkedItems(id);
      if (count > 0) {
        await _load();
        await ref.read(productsProvider.notifier).refresh();
      }
      return count;
    } catch (e) {
      debugPrint('Error fixing unlinked items: $e');
      rethrow;
    }
  }
}
