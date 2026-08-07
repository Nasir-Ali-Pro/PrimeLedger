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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final po = filteredOrders[index];
                      final payments = supplierPayments.where((p) => p.purchaseOrderId == po.id);
                      final totalPaid = payments.fold<double>(0.0, (sum, p) => sum + p.amount);
                      final remaining = (po.totalAmount - totalPaid).clamp(0.0, double.infinity);
                      
                      String paymentStatus;
                      if (totalPaid >= po.totalAmount - 0.01) {
                        paymentStatus = 'Paid';
                      } else if (totalPaid > 0.01) {
                        paymentStatus = 'Partially Paid';
                      } else {
                        paymentStatus = 'Unpaid';
                      }

                      final isPayable = po.status != 'Cancelled' && remaining > 0.01;
                      final isReceivable = po.status != 'Received' && po.status != 'Cancelled';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: theme.dividerColor),
                        ),
                        child: InkWell(
                          onTap: () => context.go('/purchase-orders/edit/${po.id}'),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: const Color(0xFF14B8A6).withValues(alpha: 0.1),
                                            child: const Icon(Icons.shopping_cart, color: Color(0xFF14B8A6), size: 20),
                                          ),
                                          const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(po.poNumber, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                              Text('PO Total: ${settings.formatCurrency(po.totalAmount)}', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 13)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        _buildStatusBadge(po.status),
                                        const SizedBox(height: 4),
                                        _buildPaymentStatusBadge(paymentStatus),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Divider(height: 1),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Paid: ${settings.formatCurrency(totalPaid)} / ${settings.formatCurrency(po.totalAmount)}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: totalPaid >= po.totalAmount - 0.01
                                            ? const Color(0xFF10B981)
                                            : totalPaid > 0.01
                                                ? const Color(0xFFF59E0B)
                                                : Colors.grey,
                                      ),
                                    ),
                                    if (remaining > 0.01)
                                      Text(
                                        'Owed: ${settings.formatCurrency(remaining)}',
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFFEF4444)),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    if (isPayable)
                                      ElevatedButton.icon(
                                        onPressed: () => context.push('/purchase-orders/pay/${po.id}'),
                                        icon: const Icon(Icons.payment, size: 16, color: Colors.white),
                                        label: const Text('Pay', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF3B82F6),
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        ),
                                      ),
                                    if (isReceivable)
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          final confirmed = await showDialog<bool>(
                                            context: context,
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
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text('Purchase order received! Products and stock updated.'),
                                                backgroundColor: Color(0xFF10B981),
                                              ));
                                            }
                                          }
                                        },
                                        icon: const Icon(Icons.inventory_2, size: 16, color: Colors.white),
                                        label: const Text('Receive', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF10B981),
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        ),
                                      ),
                                    OutlinedButton.icon(
                                      onPressed: () => context.go('/purchase-orders/edit/${po.id}'),
                                      icon: const Icon(Icons.edit, size: 16, color: Color(0xFF14B8A6)),
                                      label: const Text('Edit', style: TextStyle(color: Color(0xFF14B8A6), fontSize: 12, fontWeight: FontWeight.w600)),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        side: const BorderSide(color: Color(0xFF14B8A6)),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 20),
                                      tooltip: 'Delete PO',
                                      onPressed: () async {
                                        final confirmed = await showDialog<bool>(
                                          context: context,
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
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text('Purchase order deleted successfully.'),
                                                backgroundColor: Color(0xFF10B981),
                                              ));
                                            }
                                          } catch (e) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text('Error deleting purchase order: $e'),
                                                backgroundColor: const Color(0xFFEF4444),
                                              ));
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
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
