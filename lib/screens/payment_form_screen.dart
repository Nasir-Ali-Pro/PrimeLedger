import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/payment.dart';
import '../providers/payment_provider.dart';
import '../providers/invoice_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/loading_overlay.dart';

class PaymentFormScreen extends ConsumerStatefulWidget {
  final String invoiceId;
  const PaymentFormScreen({super.key, required this.invoiceId});

  @override
  ConsumerState<PaymentFormScreen> createState() => _PaymentFormScreenState();
}

class _PaymentFormScreenState extends ConsumerState<PaymentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _refCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _method = Payment.methods.first;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final invoices = ref.read(invoicesProvider);
      try {
        final inv = invoices.firstWhere((i) => i.id == widget.invoiceId);
        final payments = ref.read(paymentsProvider).where((p) => p.invoiceId == widget.invoiceId);
        final paidSoFar = payments.fold(0.0, (sum, p) => sum + p.amount);
        final remaining = inv.totalAmount - paidSoFar;
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
      appBar: AppBar(title: const Text('Record Payment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount Received', prefixText: settings.currencySymbol, prefixIcon: const Icon(Icons.money)),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final amount = double.tryParse(v);
                  if (amount == null) return 'Invalid amount';
                  if (amount <= 0) return 'Must be positive';
                  final invoices = ref.read(invoicesProvider);
                  final payments = ref.read(paymentsProvider);
                  final expenses = ref.read(expensesProvider);
                  try {
                    final inv = invoices.firstWhere((i) => i.id == widget.invoiceId);
                    final thisInvoicePayments = payments.where((p) => p.invoiceId == widget.invoiceId);
                    final paidSoFar = thisInvoicePayments.fold(0.0, (sum, p) => sum + p.amount);
                    final remaining = (inv.totalAmount - paidSoFar).clamp(0.0, double.infinity);

                    final clientInvoices = invoices.where((i) => i.clientId == inv.clientId && i.status != 'Draft' && i.status != 'Cancelled').toList();
                    final hasTargetInvoice = clientInvoices.any((i) => i.id == inv.id);
                    double totalBilled = clientInvoices.fold(0.0, (s, i) => s + i.totalAmount);
                    if (!hasTargetInvoice) {
                      totalBilled += inv.totalAmount;
                    }
                    final totalPaid = payments.where((p) => p.clientId == inv.clientId).fold(0.0, (s, p) => s + p.amount);
                    final billableExpenses = expenses.where((e) {
                      if (e.clientId != inv.clientId || !e.isBillable) return false;
                      if (e.invoiceId == null) return true;
                      final linkedInv = invoices.where((i) => i.id == e.invoiceId).firstOrNull;
                      return linkedInv == null || linkedInv.status == 'Draft' || linkedInv.status == 'Cancelled';
                    }).fold(0.0, (s, e) => s + e.amount * (1 + e.markupPercent / 100));
                    final totalClientDues = totalBilled + billableExpenses - totalPaid;

                    final previousDues = (totalClientDues - remaining).clamp(0.0, double.infinity);
                    final allowedMax = remaining + previousDues;

                    if (amount > allowedMax + 0.01) {
                      return 'Exceeds total outstanding dues of ${settings.formatCurrency(allowedMax)}';
                    }
                  } catch (e) {
                    return 'Error validating';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(isExpanded: true,
                value: _method,
                items: Payment.methods.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                onChanged: (v) => setState(() => _method = v!),
                decoration: const InputDecoration(labelText: 'Payment Method', prefixIcon: Icon(Icons.payment)),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today, color: Color(0xFF6366F1)),
                title: Text('Date: ${_date.day}/${_date.month}/${_date.year}'),
                trailing: TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2020), lastDate: DateTime.now());
                    if (picked != null) setState(() => _date = picked);
                  },
                  child: const Text('Change'),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _refCtrl,
                decoration: const InputDecoration(labelText: 'Reference Number (e.g. Cheque/TID)', prefixIcon: Icon(Icons.numbers)),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesCtrl,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Internal Notes', prefixIcon: Icon(Icons.notes)),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final amount = double.tryParse(_amountCtrl.text) ?? 0;
                      final invoices = ref.read(invoicesProvider);
                      final inv = invoices.where((i) => i.id == widget.invoiceId).firstOrNull;
                      if (inv == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invoice not found')));
                        return;
                      }

                      final payment = Payment(
                        id: const Uuid().v4(),
                        invoiceId: inv.id,
                        clientId: inv.clientId,
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
                        await ref.read(paymentsProvider.notifier).addPayment(payment);
                        LoadingOverlay.hide();
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('Payment recorded successfully!'),
                            backgroundColor: Color(0xFF10B981),
                          ),
                        );
                        router.pop();
                      } catch (e) {
                        LoadingOverlay.hide();
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('Failed to record payment: $e'),
                            backgroundColor: const Color(0xFFEF4444),
                          ),
                        );
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
