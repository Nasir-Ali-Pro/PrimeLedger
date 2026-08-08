import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../providers/supplier_provider.dart';
import '../providers/ledger_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/confirm_dialog.dart';

class SuppliersScreen extends ConsumerStatefulWidget {
  const SuppliersScreen({super.key});

  @override
  ConsumerState<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends ConsumerState<SuppliersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allSuppliers = ref.watch(suppliersProvider);
    final suppliers = _searchQuery.isEmpty
        ? allSuppliers
        : allSuppliers.where((s) => s.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Suppliers')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search suppliers...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          Expanded(
            child: suppliers.isEmpty
                    ? EmptyState(
                        icon: Icons.local_shipping_outlined,
                        title: _searchQuery.isEmpty ? 'No suppliers yet' : 'No suppliers found',
                        subtitle: _searchQuery.isEmpty
                            ? 'Tap the button below to add your first supplier'
                            : 'No suppliers match your search query',
                        actionLabel: _searchQuery.isEmpty ? 'Add Supplier' : null,
                        onAction: _searchQuery.isEmpty ? () => context.go('/suppliers/new') : null,
                      )
                    : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: suppliers.length,
                    itemBuilder: (context, index) {
                      final supplier = suppliers[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                                    child: Text(supplier.name.isNotEmpty ? supplier.name[0].toUpperCase() : 'S', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF59E0B))),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: theme.colorScheme.onSurface)),
                                        Text(supplier.email ?? supplier.phone ?? 'No contact info', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Divider(height: 1),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: () => context.go('/suppliers/edit/${supplier.id}'),
                                    icon: const Icon(Icons.edit, size: 16, color: Color(0xFF4F46E5)),
                                    label: const Text('Edit', style: TextStyle(color: Color(0xFF4F46E5), fontSize: 12, fontWeight: FontWeight.bold)),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                      side: const BorderSide(color: Color(0xFF4F46E5)),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                    tooltip: 'Delete Supplier',
                                    onPressed: () async {
                                      final confirmed = await ConfirmDialog.show(
                                        context: context,
                                        title: 'Delete Supplier',
                                        message: 'Are you sure you want to delete ${supplier.name}? This will permanently delete all associated purchase orders!',
                                        confirmLabel: 'Delete',
                                        confirmColor: theme.colorScheme.error,
                                      );
                                      if (confirmed == true) {
                                        try {
                                          await ref.read(suppliersProvider.notifier).deleteSupplier(supplier.id);
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('${supplier.name} deleted successfully.'),
                                                backgroundColor: const Color(0xFF10B981),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
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
                                                  TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('OK')),
                                                ],
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    },
                                  ),
                                  const Spacer(),
                                  TextButton.icon(
                                    onPressed: () {
                                      ref.read(ledgerFilterProvider.notifier).setSupplierFilter(supplier.id);
                                      context.go('/ledger');
                                    },
                                    icon: const Icon(Icons.menu_book, size: 16),
                                    label: const Text('View Ledger', style: TextStyle(fontSize: 12)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/suppliers/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add Supplier', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
