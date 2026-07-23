import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/supplier.dart';
import '../database/database_provider.dart';

final suppliersProvider = NotifierProvider<SuppliersNotifier, List<Supplier>>(() {
  return SuppliersNotifier();
});

class SuppliersNotifier extends Notifier<List<Supplier>> {
  @override
  List<Supplier> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final suppliers = await ref.read(supplierDaoProvider).getAll();
      state = suppliers;
    } catch (e) {
      debugPrint('Error loading suppliers: $e');
    }
  }

  Future<void> addSupplier(Supplier supplier) async {
    try {
      await ref.read(supplierDaoProvider).insert(supplier);
      await _load();
    } catch (e) {
      debugPrint('Error adding supplier: $e');
      rethrow;
    }
  }

  Future<void> updateSupplier(Supplier supplier) async {
    try {
      await ref.read(supplierDaoProvider).update(supplier);
      await _load();
    } catch (e) {
      debugPrint('Error updating supplier: $e');
      rethrow;
    }
  }

  Future<void> deleteSupplier(String id) async {
    try {
      await ref.read(supplierDaoProvider).delete(id);
      await _load();
    } catch (e) {
      debugPrint('Error deleting supplier: $e');
      rethrow;
    }
  }
}
