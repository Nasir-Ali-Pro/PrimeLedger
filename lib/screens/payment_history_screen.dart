import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/payment.dart';
import '../models/supplier_payment.dart';
import '../providers/payment_provider.dart';
import '../providers/supplier_payment_provider.dart';
import '../providers/client_provider.dart';
import '../providers/supplier_provider.dart';
import '../providers/invoice_provider.dart';
import '../providers/purchase_order_provider.dart';
import '../providers/settings_provider.dart';
import '../services/pdf_service.dart';
import '../theme.dart';

class PaymentHistoryScreen extends ConsumerStatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  ConsumerState<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends ConsumerState<PaymentHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _searchCtrl = TextEditingController();
  String _searchQuery = '';
  String? _selectedMethod;
  DateTimeRange? _selectedDateRange;

  final _supplierSearchCtrl = TextEditingController();
  String _supplierSearchQuery = '';
  String? _supplierSelectedMethod;
  DateTimeRange? _supplierSelectedDateRange;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _supplierSearchCtrl.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    setState(() {
      _searchCtrl.clear();
      _searchQuery = '';
      _selectedMethod = null;
      _selectedDateRange = null;
    });
  }

  void _clearSupplierFilters() {
    setState(() {
      _supplierSearchCtrl.clear();
      _supplierSearchQuery = '';
      _supplierSelectedMethod = null;
      _supplierSelectedDateRange = null;
    });
  }

  Future<void> _selectDateRange(BuildContext context, bool isSupplier) async {
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: isSupplier ? _supplierSelectedDateRange : _selectedDateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppTheme.indigo,
              ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isSupplier) {
          _supplierSelectedDateRange = picked;
        } else {
          _selectedDateRange = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final payments = ref.watch(paymentsProvider);
    final supplierPayments = ref.watch(supplierPaymentsProvider);
    final clients = ref.watch(clientsProvider);
    final suppliers = ref.watch(suppliersProvider);
    final invoices = ref.watch(invoicesProvider);
    final purchaseOrders = ref.watch(purchaseOrdersProvider);
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    final clientMap = {for (final c in clients) c.id: c.name};
    final invoiceMap = {for (final i in invoices) i.id: i.invoiceNumber};
    final supplierMap = {for (final s in suppliers) s.id: s.name};
    final poMap = {for (final po in purchaseOrders) po.id: po.poNumber};

    // Helpers
    String getClientName(String clientId) => clientMap[clientId] ?? 'Unknown Client';
    String getInvoiceNum(String invoiceId) => invoiceMap[invoiceId] ?? 'Unknown Invoice';
    String getSupplierName(String supplierId) => supplierMap[supplierId] ?? 'Unknown Supplier';
    String getPoNum(String poId) => poMap[poId] ?? 'Unknown PO';

    // Filter Client Payments
    final filteredPayments = payments.where((p) {
      final clientName = getClientName(p.clientId).toLowerCase();
      final invoiceNum = getInvoiceNum(p.invoiceId).toLowerCase();
      final refNum = (p.referenceNumber ?? '').toLowerCase();
      final matchesSearch = clientName.contains(_searchQuery.toLowerCase()) ||
          invoiceNum.contains(_searchQuery.toLowerCase()) ||
          refNum.contains(_searchQuery.toLowerCase());

      final matchesMethod = _selectedMethod == null || p.paymentMethod == _selectedMethod;

      final matchesDate = _selectedDateRange == null ||
          (p.date.isAfter(_selectedDateRange!.start.subtract(const Duration(days: 1))) &&
              p.date.isBefore(_selectedDateRange!.end.add(const Duration(days: 1))));

      return matchesSearch && matchesMethod && matchesDate;
    }).toList()
      ..sort((a, b) {
        final dateCmp = b.date.compareTo(a.date);
        if (dateCmp != 0) return dateCmp;
        return b.createdAt.compareTo(a.createdAt);
      });

    // Filter Supplier Payments
    final filteredSupplierPayments = supplierPayments.where((p) {
      final supplierName = getSupplierName(p.supplierId).toLowerCase();
      final poNum = getPoNum(p.purchaseOrderId).toLowerCase();
      final refNum = (p.referenceNumber ?? '').toLowerCase();
      final matchesSearch = supplierName.contains(_supplierSearchQuery.toLowerCase()) ||
          poNum.contains(_supplierSearchQuery.toLowerCase()) ||
          refNum.contains(_supplierSearchQuery.toLowerCase());

      final matchesMethod = _supplierSelectedMethod == null || p.paymentMethod == _supplierSelectedMethod;

      final matchesDate = _supplierSelectedDateRange == null ||
          (p.date.isAfter(_supplierSelectedDateRange!.start.subtract(const Duration(days: 1))) &&
              p.date.isBefore(_supplierSelectedDateRange!.end.add(const Duration(days: 1))));

      return matchesSearch && matchesMethod && matchesDate;
    }).toList()
      ..sort((a, b) {
        final dateCmp = b.date.compareTo(a.date);
        if (dateCmp != 0) return dateCmp;
        return b.createdAt.compareTo(a.createdAt);
      });

    // Client Stats
    final totalReceived = filteredPayments.fold(0.0, (sum, p) => sum + p.amount);
    final easypaisaTotal = filteredPayments
        .where((p) => p.paymentMethod.toLowerCase() == 'easypaisa')
        .fold(0.0, (sum, p) => sum + p.amount);
    final bankTotal = filteredPayments
        .where((p) => p.paymentMethod.toLowerCase() == 'bank transfer')
        .fold(0.0, (sum, p) => sum + p.amount);

    // Supplier Stats
    final totalPaidOut = filteredSupplierPayments.fold(0.0, (sum, p) => sum + p.amount);
    final supplierBankTotal = filteredSupplierPayments
        .where((p) => p.paymentMethod.toLowerCase() == 'bank transfer')
        .fold(0.0, (sum, p) => sum + p.amount);
    final supplierCashTotal = filteredSupplierPayments
        .where((p) => p.paymentMethod.toLowerCase() == 'cash')
        .fold(0.0, (sum, p) => sum + p.amount);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Payment History'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Client Payments (Inflow)'),
            Tab(text: 'Supplier Payments (Outflow)'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Export Report',
            onPressed: () async {
              if (_tabController.index == 0) {
                if (filteredPayments.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No client payments to export')),
                  );
                  return;
                }
                final headers = ['Date', 'Client', 'Invoice #', 'Method', 'Reference', 'Amount'];
                final data = filteredPayments.map((p) => [
                  DateFormat('yyyy-MM-dd').format(p.date),
                  getClientName(p.clientId),
                  getInvoiceNum(p.invoiceId),
                  p.paymentMethod,
                  p.referenceNumber ?? '-',
                  settings.formatCurrency(p.amount),
                ]).toList();
                
                await PdfService.generateReportPdf('Client Payments Report', headers, data, settings);
              } else {
                if (filteredSupplierPayments.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No supplier payments to export')),
                  );
                  return;
                }
                final headers = ['Date', 'Supplier', 'PO #', 'Method', 'Reference', 'Amount'];
                final data = filteredSupplierPayments.map((p) => [
                  DateFormat('yyyy-MM-dd').format(p.date),
                  getSupplierName(p.supplierId),
                  getPoNum(p.purchaseOrderId),
                  p.paymentMethod,
                  p.referenceNumber ?? '-',
                  settings.formatCurrency(p.amount),
                ]).toList();
                
                await PdfService.generateReportPdf('Supplier Payments Report', headers, data, settings);
              }
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Client Payments
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    _buildStatCard(
                      title: 'Total Received',
                      value: settings.formatCurrency(totalReceived),
                      icon: Icons.account_balance_wallet,
                      gradient: const [Color(0xFF6366F1), Color(0xFF4F46E5)],
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      title: 'via Easypaisa',
                      value: settings.formatCurrency(easypaisaTotal),
                      icon: Icons.phone_android,
                      gradient: const [Color(0xFF10B981), Color(0xFF059669)],
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      title: 'via Bank Transfer',
                      value: settings.formatCurrency(bankTotal),
                      icon: Icons.account_balance,
                      gradient: const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchCtrl,
                      decoration: InputDecoration(
                        hintText: 'Search by client, invoice, or TID...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchCtrl.text.isNotEmpty || _selectedMethod != null || _selectedDateRange != null
                            ? IconButton(
                                icon: const Icon(Icons.clear_all),
                                onPressed: _clearFilters,
                                tooltip: 'Clear Filters',
                              )
                            : null,
                      ),
                      onChanged: (v) => setState(() => _searchQuery = v),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _selectedMethod,
                            hint: const Text('Method'),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            items: [
                              const DropdownMenuItem<String>(value: null, child: Text('All Methods')),
                              ...Payment.methods.map((m) => DropdownMenuItem<String>(value: m, child: Text(m))),
                            ],
                            onChanged: (v) => setState(() => _selectedMethod = v),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.date_range, size: 16),
                            label: Text(
                              _selectedDateRange == null
                                  ? 'Filter Date'
                                  : '${DateFormat('MM/dd').format(_selectedDateRange!.start)} - ${DateFormat('MM/dd').format(_selectedDateRange!.end)}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => _selectDateRange(context, false),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filteredPayments.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history, size: 64, color: Colors.grey.shade300),
                            const SizedBox(height: 16),
                            Text('No payments found', style: TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('Try clearing filters or record a payment.', style: TextStyle(color: Colors.grey.shade400)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: filteredPayments.length,
                        itemBuilder: (context, index) {
                          final payment = filteredPayments[index];
                          final clientName = getClientName(payment.clientId);
                          final invoiceNum = getInvoiceNum(payment.invoiceId);
                          final isMobileWallet = payment.paymentMethod.toLowerCase() == 'easypaisa' ||
                              payment.paymentMethod.toLowerCase() == 'jazzcash';

                          return Slidable(
                            key: ValueKey(payment.id),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) async {
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Delete Payment Record'),
                                        content: const Text('Are you sure you want to delete this payment record? This will adjust the invoice outstanding balance.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(ctx).pop(false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.of(ctx).pop(true),
                                            child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirmed == true) {
                                      await ref.read(paymentsProvider.notifier).deletePayment(payment.id);
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
                              elevation: 1,
                              shadowColor: Colors.black.withValues(alpha: 0.02),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  leading: CircleAvatar(
                                    backgroundColor: (isMobileWallet ? const Color(0xFF10B981) : AppTheme.indigo)
                                        .withValues(alpha: 0.1),
                                    child: Icon(
                                      isMobileWallet ? Icons.phone_android : Icons.payment,
                                      color: isMobileWallet ? const Color(0xFF10B981) : AppTheme.indigo,
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          clientName,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        settings.formatCurrency(payment.amount),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isMobileWallet ? const Color(0xFF10B981) : AppTheme.indigo,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Invoice: $invoiceNum',
                                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                                      ),
                                      Text(
                                        DateFormat('MMM dd, yyyy').format(payment.date),
                                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Divider(height: 16),
                                          _buildDetailRow('Payment Method', payment.paymentMethod),
                                          const SizedBox(height: 6),
                                          _buildDetailRow('Reference ID', payment.referenceNumber ?? 'None'),
                                          if (payment.notes != null && payment.notes!.isNotEmpty) ...[
                                            const SizedBox(height: 6),
                                            _buildDetailRow('Notes', payment.notes!),
                                          ],
                                        ],
                                      ),
                                    )
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

          // Tab 2: Supplier Payments
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    _buildStatCard(
                      title: 'Total Paid Out',
                      value: settings.formatCurrency(totalPaidOut),
                      icon: Icons.upload_file,
                      gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      title: 'via Bank Transfer',
                      value: settings.formatCurrency(supplierBankTotal),
                      icon: Icons.account_balance,
                      gradient: const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      title: 'via Cash',
                      value: settings.formatCurrency(supplierCashTotal),
                      icon: Icons.money,
                      gradient: const [Color(0xFF10B981), Color(0xFF059669)],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _supplierSearchCtrl,
                      decoration: InputDecoration(
                        hintText: 'Search by supplier, PO, or TID...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _supplierSearchCtrl.text.isNotEmpty || _supplierSelectedMethod != null || _supplierSelectedDateRange != null
                            ? IconButton(
                                icon: const Icon(Icons.clear_all),
                                onPressed: _clearSupplierFilters,
                                tooltip: 'Clear Filters',
                              )
                            : null,
                      ),
                      onChanged: (v) => setState(() => _supplierSearchQuery = v),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _supplierSelectedMethod,
                            hint: const Text('Method'),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            items: [
                              const DropdownMenuItem<String>(value: null, child: Text('All Methods')),
                              ...SupplierPayment.methods.map((m) => DropdownMenuItem<String>(value: m, child: Text(m))),
                            ],
                            onChanged: (v) => setState(() => _supplierSelectedMethod = v),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.date_range, size: 16),
                            label: Text(
                              _supplierSelectedDateRange == null
                                  ? 'Filter Date'
                                  : '${DateFormat('MM/dd').format(_supplierSelectedDateRange!.start)} - ${DateFormat('MM/dd').format(_supplierSelectedDateRange!.end)}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => _selectDateRange(context, true),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filteredSupplierPayments.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history, size: 64, color: Colors.grey.shade300),
                            const SizedBox(height: 16),
                            Text('No supplier payments found', style: TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('Record a payment via Purchase Orders screen.', style: TextStyle(color: Colors.grey.shade400)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: filteredSupplierPayments.length,
                        itemBuilder: (context, index) {
                          final payment = filteredSupplierPayments[index];
                          final supplierName = getSupplierName(payment.supplierId);
                          final poNum = getPoNum(payment.purchaseOrderId);
                          final isCash = payment.paymentMethod.toLowerCase() == 'cash';

                          return Slidable(
                            key: ValueKey(payment.id),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) async {
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Delete Payment Record'),
                                        content: const Text('Are you sure you want to delete this payment record? This will adjust the Purchase Order outstanding balance.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(ctx).pop(false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.of(ctx).pop(true),
                                            child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirmed == true) {
                                      await ref.read(supplierPaymentsProvider.notifier).deletePayment(payment.id);
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
                              elevation: 1,
                              shadowColor: Colors.black.withValues(alpha: 0.02),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  leading: CircleAvatar(
                                    backgroundColor: (isCash ? const Color(0xFF10B981) : AppTheme.indigo)
                                        .withValues(alpha: 0.1),
                                    child: Icon(
                                      isCash ? Icons.money : Icons.payment,
                                      color: isCash ? const Color(0xFF10B981) : AppTheme.indigo,
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          supplierName,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        settings.formatCurrency(payment.amount),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isCash ? const Color(0xFF10B981) : AppTheme.indigo,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'PO: $poNum',
                                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                                      ),
                                      Text(
                                        DateFormat('MMM dd, yyyy').format(payment.date),
                                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Divider(height: 16),
                                          _buildDetailRow('Payment Method', payment.paymentMethod),
                                          const SizedBox(height: 6),
                                          _buildDetailRow('Reference ID', payment.referenceNumber ?? 'None'),
                                          if (payment.notes != null && payment.notes!.isNotEmpty) ...[
                                            const SizedBox(height: 6),
                                            _buildDetailRow('Notes', payment.notes!),
                                          ],
                                        ],
                                      ),
                                    )
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
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required List<Color> gradient,
  }) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: 24),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
