import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/estimate.dart';
import '../models/invoice.dart';
import '../providers/client_provider.dart';
import '../providers/estimate_provider.dart';
import '../providers/invoice_provider.dart';
import '../providers/product_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/loading_overlay.dart';
import '../theme.dart';
import '../widgets/product_search_sheet.dart';

class EstimateFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const EstimateFormScreen({super.key, this.id});

  @override
  ConsumerState<EstimateFormScreen> createState() => _EstimateFormScreenState();
}

class _EstimateFormScreenState extends ConsumerState<EstimateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedClientId;
  Estimate? _existing;
  final _notesCtrl = TextEditingController();
  DateTime _expiryDate = DateTime.now().add(const Duration(days: 30));

  List<Map<String, dynamic>> lineItems = [
    <String, dynamic>{'id': const Uuid().v4(), 'productId': null, 'description': '', 'quantity': 1, 'price': 0.0, 'tax': 0.0, 'discount': 0.0}
  ];

  double discountPercent = 0.0;
  double discountAmount = 0.0;
  double withholdingTaxPercent = 0.0;
  double tax2Percent = 0.0;

  double get subtotal => lineItems.fold(0.0, (sum, item) {
    double qty = (item['quantity'] ?? 1).toDouble();
    double price = (item['price'] ?? 0.0).toDouble();
    double discP = (item['discount'] ?? 0.0).toDouble();
    double taxable = (qty * price) * (1 - discP / 100);
    return sum + taxable;
  });
  
  double get taxTotal {
    double itemTaxSum = lineItems.fold(0.0, (sum, item) {
      double qty = (item['quantity'] ?? 1).toDouble();
      double price = (item['price'] ?? 0.0).toDouble();
      double discP = (item['discount'] ?? 0.0).toDouble();
      double taxable = (qty * price) * (1 - discP / 100);
      double taxPercent = (item['tax'] ?? 0.0).toDouble();
      return sum + (taxable * (taxPercent / 100));
    });
    double tax2Amount = subtotal * (tax2Percent / 100);
    return itemTaxSum + tax2Amount;
  }
  
  double get totalInvoiceDiscount => (subtotal * (discountPercent / 100)) + discountAmount;
  
  double get withholdingTaxAmount => subtotal * (withholdingTaxPercent / 100);
  
  double get total => subtotal + taxTotal - totalInvoiceDiscount - withholdingTaxAmount;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);
    lineItems = [
      <String, dynamic>{'id': const Uuid().v4(), 'productId': null, 'description': '', 'quantity': 1, 'price': 0.0, 'tax': settings.defaultTaxPercent, 'discount': 0.0}
    ];
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final estimates = ref.read(estimatesProvider);
        try {
          _existing = estimates.firstWhere((e) => e.id == widget.id);
          selectedClientId = _existing!.clientId;
          _notesCtrl.text = _existing!.notes ?? '';
          _expiryDate = _existing!.expiryDate;
          discountPercent = _existing!.discountPercent;
          discountAmount = _existing!.discountAmount;
          withholdingTaxPercent = _existing!.withholdingTaxPercent;
          tax2Percent = _existing!.tax2Percent;
          lineItems = _existing!.items.map((i) {
            double rate = i.rate;
            double taxPercent = i.taxPercent;
            return <String, dynamic>{
              'id': const Uuid().v4(),
              'productId': i.productId,
              'description': i.description,
              'quantity': i.quantity,
              'price': rate,
              'tax': taxPercent,
              'discount': i.discountPercent,
            };
          }).toList();
          setState(() {});
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    }
  }  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _convertToInvoice() async {
    if (_existing == null) return;
    
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Convert to Invoice?'),
        content: const Text('This will create a new Draft invoice with these items and mark this estimate as Converted.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Convert', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    
    // ignore: use_build_context_synchronously
    LoadingOverlay.show(context, message: 'Converting...');
    try {
      final invoice = Invoice(
        id: const Uuid().v4(),
        clientId: _existing!.clientId,
        invoiceNumber: 'INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        issueDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 14)),
        subTotal: _existing!.subTotal,
        taxTotal: _existing!.taxTotal,
        totalAmount: _existing!.totalAmount,
        status: 'Draft',
        items: _existing!.items.map((i) => InvoiceItem(
          id: const Uuid().v4(),
          productId: i.productId,
          description: i.description,
          quantity: i.quantity,
          rate: i.rate,
          taxPercent: i.taxPercent,
          taxAmount: i.taxAmount,
          discountPercent: i.discountPercent,
          total: i.total,
        )).toList(),
      );

      await ref.read(invoicesProvider.notifier).addInvoice(invoice);
      
      final updated = _existing!.copyWith(status: 'Converted');
      await ref.read(estimatesProvider.notifier).updateEstimate(updated);

      LoadingOverlay.hide();
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Converted to Invoice successfully!'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
      navigator.pop();
    } catch (e) {
      LoadingOverlay.hide();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Failed to convert: $e'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }
  void _showProductSearchBottomSheet(BuildContext context, int index) {
    final products = ref.read(productsProvider);
    final settings = ref.read(settingsProvider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ProductSearchSheet(
        products: products,
        currencySymbol: settings.currencySymbol,
        onSelected: (product) {
          setState(() {
            lineItems[index]['id'] = const Uuid().v4();
            lineItems[index]['productId'] = product.id;
            lineItems[index]['description'] = product.name;
            lineItems[index]['price'] = product.sellingPrice;
          });
        },
      ),
    );
  }

  Future<void> _saveEstimate() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (selectedClientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a client')));
      return;
    }
    
    final isEditing = widget.id != null;
    final estimate = Estimate(
      id: isEditing ? _existing!.id : const Uuid().v4(),
      clientId: selectedClientId!,
      estimateNumber: isEditing ? _existing!.estimateNumber : 'EST-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      issueDate: isEditing ? _existing!.issueDate : DateTime.now(),
      expiryDate: _expiryDate,
      subTotal: subtotal,
      taxTotal: taxTotal,
      totalAmount: total,
      status: isEditing ? _existing!.status : 'Draft',
      notes: _notesCtrl.text.isEmpty ? null : _notesCtrl.text,
      discountPercent: discountPercent,
      discountAmount: discountAmount,
      withholdingTaxPercent: withholdingTaxPercent,
      withholdingTaxAmount: withholdingTaxAmount,
      tax2Percent: tax2Percent,
      items: lineItems.map((item) {
        double qty = (item['quantity'] ?? 1).toDouble();
        double price = (item['price'] ?? 0.0).toDouble();
        double taxP = (item['tax'] ?? 0.0).toDouble();
        double discP = (item['discount'] ?? 0.0).toDouble();
        double taxable = (qty * price) * (1 - discP / 100);
        return EstimateItem(
          productId: item['productId'] as String?,
          description: item['description'] ?? '',
          quantity: qty.toInt(),
          rate: price,
          taxPercent: taxP,
          taxAmount: taxable * (taxP / 100),
          discountPercent: discP,
          total: taxable + (taxable * (taxP / 100)),
        );
      }).toList(),
    );

    LoadingOverlay.show(context, message: isEditing ? 'Updating...' : 'Saving...');
    try {
      if (isEditing) {
        await ref.read(estimatesProvider.notifier).updateEstimate(estimate);
      } else {
        await ref.read(estimatesProvider.notifier).addEstimate(estimate);
      }
      LoadingOverlay.hide();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditing ? 'Estimate updated' : 'Estimate saved'),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
      context.pop();
    } catch (e) {
      LoadingOverlay.hide();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save estimate: $e'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  Widget _buildLineItem(int index, ThemeData theme, String currencySymbol) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: ValueKey('desc_${lineItems[index]['id']}'),
                    initialValue: lineItems[index]['description'],
                    onChanged: (v) => lineItems[index]['description'] = v,
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    decoration: InputDecoration(
                      labelText: 'Item Description',
                      prefixIcon: const Icon(Icons.description),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.inventory_2, color: AppTheme.indigo),
                        tooltip: 'Browse Inventory',
                        onPressed: () => _showProductSearchBottomSheet(context, index),
                      ),
                    ),
                  ),
                ),
                if (lineItems.length > 1)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppTheme.rose),
                    onPressed: () => setState(() => lineItems.removeAt(index)),
                  )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    key: ValueKey('qty_${lineItems[index]['id']}'),
                    initialValue: lineItems[index]['quantity'].toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => setState(() => lineItems[index]['quantity'] = int.tryParse(v) ?? 1),
                    validator: (v) { final q = int.tryParse(v ?? ''); if (q == null || q <= 0) return 'Must be > 0'; return null; },
                    decoration: const InputDecoration(labelText: 'Qty', prefixIcon: Icon(Icons.numbers, size: 18)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    key: ValueKey('price_${lineItems[index]['id']}'),
                    initialValue: lineItems[index]['price'].toString(),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (v) => setState(() => lineItems[index]['price'] = double.tryParse(v) ?? 0.0),
                    validator: (v) { final p = double.tryParse(v ?? ''); if (p == null || p < 0) return 'Must be >= 0'; return null; },
                    decoration: InputDecoration(labelText: 'Price', prefixText: currencySymbol),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: ValueKey('tax_${lineItems[index]['id']}'),
                    initialValue: (lineItems[index]['tax'] ?? 0.0).toString(),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (v) => setState(() => lineItems[index]['tax'] = double.tryParse(v) ?? 0.0),
                    decoration: const InputDecoration(labelText: 'Tax %', suffixText: '%', prefixIcon: Icon(Icons.percent, size: 18)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    key: ValueKey('discount_${lineItems[index]['id']}'),
                    initialValue: (lineItems[index]['discount'] ?? 0.0).toString(),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (v) => setState(() => lineItems[index]['discount'] = double.tryParse(v) ?? 0.0),
                    decoration: const InputDecoration(labelText: 'Discount %', suffixText: '%', prefixIcon: Icon(Icons.local_offer, size: 18)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clientsProvider);
    final isEditing = widget.id != null;
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Estimate' : 'New Estimate'),
        actions: [
          if (isEditing && _existing != null && _existing!.status != 'Converted')
            TextButton.icon(
              icon: const Icon(Icons.transform, color: Colors.white),
              label: const Text('Convert to Invoice', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: _convertToInvoice,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true, 
                  value: selectedClientId,
                  items: clients.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name, style: const TextStyle(fontWeight: FontWeight.w500)))).toList(),
                  onChanged: (v) => setState(() => selectedClientId = v),
                  decoration: const InputDecoration(
                    labelText: 'Select Client',
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                  ),
                  validator: (v) => v == null ? 'Please select a client' : null,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: theme.dividerColor)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppTheme.indigo.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.event, color: AppTheme.indigo),
                  ),
                  title: const Text('Expiry Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text('${_expiryDate.day}/${_expiryDate.month}/${_expiryDate.year}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  trailing: TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(context: context, initialDate: _expiryDate, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                      if (picked != null) setState(() => _expiryDate = picked);
                    },
                    child: const Text('Change'),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Line Items', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              ...List.generate(lineItems.length, (index) => _buildLineItem(index, theme, settings.currencySymbol)),
              const SizedBox(height: 8),
              Center(
                child: TextButton.icon(
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Add Another Item', style: TextStyle(fontWeight: FontWeight.w600)),
                  onPressed: () {
                    final defaultTax = ref.read(settingsProvider).defaultTaxPercent;
                    setState(() {
                      lineItems.add(<String, dynamic>{'id': const Uuid().v4(), 'description': '', 'quantity': 1, 'price': 0.0, 'tax': defaultTax, 'discount': 0.0});
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                shadowColor: Colors.black.withValues(alpha: 0.05),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Adjustments & Taxes', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: discountPercent.toString(),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged: (v) => setState(() => discountPercent = double.tryParse(v) ?? 0.0),
                              decoration: const InputDecoration(
                                labelText: 'Est Discount %',
                                suffixText: '%',
                                prefixIcon: Icon(Icons.local_offer_outlined),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              initialValue: discountAmount.toString(),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged: (v) => setState(() => discountAmount = double.tryParse(v) ?? 0.0),
                              decoration: InputDecoration(
                                labelText: 'Est Discount Flat',
                                prefixText: settings.currencySymbol,
                                prefixIcon: const Icon(Icons.money_off),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: withholdingTaxPercent.toString(),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged: (v) => setState(() => withholdingTaxPercent = double.tryParse(v) ?? 0.0),
                              decoration: const InputDecoration(
                                labelText: 'Withholding Tax % (TDS)',
                                suffixText: '%',
                                prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              initialValue: tax2Percent.toString(),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged: (v) => setState(() => tax2Percent = double.tryParse(v) ?? 0.0),
                              decoration: const InputDecoration(
                                labelText: 'Secondary Tax %',
                                suffixText: '%',
                                prefixIcon: Icon(Icons.add_business_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _notesCtrl, 
                maxLines: 3, 
                decoration: const InputDecoration(labelText: 'Estimate Notes (Terms, etc.)', alignLabelWithHint: true),
              ),
              const SizedBox(height: 280), // padding for bottom sheet
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                  Text(settings.formatCurrency(subtotal), style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tax', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                  Text(settings.formatCurrency(taxTotal), style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              if (totalInvoiceDiscount > 0) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                    Text('-${settings.formatCurrency(totalInvoiceDiscount)}', style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.rose)),
                  ],
                ),
              ],
              if (withholdingTaxAmount > 0) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Withholding Tax', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                    Text('-${settings.formatCurrency(withholdingTaxAmount)}', style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.rose)),
                  ],
                ),
              ],
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(settings.formatCurrency(total), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.indigo)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveEstimate,
                  child: Text(isEditing ? 'Update Estimate' : 'Save Estimate', style: const TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

