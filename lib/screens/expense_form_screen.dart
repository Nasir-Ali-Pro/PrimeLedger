import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../providers/client_provider.dart';
import '../widgets/loading_overlay.dart';
import '../theme.dart';
import '../providers/settings_provider.dart';


class ExpenseFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const ExpenseFormScreen({super.key, this.id});

  @override
  ConsumerState<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends ConsumerState<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  final _markupController = TextEditingController(text: '0.0');
  String _category = Expense.categories.first;
  DateTime _date = DateTime.now();
  bool _isBillable = false;
  String? _clientId;
  String? _receiptPath;
  Expense? _existing;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final expenses = ref.read(expensesProvider);
        try {
          _existing = expenses.firstWhere((e) => e.id == widget.id);
          _descController.text = _existing!.description;
          _amountController.text = _existing!.amount.toString();
          _notesController.text = _existing!.notes ?? '';
          _category = _existing!.category;
          _date = _existing!.date;
          _isBillable = _existing!.isBillable;
          _clientId = _existing!.clientId;
          _markupController.text = _existing!.markupPercent.toString();
          _receiptPath = _existing!.receiptPath;
          setState(() {});
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    }
  }

  @override
  void dispose() {
    _descController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    _markupController.dispose();
    super.dispose();
  }

  Future<void> _saveExpense() async {
    if (_formKey.currentState!.validate()) {
      final isEditing = widget.id != null;
      final expense = Expense(
        id: isEditing ? _existing!.id : const Uuid().v4(),
        description: _descController.text,
        amount: double.tryParse(_amountController.text) ?? 0,
        category: _category,
        date: _date,
        clientId: _isBillable ? _clientId : null,
        isBillable: _isBillable,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        createdAt: isEditing ? _existing!.createdAt : DateTime.now(),
        markupPercent: _isBillable ? (double.tryParse(_markupController.text) ?? 0.0) : 0.0,
        invoiceId: isEditing ? _existing!.invoiceId : null,
        receiptPath: _receiptPath,
      );
      LoadingOverlay.show(context, message: isEditing ? 'Updating...' : 'Saving...');
      try {
        if (isEditing) {
          await ref.read(expensesProvider.notifier).updateExpense(expense);
        } else {
          await ref.read(expensesProvider.notifier).addExpense(expense);
        }
        LoadingOverlay.hide();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing ? 'Expense updated' : 'Expense saved'),
            backgroundColor: const Color(0xFF10B981),
          ),
        );
        context.pop();
      } catch (e) {
        LoadingOverlay.hide();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save expense: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clientsProvider);
    final isEditing = widget.id != null;
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);


    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Expense' : 'Add Expense')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                shadowColor: Colors.black.withValues(alpha: 0.05),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _descController,
                        decoration: const InputDecoration(labelText: 'Expense Description', prefixIcon: Icon(Icons.description, color: AppTheme.indigo)),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(labelText: 'Total Amount', prefixText: '${settings.currencySymbol} ', prefixIcon: const Icon(Icons.attach_money, color: AppTheme.indigo)),
                        validator: (v) {
                          if (v!.isEmpty) return 'Required';
                          final amt = double.tryParse(v);
                          if (amt == null || amt < 0) return 'Enter a valid amount';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        isExpanded: true, 
                        value: _category,
                        items: Expense.categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                        onChanged: (v) => setState(() => _category = v!),
                        decoration: const InputDecoration(labelText: 'Category', prefixIcon: Icon(Icons.category, color: AppTheme.indigo)),
                      ),
                    ],
                  ),
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
                    child: const Icon(Icons.calendar_today, color: AppTheme.indigo),
                  ),
                  title: const Text('Expense Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text('${_date.day}/${_date.month}/${_date.year}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  trailing: TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2020), lastDate: DateTime.now());
                      if (picked != null) setState(() => _date = picked);
                    },
                    child: const Text('Change'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: theme.dividerColor)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Billable Expense', style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: const Text('Link to a client for future invoicing'),
                        activeThumbColor: AppTheme.indigo,
                        value: _isBillable,
                        onChanged: (v) => setState(() => _isBillable = v),
                      ),
                      if (_isBillable) ...[
                        const Divider(height: 32),
                        DropdownButtonFormField<String>(
                          isExpanded: true, 
                          value: _clientId,
                          items: clients.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                          onChanged: (v) => setState(() => _clientId = v),
                          decoration: const InputDecoration(
                            labelText: 'Select Client', 
                            prefixIcon: Icon(Icons.person),
                            border: InputBorder.none,
                          ),
                          validator: (v) => _isBillable && v == null ? 'Please select a client' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _markupController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Markup Percentage',
                            prefixIcon: Icon(Icons.trending_up, color: AppTheme.indigo),
                            suffixText: '%',
                          ),
                          validator: (v) {
                            if (_isBillable) {
                              if (v == null || v.isEmpty) return 'Required';
                              final p = double.tryParse(v);
                              if (p == null || p < 0) return 'Enter a valid percentage';
                            }
                            return null;
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: theme.dividerColor)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Notes & Details', 
                      alignLabelWithHint: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: theme.dividerColor)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Receipt Attachment', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      if (_receiptPath != null && _receiptPath!.isNotEmpty && File(_receiptPath!).existsSync()) ...[
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppBar(
                                      title: const Text('Receipt Preview'),
                                      actions: [
                                        IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                                      ],
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.file(File(_receiptPath!)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.file(
                                  File(_receiptPath!),
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.white, size: 20),
                                    onPressed: () => setState(() => _receiptPath = null),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ] else ...[
                        OutlinedButton.icon(
                          onPressed: () async {
                            final picker = ImagePicker();
                            final image = await picker.pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              final appDir = await getApplicationDocumentsDirectory();
                              final receiptFile = File('${appDir.path}/receipt_${DateTime.now().millisecondsSinceEpoch}.png');
                              await receiptFile.writeAsBytes(await image.readAsBytes());
                              setState(() {
                                _receiptPath = receiptFile.path;
                              });
                            }
                          },
                          icon: const Icon(Icons.receipt),
                          label: const Text('Upload Receipt Image'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100), // padding for bottom bar
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
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _saveExpense,
              child: Text(isEditing ? 'Update Expense' : 'Save Expense', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
