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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Slidable(
                          key: ValueKey(supplier.id),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                               onPressed: (ctx) async {
                                 final confirmed = await ConfirmDialog.show(
                                   context: context,
                                   title: 'Delete Supplier',
                                   message: 'Are you sure you want to delete ${supplier.name}? This will permanently delete all associated purchase orders! This action cannot be undone.',
                                   confirmLabel: 'Delete',
                                   confirmColor: theme.colorScheme.error,
                                 );
                                 if (confirmed == true) {
                                   try {
                                     await ref.read(suppliersProvider.notifier).deleteSupplier(supplier.id);
                                     if (ctx.mounted) {
                                       ScaffoldMessenger.of(ctx).showSnackBar(
                                         SnackBar(
                                           content: Text('${supplier.name} deleted successfully.'),
                                           backgroundColor: const Color(0xFF10B981),
                                         ),
                                       );
                                     }
                                   } catch (e) {
                                     if (ctx.mounted) {
                                       String errMsg = e.toString();
                                       if (errMsg.contains('Exception:')) {
                                         errMsg = errMsg.substring(errMsg.indexOf('Exception:') + 10);
                                       }
                                       showDialog(
                                         context: ctx,
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
                               },
                               backgroundColor: theme.colorScheme.error,
                               foregroundColor: theme.colorScheme.onError,
                               icon: Icons.delete,
                               label: 'Delete',
                              ),
                            ],
                          ),
                          child: Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              onTap: () {
                                ref.read(ledgerFilterProvider.notifier).setSupplierFilter(supplier.id);
                                context.go('/ledger');
                              },
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                                child: Text(supplier.name.isNotEmpty ? supplier.name[0].toUpperCase() : 'S', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF59E0B))),
                              ),
                              title: Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
                              subtitle: Text(supplier.email ?? supplier.phone ?? 'No contact info', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
                              trailing: IconButton(
                                icon: Icon(Icons.edit, color: theme.colorScheme.primary),
                                onPressed: () {
                                  context.go('/suppliers/edit/${supplier.id}');
                                },
                              ),
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
        onPressed: () => context.go('/suppliers/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add Supplier', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
