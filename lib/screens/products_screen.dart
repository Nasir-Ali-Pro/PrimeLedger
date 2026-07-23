import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../providers/product_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/loading_overlay.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);
    final totalStockValue = products.fold(0.0, (sum, p) => sum + p.stockValue);
    final lowStockCount = products.where((p) => p.isLowStock).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF14B8A6), Color(0xFF0D9488)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [BoxShadow(color: const Color(0xFF14B8A6).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.inventory_2, color: Colors.white.withValues(alpha: 0.8), size: 24),
                        const SizedBox(height: 8),
                        Text('Stock Value', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13)),
                        const SizedBox(height: 4),
                        Text('${settings.currencySymbol}${totalStockValue.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: lowStockCount > 0 ? [const Color(0xFFEF4444), const Color(0xFFDC2626)] : [const Color(0xFF10B981), const Color(0xFF059669)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [BoxShadow(color: (lowStockCount > 0 ? const Color(0xFFEF4444) : const Color(0xFF10B981)).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning_amber, color: Colors.white.withValues(alpha: 0.8), size: 24),
                        const SizedBox(height: 8),
                        Text('Low Stock', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13)),
                        const SizedBox(height: 4),
                        Text('$lowStockCount items', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: products.isEmpty
                    ? EmptyState(
                        icon: Icons.inventory_2_outlined,
                        title: 'No products found',
                        subtitle: 'Add products to manage stock and add them to invoices',
                        actionLabel: 'Add Product',
                        onAction: () => context.go('/products/new'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Slidable(
                              key: ValueKey(product.id),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) => ref.read(productsProvider.notifier).adjustStock(product.id, 1),
                                    backgroundColor: const Color(0xFF10B981),
                                    foregroundColor: Colors.white,
                                    icon: Icons.add,
                                    label: '+1',
                                  ),
                                  SlidableAction(
                                    onPressed: (_) => _confirmStockAdjust(product, product.quantity, -1),
                                    backgroundColor: const Color(0xFFF59E0B),
                                    foregroundColor: Colors.white,
                                    icon: Icons.remove,
                                    label: '-1',
                                  ),
                                  SlidableAction(
                                    onPressed: (_) => _confirmDelete(product),
                                    backgroundColor: const Color(0xFFEF4444),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Card(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFF14B8A6).withValues(alpha: 0.1),
                                    child: Text(product.name.isNotEmpty ? product.name[0].toUpperCase() : 'P', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF14B8A6))),
                                  ),
                                  title: Row(
                                    children: [
                                      Expanded(child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold))),
                                      if (product.isLowStock)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(color: const Color(0xFFEF4444).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                                          child: const Text('LOW', style: TextStyle(fontSize: 10, color: Color(0xFFEF4444), fontWeight: FontWeight.bold)),
                                        ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text('SKU: ${product.sku ?? 'N/A'} • ${product.quantity} ${product.unit}', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
                                    ],
                                  ),
                                  trailing: Text('${settings.currencySymbol}${product.sellingPrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  onTap: () => context.go('/products/edit/${product.id}'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/products/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add Product', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _confirmStockAdjust(dynamic product, int qty, int delta) async {
    if (delta < 0) {
      final confirmed = await ConfirmDialog.show(
        context: context,
        title: 'Reduce Stock',
        message: 'Reduce stock of "${product.name}" from $qty by ${-delta}?',
        confirmLabel: 'Reduce',
        confirmColor: const Color(0xFFF59E0B),
        icon: Icons.remove,
      );
      if (confirmed == true) {
        ref.read(productsProvider.notifier).adjustStock(product.id, delta);
      }
    } else {
      ref.read(productsProvider.notifier).adjustStock(product.id, delta);
    }
  }

  void _confirmDelete(dynamic product) async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Delete Product',
      message: 'Delete "${product.name}"? This cannot be undone.',
      confirmLabel: 'Delete',
      confirmColor: const Color(0xFFEF4444),
    );
    if (confirmed == true) {
      if (!mounted) return;
      LoadingOverlay.show(context, message: 'Deleting product...');
      try {
        await ref.read(productsProvider.notifier).deleteProduct(product.id);
        LoadingOverlay.hide();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Product "${product.name}" deleted successfully.'),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
        }
      } catch (e) {
        LoadingOverlay.hide();
        if (mounted) {
          String errMsg = e.toString();
          if (errMsg.contains('Exception:')) {
            errMsg = errMsg.substring(errMsg.indexOf('Exception:') + 10);
          }
          showDialog(
            context: context,
            builder: (dialogCtx) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.orange),
                  SizedBox(width: 8),
                  Text('Deletion Blocked'),
                ],
              ),
              content: Text(errMsg),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogCtx),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    }
  }
}
