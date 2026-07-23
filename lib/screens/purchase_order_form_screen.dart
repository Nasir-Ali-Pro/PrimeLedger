import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/purchase_order.dart';
import '../providers/purchase_order_provider.dart';
import '../providers/supplier_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/loading_overlay.dart';
import '../theme.dart';
import '../models/settings.dart';
import '../providers/settings_provider.dart';
import '../widgets/product_search_sheet.dart';
import '../providers/supplier_payment_provider.dart';

class PurchaseOrderFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const PurchaseOrderFormScreen({super.key, this.id});

  @override
  ConsumerState<PurchaseOrderFormScreen> createState() => _PurchaseOrderFormScreenState();
}

class _PurchaseOrderFormScreenState extends ConsumerState<PurchaseOrderFormScreen> {
  String? selectedSupplierId;
  PurchaseOrder? _existing;
  final _notesCtrl = TextEditingController();
  DateTime _expectedDate = DateTime.now().add(const Duration(days: 7));

  List<Map<String, dynamic>> lineItems = [
    <String, dynamic>{'id': const Uuid().v4(), 'productId': null, 'description': '', 'quantity': 1, 'price': 0.0, 'tax': 0.0}
  ];

  double get subtotal => lineItems.fold(0, (sum, item) => sum + ((item['quantity'] ?? 1) * (item['price'] ?? 0.0)));
  
  double get taxTotal => lineItems.fold(0, (sum, item) {
    double qty = (item['quantity'] ?? 1).toDouble();
    double price = (item['price'] ?? 0.0).toDouble();
    double taxPercent = (item['tax'] ?? 0.0).toDouble();
    return sum + ((qty * price) * (taxPercent / 100));
  });
  
  double get total => subtotal + taxTotal;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);
    lineItems = [
      <String, dynamic>{'id': const Uuid().v4(), 'productId': null, 'description': '', 'quantity': 1, 'price': 0.0, 'tax': settings.defaultTaxPercent}
    ];
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final pos = ref.read(purchaseOrdersProvider);
        try {
          _existing = pos.firstWhere((e) => e.id == widget.id);
          selectedSupplierId = _existing!.supplierId;
          _notesCtrl.text = _existing!.notes ?? '';
          _expectedDate = _existing!.expectedDate;
          lineItems = _existing!.items.map((i) {
            double rate = i.unitPrice;
            double taxPercent = i.taxPercent;
            return <String, dynamic>{
              'id': const Uuid().v4(),
              'productId': i.productId,
              'description': i.description,
              'quantity': i.quantity,
              'price': rate,
              'tax': taxPercent,
              'receivedQuantity': i.receivedQuantity,
            };
          }).toList();
          setState(() {});
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    }
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  void _showProductSearchBottomSheet(BuildContext context, int index) {
    final products = ref.read(productsProvider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ProductSearchSheet(
        products: products,
        currencySymbol: ref.read(settingsProvider).currencySymbol,
        onSelected: (product) {
          setState(() {
            lineItems[index]['id'] = const Uuid().v4();
            lineItems[index]['productId'] = product.id;
            lineItems[index]['description'] = product.name;
            lineItems[index]['price'] = product.costPrice; // Using cost price for PO
          });
        },
      ),
    );
  }

  Future<void> _savePurchaseOrder() async {
    if (selectedSupplierId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a supplier')));
      return;
    }
    
    final isEditing = widget.id != null;
    final po = PurchaseOrder(
      id: isEditing ? _existing!.id : const Uuid().v4(),
      supplierId: selectedSupplierId!,
      poNumber: isEditing ? _existing!.poNumber : 'PO-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      issueDate: isEditing ? _existing!.issueDate : DateTime.now(),
      expectedDate: _expectedDate,
      subTotal: subtotal,
      taxTotal: taxTotal,
      totalAmount: total,
      status: isEditing ? _existing!.status : 'Draft',
      notes: _notesCtrl.text.isEmpty ? null : _notesCtrl.text,
      items: lineItems.map((item) {
        double qty = (item['quantity'] ?? 1).toDouble();
        double price = (item['price'] ?? 0.0).toDouble();
        double taxP = (item['tax'] ?? 0.0).toDouble();
        return PurchaseOrderItem(
          productId: item['productId'] as String?,
          description: item['description'] ?? '',
          quantity: qty.toInt(),
          receivedQuantity: (item['receivedQuantity'] ?? (isEditing && _existing!.status == 'Received' ? qty.toInt() : 0)) as int,
          unitPrice: price,
          taxPercent: taxP,
          taxAmount: (qty * price) * (taxP / 100),
          total: (qty * price) + ((qty * price) * (taxP / 100)),
        );
      }).toList(),
      createdAt: isEditing ? _existing!.createdAt : DateTime.now(),
    );

    LoadingOverlay.show(context, message: isEditing ? 'Updating...' : 'Saving...');
    try {
      if (isEditing) {
        await ref.read(purchaseOrdersProvider.notifier).updatePurchaseOrder(po);
      } else {
        await ref.read(purchaseOrdersProvider.notifier).addPurchaseOrder(po);
      }
      LoadingOverlay.hide();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditing ? 'Purchase order updated' : 'Purchase order saved'),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
      context.pop();
    } catch (e) {
      LoadingOverlay.hide();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save purchase order: $e'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  Widget _buildLineItem(int index, ThemeData theme, AppSettings settings) {
    final hasMultiple = lineItems.length > 1;
    final item = lineItems[index];

    final double qty = (item['quantity'] ?? 1).toDouble();
    final double price = (item['price'] ?? 0.0).toDouble();
    final double taxPercent = (item['tax'] ?? 0.0).toDouble();
    final double subtotal = qty * price;
    final double taxAmount = subtotal * (taxPercent / 100);
    final double total = subtotal + taxAmount;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header of the Line Item Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.04),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(color: theme.dividerColor.withValues(alpha: 0.4)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Item #${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                if (hasMultiple)
                  GestureDetector(
                    onTap: () => setState(() => lineItems.removeAt(index)),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description field
                TextFormField(
                  key: ValueKey('desc_${item['id']}'),
                  initialValue: item['description'],
                  onChanged: (v) => item['description'] = v,
                  validator: (v) => v == null || v.isEmpty ? 'Description required' : null,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    labelText: 'Item Description',
                    hintText: 'Enter item name or description',
                    prefixIcon: const Icon(Icons.description_outlined, size: 20),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.inventory_2_outlined, color: AppTheme.indigo, size: 20),
                      tooltip: 'Browse Inventory',
                      onPressed: () => _showProductSearchBottomSheet(context, index),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Qty, Cost, Tax Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Qty Field (no icon to save horizontal space)
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        key: ValueKey('qty_${item['id']}'),
                        initialValue: item['quantity'].toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (v) => setState(() => item['quantity'] = int.tryParse(v) ?? 1),
                        validator: (v) {
                          final q = int.tryParse(v ?? '');
                          if (q == null || q <= 0) return 'Invalid';
                          return null;
                        },
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'Qty',
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Cost Field
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        key: ValueKey('price_${item['id']}'),
                        initialValue: item['price'].toString(),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (v) => setState(() => item['price'] = double.tryParse(v) ?? 0.0),
                        validator: (v) {
                          final p = double.tryParse(v ?? '');
                          if (p == null || p < 0) return 'Invalid';
                          return null;
                        },
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          labelText: 'Cost',
                          prefixText: '${settings.currencySymbol} ',
                          prefixStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Tax Field
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        key: ValueKey('tax_${item['id']}'),
                        initialValue: item['tax'].toString(),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (v) => setState(() => item['tax'] = double.tryParse(v) ?? 0.0),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'Tax',
                          suffixText: '%',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item['quantity'] ?? 1} × ${settings.formatCurrency(price)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        if (taxAmount > 0) ...[
                          Text(
                            '+ ${settings.formatCurrency(taxAmount)} tax  ',
                            style: TextStyle(
                              fontSize: 11,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                        Text(
                          'Total: ',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          settings.formatCurrency(total),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final suppliers = ref.watch(suppliersProvider);
    final isEditing = widget.id != null;
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Purchase Order' : 'New Purchase Order')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
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
                value: selectedSupplierId,
                items: suppliers.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name, style: const TextStyle(fontWeight: FontWeight.w500)))).toList(),
                onChanged: (v) => setState(() => selectedSupplierId = v),
                decoration: const InputDecoration(
                  labelText: 'Select Supplier',
                  prefixIcon: Icon(Icons.local_shipping),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                ),
                validator: (v) => v == null ? 'Please select a supplier' : null,
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
                title: const Text('Expected Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
                subtitle: Text('${_expectedDate.day}/${_expectedDate.month}/${_expectedDate.year}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                trailing: TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(context: context, initialDate: _expectedDate, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                    if (picked != null) setState(() => _expectedDate = picked);
                  },
                  child: const Text('Change'),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text('Line Items', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            ...List.generate(lineItems.length, (index) => _buildLineItem(index, theme, settings)),
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Add Another Item', style: TextStyle(fontWeight: FontWeight.w600)),
                onPressed: () {
                  final defaultTax = ref.read(settingsProvider).defaultTaxPercent;
                  setState(() {
                    lineItems.add(<String, dynamic>{'id': const Uuid().v4(), 'productId': null, 'description': '', 'quantity': 1, 'price': 0.0, 'tax': defaultTax});
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _notesCtrl, 
              maxLines: 3, 
              decoration: const InputDecoration(labelText: 'Purchase Order Notes', alignLabelWithHint: true),
            ),
            if (isEditing) ...[
              const SizedBox(height: 32),
              Text('Supplier Payments', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Consumer(
                builder: (context, ref, child) {
                  final existing = _existing;
                  if (existing == null) return const SizedBox.shrink();
                  final allPayments = ref.watch(supplierPaymentsProvider);
                  final poPayments = allPayments.where((p) => p.purchaseOrderId == existing.id).toList();
                  if (poPayments.isEmpty) {
                    return Text('No payments recorded for this purchase order.', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5)));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: poPayments.length,
                    itemBuilder: (context, i) {
                      final p = poPayments[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text('Paid: ${settings.formatCurrency(p.amount)} via ${p.paymentMethod}'),
                          subtitle: Text('Date: ${p.date.day}/${p.date.month}/${p.date.year}${p.referenceNumber != null ? " • Ref: ${p.referenceNumber}" : ""}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Delete Payment'),
                                  content: const Text('Are you sure you want to delete this payment record?'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                                    TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                                  ],
                                ),
                              );
                              if (confirmed == true) {
                                await ref.read(supplierPaymentsProvider.notifier).deletePayment(p.id);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
            const SizedBox(height: 240), // padding for bottom sheet
          ],
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
                  onPressed: _savePurchaseOrder,
                  child: Text(isEditing ? 'Update PO' : 'Save PO', style: const TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

