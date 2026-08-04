import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/supplier_payment.dart';
import '../providers/supplier_payment_provider.dart';
import '../providers/purchase_order_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/loading_overlay.dart';
import '../utils/error_handler.dart';

class SupplierPaymentFormScreen extends ConsumerStatefulWidget {
  final String purchaseOrderId;
  const SupplierPaymentFormScreen({super.key, required this.purchaseOrderId});

  @override
  ConsumerState<SupplierPaymentFormScreen> createState() => _SupplierPaymentFormScreenState();
}

class _SupplierPaymentFormScreenState extends ConsumerState<SupplierPaymentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _refCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _method = SupplierPayment.methods.first;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pos = ref.read(purchaseOrdersProvider);
      try {
        final po = pos.firstWhere((p) => p.id == widget.purchaseOrderId);
        final payments = ref.read(supplierPaymentsProvider).where((p) => p.purchaseOrderId == widget.purchaseOrderId);
        final paidSoFar = payments.fold(0.0, (sum, p) => sum + p.amount);
        final remaining = po.totalAmount - paidSoFar;
        _amountCtrl.text = remaining.toStringAsFixed(2);
        setState(() {});
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _refCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Record Supplier Payment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _amountCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Amount Paid',
                  prefixText: settings.currencySymbol,
                  prefixIcon: const Icon(Icons.money),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final amount = double.tryParse(v);
                  if (amount == null) return 'Invalid amount';
                  if (amount <= 0) return 'Must be positive';
                  final pos = ref.read(purchaseOrdersProvider);
                  try {
                    final po = pos.firstWhere((p) => p.id == widget.purchaseOrderId);
                    final payments = ref.read(supplierPaymentsProvider).where((p) => p.purchaseOrderId == widget.purchaseOrderId);
                    final paidSoFar = payments.fold(0.0, (sum, p) => sum + p.amount);
                    final remaining = po.totalAmount - paidSoFar;
                    if (amount > remaining + 0.01) {
                      return 'Exceeds remaining balance of ${settings.formatCurrency(remaining)}';
                    }
                  } catch (e) {
                    return 'Error validating';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: _method,
                items: SupplierPayment.methods.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                onChanged: (v) => setState(() => _method = v!),
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  prefixIcon: Icon(Icons.payment),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today, color: Color(0xFF6366F1)),
                title: Text('Date: ${_date.day}/${_date.month}/${_date.year}'),
                trailing: TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) setState(() => _date = picked);
                  },
                  child: const Text('Change'),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _refCtrl,
                decoration: const InputDecoration(
                  labelText: 'Reference Number (e.g. Cheque/TID)',
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Internal Notes',
                  prefixIcon: Icon(Icons.notes),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final amount = double.tryParse(_amountCtrl.text) ?? 0;
                      final pos = ref.read(purchaseOrdersProvider);
                      final po = pos.where((p) => p.id == widget.purchaseOrderId).firstOrNull;
                      if (po == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Purchase Order not found')));
                        return;
                      }

                      final payment = SupplierPayment(
                        id: const Uuid().v4(),
                        purchaseOrderId: po.id,
                        supplierId: po.supplierId,
                        amount: amount,
                        date: _date,
                        paymentMethod: _method,
                        referenceNumber: _refCtrl.text.isEmpty ? null : _refCtrl.text,
                        notes: _notesCtrl.text.isEmpty ? null : _notesCtrl.text,
                        createdAt: DateTime.now(),
                      );

                      final router = GoRouter.of(context);
                      final scaffoldMessenger = ScaffoldMessenger.of(context);

                      LoadingOverlay.show(context, message: 'Saving...');
                      try {
                        await ref.read(supplierPaymentsProvider.notifier).addPayment(payment);
                        LoadingOverlay.hide();
                        AppErrorHandler.showSuccessSnackBar(context, 'Supplier payment recorded successfully!');
                        router.pop();
                      } catch (e) {
                        LoadingOverlay.hide();
                        if (mounted) {
                          AppErrorHandler.showErrorSnackBar(context, e, prefix: 'Failed to record supplier payment');
                        }
                      }
                    }
                  },
                  child: const Text('Save Payment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
