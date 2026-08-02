import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/invoice_provider.dart';
import '../providers/expense_provider.dart';
import '../providers/product_provider.dart';
import '../providers/payment_provider.dart';
import '../providers/estimate_provider.dart';
import '../providers/client_provider.dart';
import '../providers/purchase_order_provider.dart';
import '../providers/supplier_payment_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/theme_provider.dart';
import '../models/settings.dart';
import '../models/invoice.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';
import '../providers/recurring_profile_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkRecurringInvoices();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkRecurringInvoices();
    }
  }

  Future<void> _checkRecurringInvoices() async {
    try {
      final count = await ref.read(recurringProfilesProvider.notifier).checkAndGenerateInvoices();
      if (count > 0 && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Auto-generated $count invoice(s) from recurring profiles.'),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error auto-generating recurring invoices: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final invoices = ref.watch(invoicesProvider);
    final expenses = ref.watch(expensesProvider);
    final products = ref.watch(productsProvider);
    final estimates = ref.watch(estimatesProvider);
    final clients = ref.watch(clientsProvider);
    final settings = ref.watch(settingsProvider);
    final themeMode = ref.watch(themeModeProvider);
    final payments = ref.watch(paymentsProvider);
    final purchaseOrders = ref.watch(purchaseOrdersProvider);
    final supplierPayments = ref.watch(supplierPaymentsProvider);
    final theme = Theme.of(context);

    final invoiceMap = {for (final i in invoices) i.id: i};

    final validInvoices = invoices.where((inv) => inv.status != 'Draft' && inv.status != 'Cancelled').toList();
    final totalRevenue = validInvoices.fold(0.0, (sum, inv) => sum + (inv.totalAmount - inv.taxTotal));
    final validInvoiceIds = validInvoices.map((i) => i.id).toSet();
    final totalCollected = payments.where((p) => validInvoiceIds.contains(p.invoiceId)).fold(0.0, (sum, p) => sum + p.amount);
    
    final totalRevenueGross = validInvoices.fold(0.0, (sum, inv) => sum + inv.totalAmount);
    final totalUnbilledExpenses = expenses.where((e) {
      if (!e.isBillable) return false;
      if (e.invoiceId == null) return true;
      final linkedInv = invoiceMap[e.invoiceId];
      return linkedInv == null || linkedInv.status == 'Draft' || linkedInv.status == 'Cancelled';
    }).fold(0.0, (sum, e) => sum + e.amount * (1 + e.markupPercent / 100));

    final clientOutstanding = totalRevenueGross + totalUnbilledExpenses - totalCollected;
    final validPos = purchaseOrders.where((po) => po.status != 'Draft' && po.status != 'Cancelled').toList();
    final totalPurchases = validPos.fold(0.0, (s, po) => s + po.totalAmount);
    final totalSupplierPaid = supplierPayments.fold(0.0, (s, sp) => s + sp.amount);
    final supplierOutstanding = totalPurchases - totalSupplierPaid;

    final outstanding = clientOutstanding + supplierOutstanding;

    final totalExpenses = expenses.where((e) => !e.isBillable).fold(0.0, (sum, e) => sum + e.amount);
    final productMap = {for (final p in products) p.id: p};

    final expensesByInvoice = <String, List<dynamic>>{};
    for (final e in expenses) {
      if (e.invoiceId != null) {
        expensesByInvoice.putIfAbsent(e.invoiceId!, () => []).add(e);
      }
    }

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
      final linkedExpenses = expensesByInvoice[inv.id] ?? [];
      for (final exp in linkedExpenses) {
        totalCogs += exp.amount;
      }
    }
    final netProfit = totalRevenue - totalCogs - totalExpenses;
    final stockValue = products.fold(0.0, (sum, p) => sum + p.stockValue);
    final lowStockCount = products.where((p) => p.isLowStock).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome
            Text('Overview', style: theme.textTheme.titleLarge?.copyWith(fontSize: 28)),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 600;
                final cardWidth = isMobile 
                    ? (constraints.maxWidth - 12) / 2 
                    : (constraints.maxWidth - 36) / 4;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SizedBox(width: cardWidth, child: StatCard(title: 'Revenue', value: settings.formatCurrency(totalRevenue), icon: Icons.trending_up, gradientColors: const [Color(0xFF6366F1), Color(0xFF8B5CF6)], onTap: () => context.push('/ledger'))),
                    SizedBox(width: cardWidth, child: StatCard(title: 'Outstanding', value: settings.formatCurrency(outstanding), icon: Icons.pending_actions, gradientColors: const [Color(0xFFF59E0B), Color(0xFFD97706)], onTap: () => context.push('/ledger'))),
                    SizedBox(width: cardWidth, child: StatCard(title: 'Expenses', value: settings.formatCurrency(totalExpenses), icon: Icons.trending_down, gradientColors: const [Color(0xFFEF4444), Color(0xFFDC2626)], onTap: () => context.push('/expenses'))),
                    SizedBox(width: cardWidth, child: StatCard(title: 'Net Profit', value: settings.formatCurrency(netProfit), icon: Icons.account_balance, gradientColors: netProfit >= 0 ? const [Color(0xFF10B981), Color(0xFF059669)] : const [Color(0xFFEF4444), Color(0xFFDC2626)], onTap: () => context.push('/ledger'))),
                    SizedBox(width: cardWidth, child: StatCard(title: 'Stock Value', value: settings.formatCurrency(stockValue), icon: Icons.inventory_2, gradientColors: const [Color(0xFF14B8A6), Color(0xFF0D9488)], onTap: () => context.push('/products'))),
                    SizedBox(width: cardWidth, child: StatCard(title: 'Clients', value: '${clients.length}', icon: Icons.people, gradientColors: const [Color(0xFF3B82F6), Color(0xFF2563EB)], onTap: () => context.push('/clients'))),
                  ],
                );
              }
            ),
            const SizedBox(height: 24),
            // Quick Stats Row
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildMiniStat(theme, '${invoices.length}', 'Invoices', Icons.receipt_long, const Color(0xFF6366F1), onTap: () => context.push('/invoices')),
                _buildMiniStat(theme, '${purchaseOrders.length}', 'POs', Icons.shopping_cart, const Color(0xFF14B8A6), onTap: () => context.push('/purchase-orders')),
                _buildMiniStat(theme, '${estimates.length}', 'Estimates', Icons.description, const Color(0xFF8B5CF6), onTap: () => context.push('/estimates')),
                _buildMiniStat(theme, '${products.length}', 'Products', Icons.inventory, const Color(0xFF14B8A6), onTap: () => context.push('/products')),
                if (lowStockCount > 0) _buildMiniStat(theme, '$lowStockCount', 'Low Stock', Icons.warning, const Color(0xFFEF4444), onTap: () => context.push('/products')),
              ],
            ),
            const SizedBox(height: 24),
            // Chart
            _buildChartSection(theme, invoices, settings),
            const SizedBox(height: 24),
            // Recent Invoices
            _buildRecentActivity(context, invoices, settings, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(ThemeData theme, String value, String label, IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
          Text(label, style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
        ]),
      ),
    );
  }

  Widget _buildChartSection(ThemeData theme, List<Invoice> invoices, AppSettings settings) {
    final now = DateTime.now();
    final List<double> dailyRevenue = List.filled(7, 0.0);
    final List<String> days = [];
    
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      days.add(const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1]);
      
      final dailyInvoices = invoices.where((inv) => 
        inv.status == 'Paid' && 
        inv.issueDate.year == date.year && 
        inv.issueDate.month == date.month && 
        inv.issueDate.day == date.day
      );
      
      dailyRevenue[6 - i] = dailyInvoices.fold(0.0, (sum, inv) => sum + (inv.totalAmount - inv.taxTotal));
    }

    double maxY = dailyRevenue.reduce((a, b) => a > b ? a : b);
    if (maxY == 0) {
      maxY = 100;
    } else {
      maxY = maxY * 1.2;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Revenue Overview (Last 7 Days)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: BarChart(BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => theme.colorScheme.onSurface,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(settings.formatCurrency(rod.toY), const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
                    }
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                    final idx = value.toInt();
                    return SideTitleWidget(meta: meta, space: 4, child: Text(idx < days.length ? days[idx] : '', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5), fontSize: 12)));
                  })),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  for (int i = 0; i < 7; i++)
                    BarChartGroupData(x: i, barRods: [BarChartRodData(toY: dailyRevenue[i], gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)], begin: Alignment.bottomCenter, end: Alignment.topCenter), width: 16, borderRadius: BorderRadius.circular(6))]),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context, List<Invoice> invoices, AppSettings settings, ThemeData theme) {
    final recent = invoices.toList()..sort((a, b) => b.issueDate.compareTo(a.issueDate));
    final display = recent.take(5).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Invoices', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
            const SizedBox(height: 16),
            if (display.isEmpty) Text('No recent invoices.', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
            ...display.map((inv) {
              return InkWell(
                onTap: () => context.go('/invoices/edit/${inv.id}'),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      CircleAvatar(backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.1), radius: 20, child: const Icon(Icons.receipt, size: 20, color: Color(0xFF6366F1))),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(inv.invoiceNumber, style: TextStyle(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                        const SizedBox(height: 4),
                        StatusBadge(status: inv.status, fontSize: 10),
                      ])),
                      Text(settings.formatCurrency(inv.totalAmount), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: theme.colorScheme.onSurface)),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
