import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../database/database_provider.dart';

final productsProvider = NotifierProvider<ProductsNotifier, List<Product>>(() {
  return ProductsNotifier();
});

class ProductsNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final products = await ref.read(productDaoProvider).getAll();
      state = products;
    } catch (e) {
      debugPrint('Error loading products: $e');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await ref.read(productDaoProvider).insert(product);
      await _load();
    } catch (e) {
      debugPrint('Error adding product: $e');
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await ref.read(productDaoProvider).update(product);
      await _load();
    } catch (e) {
      debugPrint('Error updating product: $e');
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await ref.read(productDaoProvider).delete(id);
      await _load();
    } catch (e) {
      debugPrint('Error deleting product: $e');
      rethrow;
    }
  }

  Future<void> adjustStock(String id, int adjustment) async {
    try {
      await ref.read(productDaoProvider).adjustStock(id, adjustment);
      await _load();
    } catch (e) {
      debugPrint('Error adjusting stock: $e');
      rethrow;
    }
  }

  Future<void> refresh() async {
    await _load();
  }
}
