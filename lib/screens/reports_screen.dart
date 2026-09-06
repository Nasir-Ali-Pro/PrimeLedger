import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/invoice_provider.dart';
import '../providers/expense_provider.dart';
import '../providers/product_provider.dart';
import '../providers/client_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/purchase_order_provider.dart';
import '../services/pdf_service.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Reports & Export')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Financial Reports', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildReportCard(
              context,
              title: 'Profit & Loss Statement',
              subtitle: 'Generate PDF of revenue, expenses, and net profit',
              icon: Icons.account_balance,
              color: const Color(0xFF6366F1),
              onTap: () => _generatePLReport(context, ref),
            ),
            const SizedBox(height: 12),
            _buildReportCard(
              context,
              title: 'Tax Summary',
              subtitle: 'Generate PDF of collected tax vs paid tax',
              icon: Icons.receipt_long,
              color: const Color(0xFFF59E0B),
              onTap: () => _generateTaxReport(context, ref),
            ),
            const SizedBox(height: 32),
            Text('Data Export', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Generate shareable PDF exports of your data', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
            const SizedBox(height: 16),
            _buildExportCard(
              context,
              title: 'Export Clients',
              icon: Icons.people,
              onTap: () => _exportClients(context, ref),
            ),
            const SizedBox(height: 12),
            _buildExportCard(
              context,
              title: 'Export Inventory',
              icon: Icons.inventory_2,
              onTap: () => _exportInventory(context, ref),
            ),
            const SizedBox(height: 12),
            _buildExportCard(
              context,
              title: 'Export Invoices',
              icon: Icons.receipt,
              onTap: () => _exportInvoices(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.picture_as_pdf, color: Color(0xFFEF4444)),
        onTap: onTap,
      ),
    );
  }

  Widget _buildExportCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF10B981)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.picture_as_pdf, color: Color(0xFFEF4444)),
        onTap: onTap,
      ),
    );
  }

  Future<void> _generatePLReport(BuildContext context, WidgetRef ref) async {
    final invoices = ref.read(invoicesProvider);
    final expenses = ref.read(expensesProvider);
    final settings = ref.read(settingsProvider);
    final products = ref.read(productsProvider);
    
    final invoiceMap = {for (final i in invoices) i.id: i};
    final validInvoices = invoices.where((i) => i.status != 'Draft' && i.status != 'Cancelled').toList();
    final revenue = validInvoices.fold(0.0, (sum, i) => sum + (i.totalAmount - i.taxTotal));

    final productMap = {for (final p in products) p.id: p};
    double productCogs = 0;
    for (final inv in validInvoices) {
      for (final item in inv.items) {
        if (item.productId != null) {
          final prod = productMap[item.productId];
          if (prod != null) {
            productCogs += item.quantity * prod.costPrice;
          }
        }
      }
    }

    double billedExpenseCogs = 0;
    double unbilledExpenseCost = 0;
    double nonBillableExpenseCost = 0;

    for (final exp in expenses) {
      if (exp.isBillable) {
        if (exp.invoiceId != null) {
          final linkedInv = invoiceMap[exp.invoiceId];
          if (linkedInv != null && linkedInv.status != 'Draft' && linkedInv.status != 'Cancelled') {
            billedExpenseCogs += exp.amount;
          } else {
            unbilledExpenseCost += exp.amount;
          }
        } else {
          unbilledExpenseCost += exp.amount;
        }
      } else {
        nonBillableExpenseCost += exp.amount;
      }
    }

    final totalCogs = productCogs + billedExpenseCogs;
    final totalExpenses = nonBillableExpenseCost + unbilledExpenseCost;
    final profit = revenue - totalCogs - totalExpenses;

    final headers = ['Category', 'Amount'];
    final data = [
      ['Total Revenue (Sales)', settings.formatCurrency(revenue)],
      ['Cost of Goods Sold (COGS)', settings.formatCurrency(totalCogs)],
      ['Total Operating Expenses', settings.formatCurrency(totalExpenses)],
      ['Net Profit', settings.formatCurrency(profit)],
    ];

    await PdfService.generateReportPdf('Profit & Loss Statement', headers, data, settings);
  }

  Future<void> _generateTaxReport(BuildContext context, WidgetRef ref) async {
    final invoices = ref.read(invoicesProvider);
    final pos = ref.read(purchaseOrdersProvider);
    final settings = ref.read(settingsProvider);
    
    final validInvoices = invoices.where((i) => i.status != 'Draft' && i.status != 'Cancelled').toList();
    final taxCollected = validInvoices.fold(0.0, (sum, i) => sum + i.taxTotal);

    final validPos = pos.where((p) => p.status == 'Received' || p.status == 'Partially Received').toList();
    final taxPaid = validPos.fold(0.0, (sum, p) => sum + p.taxTotal);
    final netTaxPayable = taxCollected - taxPaid;

    final headers = ['Tax Category Description', 'Amount'];
    final data = [
      ['Output Sales Tax Collected (Invoices)', settings.formatCurrency(taxCollected)],
      ['Input Purchase Tax Paid (Purchase Orders)', settings.formatCurrency(taxPaid)],
      ['Net Tax Payable / (Refund Credit)', settings.formatCurrency(netTaxPayable)],
    ];

    await PdfService.generateReportPdf('Tax Summary Report', headers, data, settings);
  }

  Future<void> _exportClients(BuildContext context, WidgetRef ref) async {
    final clients = ref.read(clientsProvider);
    final settings = ref.read(settingsProvider);
    
    final headers = ['Name', 'Email', 'Phone', 'Address'];
    final data = clients.map((c) => [c.name, c.email, c.phone, c.address]).toList();
    
    await PdfService.generateReportPdf('Client Roster', headers, data, settings);
  }

  Future<void> _exportInventory(BuildContext context, WidgetRef ref) async {
    final products = ref.read(productsProvider);
    final settings = ref.read(settingsProvider);
    
    final headers = ['Name', 'SKU', 'Category', 'Price', 'Qty'];
    final data = products.map((p) => [p.name, p.sku ?? '-', p.category, settings.formatCurrency(p.sellingPrice), p.quantity]).toList();
    
    await PdfService.generateReportPdf('Inventory Export', headers, data, settings);
  }

  Future<void> _exportInvoices(BuildContext context, WidgetRef ref) async {
    final invoices = ref.read(invoicesProvider);
    final settings = ref.read(settingsProvider);
    
    final headers = ['Invoice #', 'Date', 'Status', 'Total'];
    final data = invoices.map((i) => [i.invoiceNumber, i.issueDate.toIso8601String().split('T').first, i.status, settings.formatCurrency(i.totalAmount)]).toList();
    
    await PdfService.generateReportPdf('Invoices Export', headers, data, settings);
  }
}
