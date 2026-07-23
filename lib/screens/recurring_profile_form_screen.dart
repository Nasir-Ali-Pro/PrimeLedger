import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/recurring_profile.dart';
import '../providers/recurring_profile_provider.dart';
import '../providers/client_provider.dart';
import '../widgets/loading_overlay.dart';

class RecurringProfileFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const RecurringProfileFormScreen({super.key, this.id});

  @override
  ConsumerState<RecurringProfileFormScreen> createState() => _RecurringProfileFormScreenState();
}

class _RecurringProfileFormScreenState extends ConsumerState<RecurringProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _clientId;
  String _frequency = 'Monthly';
  final _amountCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  DateTime _nextDate = DateTime.now();

  final List<String> _frequencies = ['Weekly', 'Monthly', 'Yearly'];

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final profiles = ref.read(recurringProfilesProvider);
        try {
          final profile = profiles.firstWhere((p) => p.id == widget.id);
          setState(() {
            _clientId = profile.clientId;
            _frequency = profile.frequency;
            _amountCtrl.text = profile.amount.toString();
            _descCtrl.text = profile.description;
            _nextDate = profile.nextIssueDate;
          });
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clientsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? 'New Recurring Profile' : 'Edit Profile'),
        actions: [
          if (widget.id != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                LoadingOverlay.show(context, message: 'Deleting...');
                try {
                  await ref.read(recurringProfilesProvider.notifier).deleteProfile(widget.id!);
                  LoadingOverlay.hide();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile deleted'), backgroundColor: Color(0xFF10B981)),
                    );
                    context.pop();
                  }
                } catch (e) {
                  LoadingOverlay.hide();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete profile: $e'), backgroundColor: const Color(0xFFEF4444)),
                    );
                  }
                }
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(isExpanded: true, 
                value: _clientId,
                decoration: const InputDecoration(labelText: 'Client', prefixIcon: Icon(Icons.person)),
                items: clients.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                onChanged: (v) => setState(() => _clientId = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 400) {
                    return Column(
                      children: [
                        DropdownButtonFormField<String>(isExpanded: true, 
                          value: _frequency,
                          decoration: const InputDecoration(labelText: 'Frequency', prefixIcon: Icon(Icons.repeat)),
                          items: _frequencies.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                          onChanged: (v) => setState(() => _frequency = v!),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _amountCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Amount per Cycle', prefixIcon: Icon(Icons.attach_money)),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(isExpanded: true, 
                          value: _frequency,
                          decoration: const InputDecoration(labelText: 'Frequency', prefixIcon: Icon(Icons.repeat)),
                          items: _frequencies.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                          onChanged: (v) => setState(() => _frequency = v!),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _amountCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Amount per Cycle', prefixIcon: Icon(Icons.attach_money)),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  );
                }
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descCtrl,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Line Item Description', prefixIcon: Icon(Icons.notes)),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today, color: Color(0xFF6366F1)),
                title: Text('Start / Next Date: ${_nextDate.day}/${_nextDate.month}/${_nextDate.year}'),
                trailing: TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(context: context, initialDate: _nextDate, firstDate: DateTime.now().subtract(const Duration(days: 365)), lastDate: DateTime.now().add(const Duration(days: 365 * 5)));
                    if (picked != null) setState(() => _nextDate = picked);
                  },
                  child: const Text('Change'),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final profile = RecurringProfile(
        id: widget.id ?? const Uuid().v4(),
        clientId: _clientId!,
        frequency: _frequency,
        nextIssueDate: _nextDate,
        amount: double.tryParse(_amountCtrl.text) ?? 0,
        description: _descCtrl.text,
      );

      LoadingOverlay.show(context, message: 'Saving...');
      try {
        if (widget.id == null) {
          await ref.read(recurringProfilesProvider.notifier).addProfile(profile);
        } else {
          await ref.read(recurringProfilesProvider.notifier).updateProfile(profile);
        }
        LoadingOverlay.hide();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile saved'), backgroundColor: Color(0xFF10B981)),
          );
          context.pop();
        }
      } catch (e) {
        LoadingOverlay.hide();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save profile: $e'), backgroundColor: const Color(0xFFEF4444)),
          );
        }
      }
    }
  }
}
