import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/supplier.dart';
import '../providers/supplier_provider.dart';

import '../widgets/loading_overlay.dart';
import '../utils/error_handler.dart';

class SupplierFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const SupplierFormScreen({super.key, this.id});

  @override
  ConsumerState<SupplierFormScreen> createState() => _SupplierFormScreenState();
}

class _SupplierFormScreenState extends ConsumerState<SupplierFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();
  final _taxIdCtrl = TextEditingController();
  Supplier? _existing;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final suppliers = ref.read(suppliersProvider);
        try {
          _existing = suppliers.firstWhere((s) => s.id == widget.id);
          _nameCtrl.text = _existing!.name;
          _emailCtrl.text = _existing!.email ?? '';
          _phoneCtrl.text = _existing!.phone ?? '';
          _addressCtrl.text = _existing!.address ?? '';
          _contactCtrl.text = _existing!.contactPerson ?? '';
          _taxIdCtrl.text = _existing!.taxId ?? '';
          setState(() {});
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose(); _phoneCtrl.dispose();
    _addressCtrl.dispose(); _contactCtrl.dispose(); _taxIdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.id != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Supplier' : 'Add Supplier')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Supplier Name', prefixIcon: Icon(Icons.business)), validator: (v) => v!.isEmpty ? 'Required' : null),
              const SizedBox(height: 16),
              TextFormField(controller: _contactCtrl, decoration: const InputDecoration(labelText: 'Contact Person', prefixIcon: Icon(Icons.person))),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  if (isMobile) {
                    return Column(
                      children: [
                        TextFormField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)), validator: (v) {
                          if (v == null || v.isEmpty) return null;
                          if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
                          return null;
                        }),
                        const SizedBox(height: 16),
                        TextFormField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'Phone', prefixIcon: Icon(Icons.phone))),
                      ],
                    );
                  }
                  return Row(children: [
                    Expanded(child: TextFormField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)), validator: (v) {
                      if (v == null || v.isEmpty) return null;
                      if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
                      return null;
                    })),
                    const SizedBox(width: 16),
                    Expanded(child: TextFormField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'Phone', prefixIcon: Icon(Icons.phone)))),
                  ]);
                }
              ),
              const SizedBox(height: 16),
              TextFormField(controller: _taxIdCtrl, decoration: const InputDecoration(labelText: 'Tax ID / VAT', prefixIcon: Icon(Icons.receipt))),
              const SizedBox(height: 16),
              TextFormField(controller: _addressCtrl, maxLines: 3, decoration: const InputDecoration(labelText: 'Address', prefixIcon: Icon(Icons.location_on))),
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final supplier = Supplier(
                        id: isEditing ? _existing!.id : const Uuid().v4(),
                        name: _nameCtrl.text,
                        email: _emailCtrl.text.isEmpty ? null : _emailCtrl.text,
                        phone: _phoneCtrl.text.isEmpty ? null : _phoneCtrl.text,
                        address: _addressCtrl.text.isEmpty ? null : _addressCtrl.text,
                        contactPerson: _contactCtrl.text.isEmpty ? null : _contactCtrl.text,
                        taxId: _taxIdCtrl.text.isEmpty ? null : _taxIdCtrl.text,
                        createdAt: isEditing ? _existing!.createdAt : DateTime.now(),
                      );
                      LoadingOverlay.show(context, message: isEditing ? 'Updating...' : 'Saving...');
                      try {
                        if (isEditing) {
                          await ref.read(suppliersProvider.notifier).updateSupplier(supplier);
                        } else {
                          await ref.read(suppliersProvider.notifier).addSupplier(supplier);
                        }
                        LoadingOverlay.hide();
                        if (context.mounted) {
                          AppErrorHandler.showSuccessSnackBar(context, isEditing ? 'Supplier updated successfully' : 'Supplier added successfully');
                          context.pop();
                        }
                      } catch (e) {
                        LoadingOverlay.hide();
                        if (context.mounted) {
                          AppErrorHandler.showErrorSnackBar(context, e, prefix: 'Failed to save supplier');
                        }
                      }
                    }
                  },
                  child: Text(isEditing ? 'Update Supplier' : 'Save Supplier'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
