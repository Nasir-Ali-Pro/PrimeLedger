import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/client.dart';
import '../providers/client_provider.dart';
import '../widgets/loading_overlay.dart';
import '../utils/error_handler.dart';
import '../theme.dart';

class ClientFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const ClientFormScreen({super.key, this.id});

  @override
  ConsumerState<ClientFormScreen> createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends ConsumerState<ClientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _paymentTermsController = TextEditingController(text: '14');
  final _creditLimitController = TextEditingController(text: '0.0');

  Client? _existingClient;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      // Need a post-frame callback to safely access ref and state
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final clients = ref.read(clientsProvider);
        try {
          _existingClient = clients.firstWhere((c) => c.id == widget.id);
          _nameController.text = _existingClient!.name;
          _emailController.text = _existingClient!.email ?? '';
          _phoneController.text = _existingClient!.phone ?? '';
          _addressController.text = _existingClient!.address ?? '';
          _contactController.text = _existingClient!.contactPerson ?? '';
          _taxNumberController.text = _existingClient!.taxNumber ?? '';
          _paymentTermsController.text = _existingClient!.paymentTermsDays.toString();
          _creditLimitController.text = _existingClient!.creditLimit.toString();
          setState(() {});
        } catch (e) {
          // Client not found
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _taxNumberController.dispose();
    _paymentTermsController.dispose();
    _creditLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.id != null;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Client' : 'Add Client'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Client Details',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildTextField('Company Name', Icons.business, _nameController),
              const SizedBox(height: 16),
              _buildTextField(
                'Email Address',
                Icons.email,
                _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return null;
                  if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Phone Number',
                Icons.phone,
                _phoneController,
                keyboardType: TextInputType.phone,
                validator: (v) => null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Billing Address',
                Icons.location_on,
                _addressController,
                maxLines: 3,
                validator: (v) => null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Contact Person',
                Icons.person_outline,
                _contactController,
                validator: (v) => null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Tax Identification Number',
                Icons.receipt_long,
                _taxNumberController,
                validator: (v) => null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Default Payment Terms (Days)',
                Icons.calendar_month,
                _paymentTermsController,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final parsed = int.tryParse(v);
                  if (parsed == null || parsed < 0) return 'Must be a positive integer';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Credit Limit',
                Icons.credit_card,
                _creditLimitController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final parsed = double.tryParse(v);
                  if (parsed == null || parsed < 0) return 'Must be a positive number';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final client = Client(
                        id: isEditing ? _existingClient!.id : const Uuid().v4(),
                        name: _nameController.text,
                        email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
                        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
                        address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
                        createdAt: isEditing ? _existingClient!.createdAt : DateTime.now(),
                        contactPerson: _contactController.text.trim().isEmpty ? null : _contactController.text.trim(),
                        taxNumber: _taxNumberController.text.trim().isEmpty ? null : _taxNumberController.text.trim(),
                        paymentTermsDays: int.tryParse(_paymentTermsController.text) ?? 14,
                        creditLimit: double.tryParse(_creditLimitController.text) ?? 0.0,
                      );
                      
                      LoadingOverlay.show(context, message: isEditing ? 'Updating...' : 'Saving...');
                      try {
                        if (isEditing) {
                          await ref.read(clientsProvider.notifier).updateClient(client);
                        } else {
                          await ref.read(clientsProvider.notifier).addClient(client);
                        }
                        LoadingOverlay.hide();
                        if (context.mounted) {
                          AppErrorHandler.showSuccessSnackBar(context, isEditing ? 'Client updated successfully' : 'Client added successfully');
                          context.pop();
                        }
                      } catch (e) {
                        LoadingOverlay.hide();
                        if (context.mounted) {
                          AppErrorHandler.showErrorSnackBar(context, e, prefix: 'Failed to save client');
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.emerald,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    isEditing ? 'Update Client' : 'Save Client',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller, {
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
