import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uuid/uuid.dart';
import '../providers/estimate_provider.dart';
import '../providers/invoice_provider.dart';
import '../providers/product_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/client_provider.dart';
import '../models/estimate.dart';
import '../models/invoice.dart';
import '../widgets/empty_state.dart';
import '../widgets/status_badge.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/loading_overlay.dart';

class EstimatesScreen extends ConsumerStatefulWidget {
  const EstimatesScreen({super.key});

  @override
  ConsumerState<EstimatesScreen> createState() => _EstimatesScreenState();
}

class _EstimatesScreenState extends ConsumerState<EstimatesScreen> {
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
    final allEstimates = ref.watch(estimatesProvider);
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);
    final clients = ref.watch(clientsProvider);
    final clientMap = {for (final c in clients) c.id: c.name};

    final filteredEstimates = allEstimates.where((est) {
      final q = _searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty ||
          est.estimateNumber.toLowerCase().contains(q) ||
          (clientMap[est.clientId]?.toLowerCase().contains(q) ?? false);
      final matchesStatus = _statusFilter == null || _statusFilter == 'All' ||
          est.status == _statusFilter;
      return matchesSearch && matchesStatus;
    }).toList();

    const statusOptions = ['All', 'Draft', 'Sent', 'Converted', 'Declined'];

    return Scaffold(
      appBar: AppBar(title: const Text('Estimates')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search estimates...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
            child: filteredEstimates.isEmpty
                ? EmptyState(
                    icon: Icons.description_outlined,
                    title: _searchQuery.isEmpty ? 'No estimates found' : 'No matches found',
                    subtitle: _searchQuery.isEmpty
                        ? 'Create your first estimate to send to clients'
                        : 'No estimates match your filters',
                    actionLabel: _searchQuery.isEmpty ? 'New Estimate' : null,
                    onAction: _searchQuery.isEmpty ? () => context.go('/estimates/new') : null,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredEstimates.length,
                    itemBuilder: (context, index) {
                      final est = filteredEstimates[index];
                      final clientName = clientMap[est.clientId] ?? 'Unknown Client';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Slidable(
                          key: ValueKey(est.id),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              if (est.status != 'Converted')
                                SlidableAction(
                                  onPressed: (ctx) async {
                                    final products = ref.read(productsProvider);
                                    final warnings = <String>[];
                                    for (final item in est.items) {
                                      if (item.productId != null) {
                                        final prod = products.where((p) => p.id == item.productId).firstOrNull;
                                        if (prod != null && item.quantity > prod.quantity) {
                                          warnings.add('• ${prod.name}: ${item.quantity} requested, but only ${prod.quantity} available in stock.');
                                        }
                                      }
                                    }

                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      builder: (dialogCtx) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        title: Text(warnings.isNotEmpty ? 'Low Product Availability' : 'Convert to Invoice?'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (warnings.isNotEmpty) ...[
                                              const Text(
                                                'The following item(s) exceed current inventory stock:',
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEF4444)),
                                              ),
                                              const SizedBox(height: 8),
                                              ...warnings.map((w) => Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Text(w, style: const TextStyle(fontSize: 13, color: Color(0xFFDC2626))),
                                              )),
                                              const SizedBox(height: 12),
                                              const Text('Converting will create an active invoice, deduct inventory stock, and log stock movements. Do you want to proceed?'),
                                            ] else ...[
                                              const Text('This will create an active invoice with these items, deduct inventory stock, log stock movements, and mark this estimate as Converted.'),
                                            ],
                                          ],
                                        ),
                                        actions: [
                                          TextButton(onPressed: () => Navigator.pop(dialogCtx, false), child: const Text('Cancel')),
                                          TextButton(
                                            onPressed: () => Navigator.pop(dialogCtx, true),
                                            child: Text(warnings.isNotEmpty ? 'Proceed Conversion' : 'Convert', style: const TextStyle(fontWeight: FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirmed != true) return;
                                    // ignore: use_build_context_synchronously
                                    LoadingOverlay.show(context, message: 'Converting & Updating Inventory...');
                                    try {
                                      final allInvoices = ref.read(invoicesProvider);
                                      final existingInv = allInvoices.where((i) => i.notes != null && i.notes!.contains(est.estimateNumber)).firstOrNull;

                                      final newInvoiceItems = est.items.map((i) => InvoiceItem(
                                        id: const Uuid().v4(),
                                        productId: i.productId,
                                        description: i.description,
                                        quantity: i.quantity,
                                        rate: i.rate,
                                        taxPercent: i.taxPercent,
                                        taxAmount: i.taxAmount,
                                        discountPercent: i.discountPercent,
                                        total: i.total,
                                      )).toList();

                                      String targetInvNum = '';
                                      if (existingInv != null) {
                                        targetInvNum = existingInv.invoiceNumber;
                                        final updatedInvoice = existingInv.copyWith(
                                          items: newInvoiceItems,
                                          subTotal: est.subTotal,
                                          taxTotal: est.taxTotal,
                                          totalAmount: est.totalAmount,
                                          discountPercent: est.discountPercent,
                                          discountAmount: est.discountAmount,
                                          notes: 'Converted from Estimate ${est.estimateNumber}',
                                        );
                                        await ref.read(invoicesProvider.notifier).updateInvoice(updatedInvoice);
                                      } else {
                                        targetInvNum = 'INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
                                        final invoice = Invoice(
                                          id: const Uuid().v4(),
                                          clientId: est.clientId,
                                          invoiceNumber: targetInvNum,
                                          issueDate: DateTime.now(),
                                          dueDate: DateTime.now().add(const Duration(days: 14)),
                                          subTotal: est.subTotal,
                                          taxTotal: est.taxTotal,
                                          totalAmount: est.totalAmount,
                                          status: 'Unpaid',
                                          notes: 'Converted from Estimate ${est.estimateNumber}',
                                          items: newInvoiceItems,
                                        );
                                        await ref.read(invoicesProvider.notifier).addInvoice(invoice);
                                      }

                                      final updated = est.copyWith(status: 'Converted');
                                      await ref.read(estimatesProvider.notifier).updateEstimate(updated);
                                      await ref.read(productsProvider.notifier).refresh();

                                      LoadingOverlay.hide();
                                      if (ctx.mounted) {
                                        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Converted to Invoice $targetInvNum! Inventory stock updated.'), backgroundColor: const Color(0xFF10B981)));
                                      }
                                    } catch (e) {
                                      LoadingOverlay.hide();
                                      if (ctx.mounted) {
                                        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Failed to convert: $e'), backgroundColor: const Color(0xFFEF4444)));
                                      }
                                    }
                                  },
                                  backgroundColor: const Color(0xFF6366F1),
                                  foregroundColor: Colors.white,
                                  icon: Icons.transform,
                                  label: 'Convert',
                                ),
                              if (est.status == 'Converted')
                                SlidableAction(
                                  onPressed: (ctx) async {
                                    final updated = est.copyWith(status: 'Sent');
                                    await ref.read(estimatesProvider.notifier).updateEstimate(updated);
                                    if (ctx.mounted) {
                                      ScaffoldMessenger.of(ctx).showSnackBar(
                                        const SnackBar(content: Text('Estimate status reverted to Sent!'), backgroundColor: Color(0xFF3B82F6)),
                                      );
                                    }
                                  },
                                  backgroundColor: const Color(0xFF3B82F6),
                                  foregroundColor: Colors.white,
                                  icon: Icons.undo,
                                  label: 'Revert',
                                ),
                              SlidableAction(
                                onPressed: (_) => _confirmDelete(est),
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
                                backgroundColor: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                                child: const Icon(Icons.description, color: Color(0xFF8B5CF6)),
                              ),
                              title: Row(
                                children: [
                                  Expanded(child: Text(est.estimateNumber, style: const TextStyle(fontWeight: FontWeight.bold))),
                                  Text(settings.formatCurrency(est.totalAmount), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(clientName, style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                              ),
                              trailing: StatusBadge(status: est.status),
                              onTap: () => context.go('/estimates/edit/${est.id}'),
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
        onPressed: () => context.go('/estimates/new'),
        icon: const Icon(Icons.add),
        label: const Text('New Estimate', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _confirmDelete(Estimate est) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Delete Estimate',
      message: 'Delete estimate "${est.estimateNumber}"? This cannot be undone.',
    );
    if (confirmed == true) {
      // ignore: use_build_context_synchronously
      LoadingOverlay.show(context, message: 'Deleting estimate...');
      try {
        await ref.read(estimatesProvider.notifier).deleteEstimate(est.id);
        LoadingOverlay.hide();
        scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Estimate deleted successfully.'), backgroundColor: Color(0xFF10B981)));
      } catch (e) {
        LoadingOverlay.hide();
        scaffoldMessenger.showSnackBar(SnackBar(content: Text('Failed to delete estimate: $e'), backgroundColor: const Color(0xFFEF4444)));
      }
    }
  }
}
