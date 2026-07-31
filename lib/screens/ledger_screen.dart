import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/ledger_entry.dart';
import '../models/settings.dart';
import '../providers/ledger_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/invoice_provider.dart';
import '../providers/expense_provider.dart';
import '../providers/payment_provider.dart';
import '../providers/client_provider.dart';
import '../providers/supplier_provider.dart';
import '../providers/supplier_payment_provider.dart';
import '../providers/purchase_order_provider.dart';
import '../providers/product_provider.dart';
import '../models/invoice.dart';
import '../models/expense.dart';
import '../models/payment.dart';
import '../models/purchase_order.dart';
import '../theme.dart';

class LedgerScreen extends ConsumerStatefulWidget {
  const LedgerScreen({super.key});

  @override
  ConsumerState<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends ConsumerState<LedgerScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = ref.watch(ledgerProvider);
    final settings = ref.watch(settingsProvider);
    final invoices = ref.watch(invoicesProvider);
    final expenses = ref.watch(expensesProvider);
    final payments = ref.watch(paymentsProvider);
    final purchaseOrders = ref.watch(purchaseOrdersProvider);
    final clients = ref.watch(clientsProvider);
    final suppliers = ref.watch(suppliersProvider);
    final filter = ref.watch(ledgerFilterProvider);
    final products = ref.watch(productsProvider);

    final clientMap = {for (final c in clients) c.id: c.name};
    final supplierMap = {for (final s in suppliers) s.id: s.name};

    String appBarTitle = 'General Ledger';
    if (filter.clientId != null) {
      appBarTitle = '${clientMap[filter.clientId] ?? "Client"} Account';
    } else if (filter.supplierId != null) {
      appBarTitle = '${supplierMap[filter.supplierId] ?? "Supplier"} Account';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          if (filter.startDate != null || filter.endDate != null || filter.typeFilter != null || filter.searchQuery.isNotEmpty || filter.clientId != null || filter.supplierId != null || filter.sortOrder != LedgerSortOrder.recent)
            IconButton(
              icon: const Icon(Icons.clear_all),
              tooltip: 'Clear filters',
              onPressed: () {
                ref.read(ledgerFilterProvider.notifier).clearFilters();
                _searchController.clear();
              },
            ),
          PopupMenuButton<LedgerSortOrder>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort transactions',
            onSelected: (order) {
              ref.read(ledgerFilterProvider.notifier).setSortOrder(order);
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: LedgerSortOrder.recent,
                child: Row(
                  children: [
                    Icon(Icons.history, color: filter.sortOrder == LedgerSortOrder.recent ? theme.colorScheme.primary : Colors.grey),
                    const SizedBox(width: 8),
                    Text('Recent First', style: TextStyle(fontWeight: filter.sortOrder == LedgerSortOrder.recent ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: LedgerSortOrder.oldest,
                child: Row(
                  children: [
                    Icon(Icons.arrow_upward, color: filter.sortOrder == LedgerSortOrder.oldest ? theme.colorScheme.primary : Colors.grey),
                    const SizedBox(width: 8),
                    Text('Oldest First', style: TextStyle(fontWeight: filter.sortOrder == LedgerSortOrder.oldest ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: LedgerSortOrder.amountHigh,
                child: Row(
                  children: [
                    Icon(Icons.trending_up, color: filter.sortOrder == LedgerSortOrder.amountHigh ? theme.colorScheme.primary : Colors.grey),
                    const SizedBox(width: 8),
                    Text('Highest Amount', style: TextStyle(fontWeight: filter.sortOrder == LedgerSortOrder.amountHigh ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: LedgerSortOrder.amountLow,
                child: Row(
                  children: [
                    Icon(Icons.trending_down, color: filter.sortOrder == LedgerSortOrder.amountLow ? theme.colorScheme.primary : Colors.grey),
                    const SizedBox(width: 8),
                    Text('Lowest Amount', style: TextStyle(fontWeight: filter.sortOrder == LedgerSortOrder.amountLow ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.date_range),
            tooltip: 'Filter by date',
            onPressed: () => _showDateFilter(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildDynamicSummaryCards(context, theme, settings, filter, invoices, expenses, payments, purchaseOrders, products),
          _buildFilterBar(context),
          Expanded(child: _buildTransactionList(context, theme, entries, settings, filter)),
        ],
      ),
    );
  }

  Widget _buildDynamicSummaryCards(
    BuildContext context,
    ThemeData theme,
    AppSettings settings,
    LedgerFilterState filter,
    List<Invoice> invoices,
    List<Expense> expenses,
    List<Payment> payments,
    List<PurchaseOrder> pos,
    List<dynamic> products,
  ) {
    final productMap = {for (final p in products) p.id: p};

    if (filter.clientId != null) {
      final invoiceMap = {for (final i in invoices) i.id: i};
      final clientInvoices = invoices.where((i) => i.clientId == filter.clientId && i.status != 'Draft' && i.status != 'Cancelled').toList();
      final totalBilled = clientInvoices.fold(0.0, (s, i) => s + i.totalAmount);
      final totalPaid = payments.where((p) => p.clientId == filter.clientId).fold(0.0, (s, p) => s + p.amount);
      final clientExpenses = expenses.where((e) => e.clientId == filter.clientId && !e.isBillable).fold(0.0, (s, e) => s + e.amount);
      
      final billableExpenses = expenses.where((e) {
        if (e.clientId != filter.clientId || !e.isBillable) return false;
        if (e.invoiceId == null) return true;
        final linkedInv = invoiceMap[e.invoiceId];
        return linkedInv == null || linkedInv.status == 'Draft' || linkedInv.status == 'Cancelled';
      }).fold(0.0, (s, e) => s + e.amount * (1 + e.markupPercent / 100));
      final dues = totalBilled + billableExpenses - totalPaid;
      final clientRevenue = clientInvoices.fold(0.0, (s, i) => s + (i.totalAmount - i.taxTotal));

      final expensesByInvoice = <String, List<Expense>>{};
      for (final e in expenses) {
        if (e.invoiceId != null) {
          expensesByInvoice.putIfAbsent(e.invoiceId!, () => []).add(e);
        }
      }

      double clientCogs = 0;
      for (final inv in clientInvoices) {
        for (final item in inv.items) {
          if (item.productId != null) {
            final prod = productMap[item.productId];
            if (prod != null) {
              clientCogs += item.quantity * prod.costPrice;
            }
          }
        }
        final linkedExpenses = expensesByInvoice[inv.id] ?? [];
        for (final exp in linkedExpenses) {
          clientCogs += exp.amount;
        }
      }
      final clientProfit = clientRevenue - clientCogs - clientExpenses;

      return _buildSummaryCardsRow(theme, settings, [
        _CardData('Total Billed', totalBilled, Icons.trending_up, const [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
        _CardData('Total Paid', totalPaid, Icons.payments, const [Color(0xFF10B981), Color(0xFF059669)]),
        _CardData('Net Profit', clientProfit, Icons.account_balance, clientProfit >= 0 ? const [Color(0xFF10B981), Color(0xFF059669)] : const [Color(0xFFEF4444), Color(0xFFDC2626)]),
        _CardData('Outstanding Dues', dues, Icons.pending_actions, const [Color(0xFFF59E0B), Color(0xFFD97706)]),
      ]);
    } else if (filter.supplierId != null) {
      final supplierPos = pos.where((po) => po.supplierId == filter.supplierId && po.status != 'Draft' && po.status != 'Cancelled').toList();
      final totalPurchased = supplierPos.fold(0.0, (s, po) => s + po.totalAmount);
      final supplierPaymentsList = ref.watch(supplierPaymentsProvider).where((sp) => sp.supplierId == filter.supplierId).toList();
      final totalPaid = supplierPaymentsList.fold(0.0, (s, sp) => s + sp.amount);
      final outstandingOwed = totalPurchased - totalPaid;
      final totalCount = supplierPos.length.toDouble();

      return _buildSummaryCardsRow(theme, settings, [
        _CardData('Total Purchased', totalPurchased, Icons.shopping_cart, const [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
        _CardData('Total Paid', totalPaid, Icons.payments, const [Color(0xFF10B981), Color(0xFF059669)]),
        _CardData('Outstanding Owed', outstandingOwed, Icons.pending_actions, const [Color(0xFFF59E0B), Color(0xFFD97706)]),
        _CardData('Total POs', totalCount, Icons.numbers, const [Color(0xFF14B8A6), Color(0xFF0D9488)], isCount: true),
      ]);
    } else {
      final validInvoices = invoices.where((i) => i.status != 'Draft' && i.status != 'Cancelled').toList();
      final totalRevenue = validInvoices.fold(0.0, (s, i) => s + (i.totalAmount - i.taxTotal));
      final totalExpenses = expenses.where((e) => !e.isBillable).fold(0.0, (s, e) => s + e.amount);
      final totalRevenueGross = validInvoices.fold(0.0, (s, i) => s + i.totalAmount);
      final validInvoiceIds = validInvoices.map((i) => i.id).toSet();
      final totalCollected = payments.where((p) => validInvoiceIds.contains(p.invoiceId)).fold(0.0, (s, p) => s + p.amount);
      final totalUnbilledExpenses = expenses.where((e) {
        if (!e.isBillable) return false;
        if (e.invoiceId == null) return true;
        final linkedInv = invoices.where((i) => i.id == e.invoiceId).firstOrNull;
        return linkedInv == null || linkedInv.status == 'Draft' || linkedInv.status == 'Cancelled';
      }).fold(0.0, (s, e) => s + e.amount * (1 + e.markupPercent / 100));
      final clientOutstanding = totalRevenueGross + totalUnbilledExpenses - totalCollected;

      final validPos = pos.where((po) => po.status != 'Draft' && po.status != 'Cancelled').toList();
      final totalPurchases = validPos.fold(0.0, (s, po) => s + po.totalAmount);
      final totalSupplierPaid = ref.watch(supplierPaymentsProvider).fold(0.0, (s, sp) => s + sp.amount);
      final supplierOutstanding = totalPurchases - totalSupplierPaid;
      final netOutstanding = clientOutstanding + supplierOutstanding;

      double totalCogs = 0;
      for (final inv in validInvoices) {
        for (final item in inv.items) {
          if (item.productId != null) {
            final prod = productMap[item.productId];
            if (prod != null) {
              totalCogs += item.quantity * prod.costPrice;
            }
          }
        }
        final linkedExpenses = expenses.where((e) => e.invoiceId == inv.id);
        for (final exp in linkedExpenses) {
          totalCogs += exp.amount;
        }
      }
      final netBalance = totalRevenue - totalCogs - totalExpenses;

      return _buildSummaryCardsRow(theme, settings, [
        _CardData('Revenue', totalRevenue, Icons.trending_up, const [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
        _CardData('Expenses', totalExpenses, Icons.trending_down, const [Color(0xFFEF4444), Color(0xFFDC2626)]),
        _CardData('Net Balance', netBalance, Icons.account_balance, netBalance >= 0 ? const [Color(0xFF10B981), Color(0xFF059669)] : const [Color(0xFFEF4444), Color(0xFFDC2626)]),
        _CardData('Outstanding', netOutstanding, Icons.pending_actions, const [Color(0xFFF59E0B), Color(0xFFD97706)]),
      ]);
    }
  }

  Widget _buildSummaryCardsRow(ThemeData theme, AppSettings settings, List<_CardData> cards) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 400;
          final cardWidth = isCompact
              ? (constraints.maxWidth - 8) / 2
              : (constraints.maxWidth - 24) / 4;

          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cards.map((c) => SizedBox(
              width: cardWidth,
              child: _buildStatCard(
                c.title,
                c.isCount ? c.value.toStringAsFixed(0) : _fmt(c.value, settings),
                c.icon,
                c.gradientColors,
              ),
            )).toList(),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, List<Color> gradientColors) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: 20),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 11, fontWeight: FontWeight.w500)),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    final filter = ref.watch(ledgerFilterProvider);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        children: [
          _buildAccountSelector(context),
          SizedBox(
            height: 38,
            child: TextField(
              controller: _searchController,
              style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: 'Search by reference, description, or name...',
                hintStyle: TextStyle(fontSize: 13, color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
                prefixIcon: Icon(Icons.search, size: 18, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(ledgerFilterProvider.notifier).setSearchQuery('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => ref.read(ledgerFilterProvider.notifier).setSearchQuery(v),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 32,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('All', null, filter.typeFilter),
                _buildFilterChip('Invoices', LedgerEntryType.invoice, filter.typeFilter),
                _buildFilterChip('Payments', LedgerEntryType.payment, filter.typeFilter),
                _buildFilterChip('Expenses', LedgerEntryType.expense, filter.typeFilter),
                _buildFilterChip('Purchase Orders', LedgerEntryType.purchaseOrder, filter.typeFilter),
                _buildFilterChip('Estimates', LedgerEntryType.estimate, filter.typeFilter),
                _buildFilterChip('Supplier Payments', LedgerEntryType.supplierPayment, filter.typeFilter),
              ],
            ),
          ),
          if (filter.startDate != null || filter.endDate != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                children: [
                  Icon(Icons.date_range, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                  const SizedBox(width: 4),
                  Text(
                    '${filter.startDate != null ? _formatShortDate(filter.startDate!) : 'Any'} - ${filter.endDate != null ? _formatShortDate(filter.endDate!) : 'Any'}',
                    style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      ref.read(ledgerFilterProvider.notifier).setDateRange(null, null);
                    },
                    child: Text('Clear', style: TextStyle(fontSize: 12, color: AppTheme.indigo, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAccountSelector(BuildContext context) {
    final filter = ref.watch(ledgerFilterProvider);
    final clients = ref.watch(clientsProvider);
    final suppliers = ref.watch(suppliersProvider);
    final theme = Theme.of(context);

    String? selectedValue;
    if (filter.clientId != null) {
      selectedValue = 'client_${filter.clientId}';
    } else if (filter.supplierId != null) {
      selectedValue = 'supplier_${filter.supplierId}';
    } else {
      selectedValue = 'general';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.15)),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        isExpanded: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            filter.clientId != null
                ? Icons.person_outline
                : filter.supplierId != null
                    ? Icons.local_shipping_outlined
                    : Icons.account_balance_outlined,
            color: filter.clientId != null
                ? Colors.green
                : filter.supplierId != null
                    ? Colors.orange
                    : theme.colorScheme.primary,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: InputBorder.none,
        ),
        dropdownColor: theme.colorScheme.surfaceContainer,
        style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 14),
        items: [
          DropdownMenuItem<String>(
            value: 'general',
            child: Row(
              children: [
                Icon(Icons.account_balance, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                const Text('General Ledger (All Accounts)', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          if (clients.isNotEmpty) ...[
            const DropdownMenuItem<String>(
              enabled: false,
              value: 'header_clients',
              child: Text('CLIENT ACCOUNTS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            ...clients.map((c) => DropdownMenuItem<String>(
              value: 'client_${c.id}',
              child: Row(
                children: [
                  const Icon(Icons.person, size: 18, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(child: Text(c.name, overflow: TextOverflow.ellipsis)),
                ],
              ),
            )),
          ],
          if (suppliers.isNotEmpty) ...[
            const DropdownMenuItem<String>(
              enabled: false,
              value: 'header_suppliers',
              child: Text('SUPPLIER ACCOUNTS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            ...suppliers.map((s) => DropdownMenuItem<String>(
              value: 'supplier_${s.id}',
              child: Row(
                children: [
                  const Icon(Icons.local_shipping, size: 18, color: Colors.orange),
                  const SizedBox(width: 8),
                  Expanded(child: Text(s.name, overflow: TextOverflow.ellipsis)),
                ],
              ),
            )),
          ],
        ],
        onChanged: (value) {
          if (value == null || value == 'general') {
            ref.read(ledgerFilterProvider.notifier).setClientFilter(null);
          } else if (value.startsWith('client_')) {
            final id = value.substring('client_'.length);
            ref.read(ledgerFilterProvider.notifier).setClientFilter(id);
          } else if (value.startsWith('supplier_')) {
            final id = value.substring('supplier_'.length);
            ref.read(ledgerFilterProvider.notifier).setSupplierFilter(id);
          }
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, LedgerEntryType? type, LedgerEntryType? current) {
    final selected = type == current;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: FilterChip(
        label: Text(label, style: TextStyle(fontSize: 12, fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
        selected: selected,
        onSelected: (_) {
          ref.read(ledgerFilterProvider.notifier).setTypeFilter(selected ? null : type);
        },
        visualDensity: VisualDensity.compact,
        selectedColor: type?.color.withValues(alpha: 0.15) ?? AppTheme.indigo.withValues(alpha: 0.15),
        checkmarkColor: type?.color ?? AppTheme.indigo,
        labelStyle: TextStyle(color: selected ? (type?.color ?? AppTheme.indigo) : null),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
    );
  }

  bool _isAddition(LedgerEntry entry, LedgerFilterState filter) {
    if (filter.clientId != null) {
      return entry.type == LedgerEntryType.invoice || entry.type == LedgerEntryType.expense;
    } else if (filter.supplierId != null) {
      return entry.type == LedgerEntryType.purchaseOrder;
    } else {
      return entry.type == LedgerEntryType.invoice || entry.type == LedgerEntryType.purchaseOrder;
    }
  }

  Widget _buildTransactionList(BuildContext context, ThemeData theme, List<LedgerEntry> entries, AppSettings settings, LedgerFilterState filter) {

    if (entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book_outlined, size: 64, color: theme.colorScheme.onSurface.withValues(alpha: 0.15)),
            const SizedBox(height: 16),
            Text('No ledger entries found', style: TextStyle(fontSize: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.4))),
            const SizedBox(height: 4),
            Text('Create invoices, expenses, or payments\nto see them in the ledger',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
            ),
          ],
        ),
      );
    }

    final grouped = <String, List<LedgerEntry>>{};
    final groupOrder = <String>[];
    for (final entry in entries) {
      final key = entry.dateGroup;
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
        groupOrder.add(key);
      }
      grouped[key]!.add(entry);
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: groupOrder.length,
      itemBuilder: (context, index) {
        final groupKey = groupOrder[index];
        final groupEntries = grouped[groupKey]!;

        double groupAdditions = 0;
        double groupSubtractions = 0;
        for (final entry in groupEntries) {
          if (entry.type != LedgerEntryType.estimate) {
            final isAdd = _isAddition(entry, filter);
            final val = entry.debit > 0 ? entry.debit : entry.credit;
            if (isAdd) {
              groupAdditions += val;
            } else {
              groupSubtractions += val;
            }
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGroupHeader(theme, groupKey, groupAdditions, groupSubtractions, settings),
            ...groupEntries.map((entry) => _buildEntryRow(context, theme, entry, settings, filter)),
          ],
        );
      },
    );
  }

  Widget _buildGroupHeader(ThemeData theme, String label, double addition, double subtraction, AppSettings settings) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
          const Spacer(),
          if (addition > 0)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text('+${_fmt(addition, settings)}', style: TextStyle(fontSize: 12, color: const Color(0xFF10B981), fontWeight: FontWeight.w600)),
            ),
          if (subtraction > 0)
            Text('-${_fmt(subtraction, settings)}', style: TextStyle(fontSize: 12, color: const Color(0xFFEF4444), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildEntryRow(BuildContext context, ThemeData theme, LedgerEntry entry, AppSettings settings, LedgerFilterState filter) {
    final statusColor = _statusColor(entry.status);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToSource(context, entry),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: entry.type.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(entry.type.icon, size: 18, color: entry.type.color),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.referenceNumber,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: theme.colorScheme.onSurface),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      entry.description,
                      style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (entry.counterpartyName != null)
                      Text(
                        entry.counterpartyName!,
                        style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(entry.formattedDate, style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface.withValues(alpha: 0.4))),
                    const SizedBox(height: 2),
                    if (entry.type == LedgerEntryType.estimate)
                      Text(_fmt(entry.debit, settings),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: entry.type.color,
                        ),
                      )
                    else
                      Builder(
                        builder: (context) {
                          final isAdd = _isAddition(entry, filter);
                          final val = entry.debit > 0 ? entry.debit : entry.credit;
                          return Text(
                            '${isAdd ? '+' : '-'}${_fmt(val, settings)}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isAdd ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(entry.status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: statusColor)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _fmt(entry.balance, settings),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Paid':
      case 'Completed':
      case 'Received':
      case 'Converted':
        return const Color(0xFF10B981);
      case 'Pending':
      case 'Sent':
      case 'Partial':
        return const Color(0xFFF59E0B);
      case 'Overdue':
      case 'Cancelled':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }

  void _navigateToSource(BuildContext context, LedgerEntry entry) {
    final id = entry.id.substring(entry.id.indexOf('_') + 1);
    switch (entry.type) {
      case LedgerEntryType.invoice:
        context.go('/invoices/edit/$id');
        break;
      case LedgerEntryType.payment:
        // Payment entries don't have a direct edit route, navigate to payment history
        context.go('/payments');
        break;
      case LedgerEntryType.expense:
        context.go('/expenses/edit/$id');
        break;
      case LedgerEntryType.purchaseOrder:
        context.go('/purchase-orders/edit/$id');
        break;
      case LedgerEntryType.estimate:
        context.go('/estimates/edit/$id');
        break;
      case LedgerEntryType.supplierPayment:
        context.go('/payments');
        break;
    }
  }

  Future<void> _showDateFilter(BuildContext context) async {
    final filter = ref.read(ledgerFilterProvider);
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: filter.startDate != null && filter.endDate != null
          ? DateTimeRange(start: filter.startDate!, end: filter.endDate!)
          : null,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(primary: AppTheme.indigo),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      ref.read(ledgerFilterProvider.notifier).setDateRange(picked.start, picked.end);
    }
  }

  String _fmt(double v, AppSettings settings) {
    bool isNegative = v < 0;
    double absV = v.abs();
    String formatted;
    if (settings.numberFormat == 'lakhs') {
      if (absV >= 10000000) {
        formatted = '${(absV / 10000000).toStringAsFixed(1)}Cr';
      } else if (absV >= 100000) {
        formatted = '${(absV / 100000).toStringAsFixed(1)}L';
      } else if (absV >= 1000) {
        formatted = '${(absV / 1000).toStringAsFixed(1)}K';
      } else {
        formatted = absV.toStringAsFixed(0);
      }
    } else {
      if (absV >= 1000000) {
        formatted = '${(absV / 1000000).toStringAsFixed(1)}M';
      } else if (absV >= 1000) {
        formatted = '${(absV / 1000).toStringAsFixed(1)}K';
      } else {
        formatted = absV.toStringAsFixed(0);
      }
    }
    return '${settings.currencySymbol}${isNegative ? '-' : ''}$formatted';
  }

  String _formatShortDate(DateTime d) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }
}

class _CardData {
  final String title;
  final double value;
  final IconData icon;
  final List<Color> gradientColors;
  final bool isCount;
  _CardData(this.title, this.value, this.icon, this.gradientColors, {this.isCount = false});
}
