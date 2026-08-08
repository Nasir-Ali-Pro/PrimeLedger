import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/recurring_profile.dart';
import '../providers/recurring_profile_provider.dart';
import '../providers/client_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/loading_overlay.dart';
import '../utils/error_handler.dart';

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
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  DateTime _nextDate = DateTime.now();

  final List<String> _frequencies = ['Daily', 'Weekly', 'Monthly', 'Quarterly', 'Yearly'];

  final _dateFormatter = DateFormat('dd MMMM yyyy');

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
            _startDate = profile.startDate;
            _endDate = profile.endDate;
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
    final settings = ref.watch(settingsProvider);

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
                  final isMobile = constraints.maxWidth < 600;
                  if (isMobile) {
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
                          decoration: InputDecoration(labelText: 'Amount per Cycle', prefixText: settings.currencySymbol, prefixIcon: const Icon(Icons.attach_money)),
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
                          decoration: InputDecoration(labelText: 'Amount per Cycle', prefixText: settings.currencySymbol, prefixIcon: const Icon(Icons.attach_money)),
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
              const SizedBox(height: 20),
              const Text('Schedule & Range', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              // Start Date Picker Tile
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Theme.of(context).dividerColor)),
                child: ListTile(
                  leading: const Icon(Icons.play_arrow, color: Color(0xFF10B981)),
                  title: const Text('Start Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(_dateFormatter.format(_startDate), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  trailing: TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _startDate = picked;
                          if (widget.id == null) {
                            _nextDate = picked;
                          }
                        });
                      }
                    },
                    child: const Text('Change'),
                  ),
                ),
              ),

              // End Date Picker Tile (Optional)
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Theme.of(context).dividerColor)),
                child: ListTile(
                  leading: const Icon(Icons.stop, color: Color(0xFFEF4444)),
                  title: const Text('End Date (Optional)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(_endDate != null ? _dateFormatter.format(_endDate!) : 'Ongoing (No End Date)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _endDate != null ? Theme.of(context).colorScheme.onSurface : Colors.grey)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_endDate != null)
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey, size: 18),
                          tooltip: 'Remove End Date',
                          onPressed: () => setState(() => _endDate = null),
                        ),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _endDate ?? _startDate.add(const Duration(days: 365)),
                            firstDate: _startDate,
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() => _endDate = picked);
                          }
                        },
                        child: Text(_endDate != null ? 'Change' : 'Set Date'),
                      ),
                    ],
                  ),
                ),
              ),

              // Next Issue Date Tile
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Theme.of(context).dividerColor)),
                child: ListTile(
                  leading: const Icon(Icons.event, color: Color(0xFF6366F1)),
                  title: const Text('Next Invoice Issue Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(_dateFormatter.format(_nextDate), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                  trailing: TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _nextDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => _nextDate = picked);
                    },
                    child: const Text('Change'),
                  ),
                ),
              ),

              const SizedBox(height: 24),
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
      if (_endDate != null && _endDate!.isBefore(_startDate)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('End Date cannot be before Start Date'), backgroundColor: Color(0xFFEF4444)),
        );
        return;
      }

      final profile = RecurringProfile(
        id: widget.id ?? const Uuid().v4(),
        clientId: _clientId!,
        frequency: _frequency,
        startDate: _startDate,
        endDate: _endDate,
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
          AppErrorHandler.showSuccessSnackBar(context, widget.id == null ? 'Profile saved successfully' : 'Profile updated successfully');
          context.pop();
        }
      } catch (e) {
        LoadingOverlay.hide();
        if (mounted) {
          AppErrorHandler.showErrorSnackBar(context, e, prefix: 'Failed to save profile');
        }
      }
    }
  }
}
