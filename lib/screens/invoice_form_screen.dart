import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/invoice.dart';
import '../models/expense.dart';
import '../providers/client_provider.dart';
import '../providers/invoice_provider.dart';
import '../providers/expense_provider.dart';
import '../providers/payment_provider.dart';
import '../providers/product_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/loading_overlay.dart';
import '../utils/error_handler.dart';
import '../theme.dart';
import '../widgets/product_search_sheet.dart';

class InvoiceFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const InvoiceFormScreen({super.key, this.id});

  @override
  ConsumerState<InvoiceFormScreen> createState() => InvoiceFormScreenState();
}

class InvoiceFormScreenState extends ConsumerState<InvoiceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedClientId;
  Invoice? _existingInvoice;
  
  List<Map<String, dynamic>> lineItems = [
    <String, dynamic>{'id': const Uuid().v4(), 'productId': null, 'description': '', 'quantity': 1, 'price': 0.0, 'tax': 0.0, 'discount': 0.0}
  ];

  double discountPercent = 0.0;
  double discountAmount = 0.0;
  double withholdingTaxPercent = 0.0;
  double tax2Percent = 0.0;
  late DateTime _issueDate;
  late DateTime _dueDate;
  final _invoiceNumberCtrl = TextEditingController();
  final _partialPaymentCtrl = TextEditingController(text: '0.0');
  String _status = 'Draft';
  List<String> _importedExpenseIds = [];
  
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
    _issueDate = DateTime.now();
    _dueDate = DateTime.now().add(const Duration(days: 14));
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final invoices = ref.read(invoicesProvider);
        try {
          _existingInvoice = invoices.firstWhere((i) => i.id == widget.id);
          selectedClientId = _existingInvoice!.clientId;
          discountPercent = _existingInvoice!.discountPercent;
          discountAmount = _existingInvoice!.discountAmount;
          withholdingTaxPercent = 0.0;
          tax2Percent = 0.0;
          _issueDate = _existingInvoice!.issueDate;
          _dueDate = _existingInvoice!.dueDate;
          _invoiceNumberCtrl.text = _existingInvoice!.invoiceNumber;
          _status = _existingInvoice!.status;

          final linkedExpenses = ref.read(expensesProvider).where((e) => e.invoiceId == widget.id).toList();
          _importedExpenseIds = linkedExpenses.map((e) => e.id).toList();

          lineItems = _existingInvoice!.items.map((i) {
            final matchedExpense = linkedExpenses.where((e) {
              final markedUpPrice = e.amount * (1 + e.markupPercent / 100);
              return e.description == i.description && (markedUpPrice - i.rate).abs() < 0.05;
            }).firstOrNull;
            return <String, dynamic>{
              'id': i.id.isNotEmpty ? i.id : const Uuid().v4(),
              'productId': i.productId,
              'description': i.description,
              'quantity': i.quantity,
              'price': i.rate,
              'tax': i.taxPercent,
              'discount': 0.0,
              'expenseId': matchedExpense?.id,
            };
          }).toList();

          if (_status == 'Partially Paid') {
            final thisPayments = ref.read(paymentsProvider).where((p) => p.invoiceId == widget.id).toList();
            final totalPaid = thisPayments.fold(0.0, (sum, p) => sum + p.amount);
            _partialPaymentCtrl.text = totalPaid.toString();
          }

          setState(() {});
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    } else {
      _status = 'Draft';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final invoices = ref.read(invoicesProvider);
        final settings = ref.read(settingsProvider);
        int maxNumber = 0;
        final prefix = settings.invoicePrefix;
        final regex = RegExp('$prefix-(\\d+)');
        for (final inv in invoices) {
          final match = regex.firstMatch(inv.invoiceNumber);
          if (match != null) {
            final num = int.tryParse(match.group(1) ?? '');
            if (num != null && num > maxNumber) {
              maxNumber = num;
            }
          }
        }
        _invoiceNumberCtrl.text = '$prefix-${(maxNumber + 1).toString().padLeft(4, '0')}';
        _dueDate = DateTime.now().add(Duration(days: settings.defaultPaymentTermsDays));
        lineItems = [
          <String, dynamic>{'id': const Uuid().v4(), 'productId': null, 'description': '', 'quantity': 1, 'price': 0.0, 'tax': settings.defaultTaxPercent, 'discount': 0.0}
        ];
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _invoiceNumberCtrl.dispose();
    _partialPaymentCtrl.dispose();
    super.dispose();
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

  void _importExpense(Expense exp) {
    if (_importedExpenseIds.contains(exp.id)) return;
    final markedUpPrice = exp.amount * (1 + exp.markupPercent / 100);
    setState(() {
      _importedExpenseIds.add(exp.id);
      
      // If there is only one empty default line item, remove it
      if (lineItems.length == 1 &&
          lineItems[0]['description'] == '' &&
          lineItems[0]['price'] == 0.0 &&
          lineItems[0]['productId'] == null) {
        lineItems.removeAt(0);
      }
      
      final defaultTax = ref.read(settingsProvider).defaultTaxPercent;
      lineItems.add(<String, dynamic>{
        'id': const Uuid().v4(),
        'productId': null,
        'description': exp.description,
        'quantity': 1,
        'price': double.parse(markedUpPrice.toStringAsFixed(2)),
        'tax': defaultTax,
        'discount': 0.0,
        'expenseId': exp.id,
      });
    });
  }

  Future<void> _saveInvoice() async {
    if (!_formKey.currentState!.validate()) return;
    if (lineItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please add at least one line item')));
      return;
    }
    if (total < 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Total amount cannot be negative. Please adjust discounts.')));
      return;
    }
    
    if (selectedClientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a client')));
      return;
    }
    
    final isEditing = widget.id != null;
    final invoice = Invoice(
      id: isEditing ? _existingInvoice!.id : const Uuid().v4(),
      clientId: selectedClientId!,
      invoiceNumber: _invoiceNumberCtrl.text.trim(),
      issueDate: _issueDate,
      dueDate: _dueDate,
      subTotal: subtotal,
      taxTotal: taxTotal,
      totalAmount: total,
      status: _status,
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
        return InvoiceItem(
          id: item['id'] as String? ?? '',
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

    final products = ref.read(productsProvider);
    for (final item in lineItems) {
      final productId = item['productId'] as String?;
      if (productId != null) {
        final product = products.where((p) => p.id == productId).firstOrNull;
        if (product != null) {
          int originalQty = 0;
          if (widget.id != null && _existingInvoice != null) {
            final oldItem = _existingInvoice!.items.where((i) => i.productId == productId).firstOrNull;
            if (oldItem != null) {
              originalQty = oldItem.quantity;
            }
          }
          final limit = product.quantity + originalQty;
          final qty = (item['quantity'] as num?)?.toInt() ?? 1;
          if (qty > limit) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Insufficient stock for "${product.name}". Only $limit units are available in inventory, but $qty were requested.',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppTheme.rose,
              ),
            );
            return;
          }
        }
      }
    }

    final partialAmt = _status == 'Partially Paid' ? (double.tryParse(_partialPaymentCtrl.text) ?? 0.0) : null;
    LoadingOverlay.show(context, message: isEditing ? 'Updating...' : 'Saving...');
    try {
      if (isEditing) {
        await ref.read(invoicesProvider.notifier).updateInvoice(
          invoice,
          linkedExpenseIds: _importedExpenseIds,
          paymentAmount: partialAmt,
        );
      } else {
        await ref.read(invoicesProvider.notifier).addInvoice(
          invoice,
          linkedExpenseIds: _importedExpenseIds,
          paymentAmount: partialAmt,
        );
      }
      LoadingOverlay.hide();
      if (!mounted) return;
      AppErrorHandler.showSuccessSnackBar(context, isEditing ? 'Invoice updated successfully' : 'Invoice created successfully');
      context.pop();
    } catch (e) {
      LoadingOverlay.hide();
      if (!mounted) return;
      AppErrorHandler.showErrorSnackBar(context, e, prefix: 'Failed to save invoice');
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
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppTheme.rose),
                  onPressed: () {
                    final item = lineItems[index];
                    if (item['expenseId'] != null) {
                      _importedExpenseIds.remove(item['expenseId']);
                    }
                    setState(() {
                      lineItems.removeAt(index);
                      if (lineItems.isEmpty) {
                        final defaultTax = ref.read(settingsProvider).defaultTaxPercent;
                        lineItems.add(<String, dynamic>{
                          'id': const Uuid().v4(),
                          'productId': null,
                          'description': '',
                          'quantity': 1,
                          'price': 0.0,
                          'tax': defaultTax,
                          'discount': 0.0,
                        });
                      }
                    });
                  },
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
                    validator: (v) {
                      final q = int.tryParse(v ?? '');
                      if (q == null || q <= 0) return 'Must be > 0';
                      final productId = lineItems[index]['productId'];
                      if (productId != null) {
                        final product = ref.read(productsProvider).where((p) => p.id == productId).firstOrNull;
                        if (product != null) {
                          int originalQty = 0;
                          if (widget.id != null && _existingInvoice != null) {
                            final oldItem = _existingInvoice!.items.where((i) => i.productId == productId).firstOrNull;
                            if (oldItem != null) {
                              originalQty = oldItem.quantity;
                            }
                          }
                          final limit = product.quantity + originalQty;
                          if (q > limit) {
                            return 'Only $limit available';
                          }
                        }
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Qty', prefixIcon: Icon(Icons.format_list_numbered_outlined, size: 18)),
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
                    decoration: const InputDecoration(labelText: 'Tax Rate', suffixText: '%', prefixIcon: Icon(Icons.receipt_long_outlined, size: 18)),
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
      appBar: AppBar(title: Text(isEditing ? 'Edit Invoice' : 'Create Invoice')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
              if (selectedClientId != null) ...[
                Consumer(
                  builder: (context, ref, child) {
                    final expenses = ref.watch(expensesProvider);
                    final settings = ref.watch(settingsProvider);
                    final clientExpenses = expenses.where((e) {
                      if (e.clientId != selectedClientId || !e.isBillable) return false;
                      return e.invoiceId == null || (widget.id != null && e.invoiceId == widget.id);
                    }).toList();

                    final unimportedExpenses = clientExpenses.where((e) => !_importedExpenseIds.contains(e.id)).toList();

                    if (unimportedExpenses.isEmpty) return const SizedBox.shrink();

                    return Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Card(
                        elevation: 0,
                        color: theme.colorScheme.primary.withValues(alpha: 0.05),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.15)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.receipt_long, color: theme.colorScheme.primary),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Unbilled Expenses (${unimportedExpenses.length})',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  TextButton.icon(
                                    icon: const Icon(Icons.download, size: 16),
                                    label: const Text('Import All', style: TextStyle(fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      for (final exp in unimportedExpenses) {
                                        _importExpense(exp);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const Divider(height: 16),
                              ...unimportedExpenses.map((exp) {
                                final markedUpPrice = exp.amount * (1 + exp.markupPercent / 100);
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(exp.description, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  subtitle: Text(
                                    'Base: ${settings.formatCurrency(exp.amount)} | Markup: ${exp.markupPercent.toStringAsFixed(0)}%',
                                    style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 12),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        settings.formatCurrency(markedUpPrice),
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle, color: AppTheme.indigo),
                                        onPressed: () => _importExpense(exp),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  final invoiceNumberField = Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: TextFormField(
                      controller: _invoiceNumberCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Invoice Number',
                        prefixIcon: Icon(Icons.tag),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                      ),
                      validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                  );

                  final statusField = Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _status,
                      isExpanded: true,
                      items: ['Unpaid', 'Partially Paid', 'Paid', 'Overdue', 'Draft', 'Cancelled'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setState(() => _status = v!),
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        prefixIcon: Icon(Icons.info_outline),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                      ),
                    ),
                  );

                  if (isMobile) {
                    return Column(
                      children: [
                        invoiceNumberField,
                        const SizedBox(height: 16),
                        statusField,
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: invoiceNumberField,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: statusField,
                      ),
                    ],
                  );
                },
              ),
              if (_status == 'Partially Paid') ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: TextFormField(
                    controller: _partialPaymentCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Amount Paid',
                      prefixText: settings.currencySymbol,
                      prefixIcon: const Icon(Icons.payment),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                    ),
                    validator: (v) {
                      if (_status == 'Partially Paid') {
                        if (v == null || v.trim().isEmpty) return 'Required';
                        final amt = double.tryParse(v);
                        if (amt == null || amt <= 0) return 'Must be a positive amount';
                        if (amt >= total) return 'Must be less than total amount';
                      }
                      return null;
                    },
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.calendar_today, color: theme.colorScheme.primary),
                      title: Text('Issue: ${_issueDate.day}/${_issueDate.month}/${_issueDate.year}'),
                      onTap: () async {
                        final picked = await showDatePicker(context: context, initialDate: _issueDate, firstDate: DateTime(2020), lastDate: DateTime(2030));
                        if (picked != null) setState(() => _issueDate = picked);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.event, color: theme.colorScheme.tertiary),
                      title: Text('Due: ${_dueDate.day}/${_dueDate.month}/${_dueDate.year}'),
                      onTap: () async {
                        final picked = await showDatePicker(context: context, initialDate: _dueDate, firstDate: DateTime(2020), lastDate: DateTime(2030));
                        if (picked != null) setState(() => _dueDate = picked);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
                                labelText: 'Inv Discount',
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
                                labelText: 'Inv Discount Flat',
                                prefixText: settings.currencySymbol,
                                prefixIcon: const Icon(Icons.money_off),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Withholding & Secondary Tax inputs removed per user request
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 200), // padding for bottom sheet
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
                  onPressed: _saveInvoice,
                  child: Text(isEditing ? 'Update Invoice' : 'Generate Invoice', style: const TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

