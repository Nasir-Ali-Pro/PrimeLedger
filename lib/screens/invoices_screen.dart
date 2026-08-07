import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../providers/invoice_provider.dart';
import '../providers/client_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/payment_provider.dart';
import '../providers/expense_provider.dart';
import '../services/pdf_service.dart';
import '../widgets/status_badge.dart';
import '../widgets/empty_state.dart';
import '../widgets/confirm_dialog.dart';

class InvoicesScreen extends ConsumerStatefulWidget {
  const InvoicesScreen({super.key});

  @override
  ConsumerState<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends ConsumerState<InvoicesScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String? _statusFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allInvoices = ref.watch(invoicesProvider);
    final settings = ref.watch(settingsProvider);
    final payments = ref.watch(paymentsProvider);
    final expenses = ref.watch(expensesProvider);
    final theme = Theme.of(context);

    final clients = ref.watch(clientsProvider);
    final clientMap = {for (final c in clients) c.id: c.name};
    final filteredInvoices = allInvoices.where((i) {
      final q = _searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty ||
          i.invoiceNumber.toLowerCase().contains(q) ||
          (clientMap[i.clientId]?.toLowerCase().contains(q) ?? false);
      final matchesStatus = _statusFilter == null || _statusFilter == 'All' ||
          i.status == _statusFilter;
      return matchesSearch && matchesStatus;
    }).toList();

    const statusOptions = ['All', 'Unpaid', 'Partially Paid', 'Paid', 'Overdue', 'Draft', 'Cancelled'];

    return Scaffold(
      appBar: AppBar(title: const Text('Invoices')),
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
            child: filteredInvoices.isEmpty
                    ? EmptyState(
                        icon: Icons.receipt_long,
                        title: 'No invoices found',
                        subtitle: _searchQuery.isEmpty && (_statusFilter == null || _statusFilter == 'All')
                            ? 'Tap the button below to create your first invoice'
                            : 'No invoices match your search/filter',
                        actionLabel: _searchQuery.isEmpty && (_statusFilter == null || _statusFilter == 'All') ? 'Create Invoice' : null,
                        onAction: _searchQuery.isEmpty && (_statusFilter == null || _statusFilter == 'All')
                            ? () => context.go('/invoices/new')
                            : null,
                      )
                    : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredInvoices.length,
                    itemBuilder: (context, index) {
                      final invoice = filteredInvoices[index];
                      return Slidable(
                        key: ValueKey(invoice.id),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            if (invoice.status != 'Paid')
                              SlidableAction(
                                onPressed: (_) =>
                                    context.go('/invoices/pay/${invoice.id}'),
                                backgroundColor: const Color(0xFF10B981),
                                foregroundColor: Colors.white,
                                icon: Icons.payments,
                                label: 'Pay',
                              ),
                            SlidableAction(
                              onPressed: (context) async {
                                final clients = ref.read(clientsProvider);
                                final settings = ref.read(settingsProvider);
                                String clientName = 'Unknown';
                                try {
                                  clientName = clients
                                      .firstWhere(
                                          (c) => c.id == invoice.clientId)
                                      .name;
                                } catch (e) {
                                  debugPrint(e.toString());
                                }

                                final clientInvoices = allInvoices.where((i) => i.clientId == invoice.clientId && i.status != 'Draft' && i.status != 'Cancelled').toList();
                                final totalBilled = clientInvoices.fold(0.0, (s, i) => s + i.totalAmount);
                                final totalPaid = payments.where((p) => p.clientId == invoice.clientId).fold(0.0, (s, p) => s + p.amount);
                                final billableExpenses = expenses.where((e) {
                                  if (e.clientId != invoice.clientId || !e.isBillable) return false;
                                  if (e.invoiceId == null) return true;
                                  final linkedInv = allInvoices.where((i) => i.id == e.invoiceId).firstOrNull;
                                  return linkedInv == null || linkedInv.status == 'Draft' || linkedInv.status == 'Cancelled';
                                }).fold(0.0, (s, e) => s + e.amount * (1 + e.markupPercent / 100));
                                final totalClientDues = totalBilled + billableExpenses - totalPaid;

                                final thisInvoicePayments = payments.where((p) => p.invoiceId == invoice.id).fold(0.0, (s, p) => s + p.amount);
                                final thisInvoiceRemaining = (invoice.totalAmount - thisInvoicePayments).clamp(0.0, double.infinity);
                                final previousDues = (totalClientDues - thisInvoiceRemaining).clamp(0.0, 999999999.0);

                                await PdfService.generateInvoicePdf({
                                  'client': clientName,
                                  'invoiceNumber': invoice.invoiceNumber,
                                  'issueDate': invoice.issueDate.toIso8601String(),
                                  'dueDate': invoice.dueDate.toIso8601String(),
                                  'status': invoice.status,
                                  'items': invoice.items.map((i) =>
                                      <String, dynamic>{
                                        'description': i.description,
                                        'quantity': i.quantity,
                                        'price': i.rate,
                                        'tax': i.taxPercent,
                                        'discount': i.discountPercent,
                                      }).toList(),
                                  'subtotal': invoice.subTotal,
                                  'tax': invoice.taxTotal,
                                  'discountPercent': invoice.discountPercent,
                                  'discountAmount': invoice.discountAmount,
                                  'withholdingTaxPercent': invoice.withholdingTaxPercent,
                                  'tax2Percent': invoice.tax2Percent,
                                  'total': invoice.totalAmount,
                                  'previousDues': previousDues,
                                  'amountPaid': thisInvoicePayments,
                                }, settings);
                              },
                              backgroundColor: const Color(0xFF6366F1),
                              foregroundColor: Colors.white,
                              icon: Icons.picture_as_pdf,
                              label: 'PDF',
                            ),
                            SlidableAction(
                              onPressed: (context) async {
                                final confirmed = await ConfirmDialog.show(
                                  context: context,
                                  title: 'Delete Invoice',
                                  message: 'Are you sure you want to delete this invoice? This will also delete all associated payments and revert inventory adjustments.',
                                  confirmLabel: 'Delete',
                                  icon: Icons.delete,
                                );

                                if (confirmed == true) {
                                  ref
                                      .read(invoicesProvider.notifier)
                                      .deleteInvoice(invoice.id);
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
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side:
                                BorderSide(color: Theme.of(context).dividerColor),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            leading: CircleAvatar(
                              backgroundColor:
                                  const Color(0xFF6366F1).withValues(alpha: 0.1),
                              child: const Icon(Icons.receipt_long,
                                  color: Color(0xFF6366F1)),
                            ),
                            title: Text(invoice.invoiceNumber,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            subtitle: Text(
                                settings.formatCurrency(invoice.totalAmount),
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w500)),
                            trailing: StatusBadge(status: invoice.status),
                            onTap: () {
                              context.go('/invoices/edit/${invoice.id}');
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go('/invoices/new');
        },
        backgroundColor: const Color(0xFF6366F1),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Create Invoice',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
