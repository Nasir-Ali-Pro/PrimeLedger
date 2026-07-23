import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../providers/purchase_order_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/supplier_payment_provider.dart';

class PurchaseOrdersScreen extends ConsumerStatefulWidget {
  const PurchaseOrdersScreen({super.key});

  @override
  ConsumerState<PurchaseOrdersScreen> createState() => _PurchaseOrdersScreenState();
}

class _PurchaseOrdersScreenState extends ConsumerState<PurchaseOrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _statusFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final purchaseOrders = ref.watch(purchaseOrdersProvider);
    final supplierPayments = ref.watch(supplierPaymentsProvider);
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    const statusOptions = ['All', 'Draft', 'Sent', 'Partially Received', 'Received', 'Cancelled'];

    final filteredOrders = purchaseOrders.where((po) {
      final q = _searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty || po.poNumber.toLowerCase().contains(q);
      final matchesStatus = _statusFilter == null || _statusFilter == 'All' ||
          po.status == _statusFilter;
      return matchesSearch && matchesStatus;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Purchase Orders')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: statusOptions.map((status) {
                  final isSelected = (_statusFilter ?? 'All') == status;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        status,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF6366F1) : null,
                          fontWeight: isSelected ? FontWeight.bold : null,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFF6366F1).withValues(alpha: 0.15),
                      checkmarkColor: const Color(0xFF6366F1),
                      onSelected: (_) => setState(() => _statusFilter = status),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      side: BorderSide.none,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 80, color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty && (_statusFilter == null || _statusFilter == 'All')
                              ? 'No purchase orders yet'
                              : 'No purchase orders match your search/filter',
                          style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final po = filteredOrders[index];
                      final payments = supplierPayments.where((p) => p.purchaseOrderId == po.id);
                      final totalPaid = payments.fold<double>(0.0, (sum, p) => sum + p.amount);
                      
                      String paymentStatus;
                      if (totalPaid >= po.totalAmount - 0.01) {
                        paymentStatus = 'Paid';
                      } else if (totalPaid > 0.01) {
                        paymentStatus = 'Partially Paid';
                      } else {
                        paymentStatus = 'Unpaid';
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Slidable(
                          key: ValueKey(po.id),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              if (po.status != 'Cancelled' && totalPaid < po.totalAmount - 0.01)
                                SlidableAction(
                                  onPressed: (ctx) {
                                    ctx.push('/purchase-orders/pay/${po.id}');
                                  },
                                  backgroundColor: const Color(0xFF3B82F6),
                                  foregroundColor: Colors.white,
                                  icon: Icons.payment,
                                  label: 'Pay',
                                ),
                              if (po.status != 'Received' && po.status != 'Cancelled')
                                SlidableAction(
                                  onPressed: (ctx) async {
                                    final confirmed = await showDialog<bool>(
                                      context: ctx,
                                      builder: (dialogCtx) => AlertDialog(
                                        title: const Text('Confirm Receive'),
                                        content: const Text('Receive this purchase order? Stock will be auto-adjusted and products created.'),
                                        actions: [
                                          TextButton(onPressed: () => Navigator.pop(dialogCtx, false), child: const Text('Cancel')),
                                          TextButton(onPressed: () => Navigator.pop(dialogCtx, true), child: const Text('Receive')),
                                        ],
                                      ),
                                    );
                                    if (confirmed == true) {
                                      await ref.read(purchaseOrdersProvider.notifier).receivePurchaseOrder(po.id);
                                      if (ctx.mounted) {
                                        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                                          content: Text('Purchase order received! Products and stock updated.'),
                                          backgroundColor: Color(0xFF10B981),
                                        ));
                                      }
                                    }
                                  },
                                  backgroundColor: const Color(0xFF10B981),
                                  foregroundColor: Colors.white,
                                  icon: Icons.inventory_2,
                                  label: 'Receive',
                                ),
                              SlidableAction(
                                onPressed: (ctx) async {
                                  final confirmed = await showDialog<bool>(
                                    context: ctx,
                                    builder: (dialogCtx) => AlertDialog(
                                      title: const Text('Confirm Delete'),
                                      content: const Text('Are you sure? This cannot be undone.'),
                                      actions: [
                                        TextButton(onPressed: () => Navigator.pop(dialogCtx, false), child: const Text('Cancel')),
                                        TextButton(onPressed: () => Navigator.pop(dialogCtx, true), style: TextButton.styleFrom(foregroundColor: Colors.red), child: const Text('Delete')),
                                      ],
                                    ),
                                  );
                                  if (confirmed == true) {
                                    try {
                                      await ref.read(purchaseOrdersProvider.notifier).deletePurchaseOrder(po.id);
                                      if (ctx.mounted) {
                                        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                                          content: Text('Purchase order deleted successfully.'),
                                          backgroundColor: Color(0xFF10B981),
                                        ));
                                      }
                                    } catch (e) {
                                      if (ctx.mounted) {
                                        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                                          content: Text('Error deleting purchase order: $e'),
                                          backgroundColor: const Color(0xFFEF4444),
                                        ));
                                      }
                                    }
                                  }
                                },
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
                                child: const Icon(Icons.shopping_cart, color: Color(0xFF14B8A6)),
                              ),
                              title: Text(po.poNumber, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(settings.formatCurrency(po.totalAmount), style: const TextStyle(fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Paid: ${settings.formatCurrency(totalPaid)} / ${settings.formatCurrency(po.totalAmount)}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: totalPaid >= po.totalAmount - 0.01
                                          ? const Color(0xFF10B981)
                                          : totalPaid > 0.01
                                              ? const Color(0xFFF59E0B)
                                              : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _buildStatusBadge(po.status),
                                  const SizedBox(height: 4),
                                  _buildPaymentStatusBadge(paymentStatus),
                                ],
                              ),
                              onTap: () => context.go('/purchase-orders/edit/${po.id}'),
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
        onPressed: () => context.go('/purchase-orders/new'),
        icon: const Icon(Icons.add),
        label: const Text('New PO', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Received': color = const Color(0xFF10B981); break;
      case 'Cancelled': color = const Color(0xFFEF4444); break;
      case 'Partially Received': color = const Color(0xFFF59E0B); break;
      case 'Sent': color = const Color(0xFF3B82F6); break;
      default: color = const Color(0xFF9CA3AF); break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11)),
    );
  }

  Widget _buildPaymentStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Paid': color = const Color(0xFF10B981); break;
      case 'Partially Paid': color = const Color(0xFFF59E0B); break;
      default: color = const Color(0xFF9CA3AF); break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
      child: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 10)),
    );
  }
}
