import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/time_entry.dart';
import '../providers/time_entry_provider.dart';
import '../providers/client_provider.dart';
import '../widgets/loading_overlay.dart';

class TimeEntryFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const TimeEntryFormScreen({super.key, this.id});

  @override
  ConsumerState<TimeEntryFormScreen> createState() => _TimeEntryFormScreenState();
}

class _TimeEntryFormScreenState extends ConsumerState<TimeEntryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _clientId;
  final _taskCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _hoursCtrl = TextEditingController();
  final _rateCtrl = TextEditingController();
  bool _isBillable = true;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final entries = ref.read(timeEntriesProvider);
        try {
          final entry = entries.firstWhere((e) => e.id == widget.id);
          setState(() {
            _clientId = entry.clientId;
            _taskCtrl.text = entry.taskName;
            _descCtrl.text = entry.description;
            _hoursCtrl.text = entry.hours.toString();
            _rateCtrl.text = entry.rate.toString();
            _isBillable = entry.isBillable;
            _date = entry.date;
          });
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    }
  }

  @override
  void dispose() {
    _taskCtrl.dispose();
    _descCtrl.dispose();
    _hoursCtrl.dispose();
    _rateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clientsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? 'Log Time' : 'Edit Time Entry'),
        actions: [
          if (widget.id != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final router = GoRouter.of(context);
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                LoadingOverlay.show(context, message: 'Deleting...');
                try {
                  await ref.read(timeEntriesProvider.notifier).deleteTimeEntry(widget.id!);
                  LoadingOverlay.hide();
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Time entry deleted'), backgroundColor: Color(0xFF10B981)),
                  );
                  router.pop();
                } catch (e) {
                  LoadingOverlay.hide();
                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text('Failed to delete time entry: $e'), backgroundColor: const Color(0xFFEF4444)),
                  );
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
              TextFormField(
                controller: _taskCtrl,
                decoration: const InputDecoration(labelText: 'Task Name', prefixIcon: Icon(Icons.work)),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 400) {
                    return Column(
                      children: [
                        TextFormField(
                          controller: _hoursCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Hours', prefixIcon: Icon(Icons.timer)),
                          validator: (v) { if (v!.isEmpty) return 'Required'; final h = double.tryParse(v); if (h == null || h <= 0) return 'Must be > 0'; return null; },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _rateCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Hourly Rate', prefixIcon: Icon(Icons.attach_money)),
                          validator: (v) { if (v!.isEmpty) return 'Required'; final r = double.tryParse(v); if (r == null || r <= 0) return 'Must be > 0'; return null; },
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _hoursCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Hours', prefixIcon: Icon(Icons.timer)),
                          validator: (v) { if (v!.isEmpty) return 'Required'; final h = double.tryParse(v); if (h == null || h <= 0) return 'Must be > 0'; return null; },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _rateCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Hourly Rate', prefixIcon: Icon(Icons.attach_money)),
                          validator: (v) { if (v!.isEmpty) return 'Required'; final r = double.tryParse(v); if (r == null || r <= 0) return 'Must be > 0'; return null; },
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description (Optional)', prefixIcon: Icon(Icons.notes)),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Billable'),
                subtitle: const Text('Include this on the next invoice'),
                value: _isBillable,
                onChanged: (v) => setState(() => _isBillable = v),
                activeThumbColor: const Color(0xFF6366F1),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Theme.of(context).dividerColor)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text('Save Time Entry'),
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
      final entry = TimeEntry(
        id: widget.id ?? const Uuid().v4(),
        clientId: _clientId!,
        taskName: _taskCtrl.text,
        description: _descCtrl.text,
        date: _date,
        hours: double.tryParse(_hoursCtrl.text) ?? 0,
        rate: double.tryParse(_rateCtrl.text) ?? 0,
        isBillable: _isBillable,
        createdAt: DateTime.now(),
      );

      LoadingOverlay.show(context, message: 'Saving...');
      try {
        if (widget.id == null) {
          await ref.read(timeEntriesProvider.notifier).addTimeEntry(entry);
        } else {
          await ref.read(timeEntriesProvider.notifier).updateTimeEntry(entry);
        }
        LoadingOverlay.hide();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Time entry saved'), backgroundColor: Color(0xFF10B981)),
        );
        context.pop();
      } catch (e) {
        LoadingOverlay.hide();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save time entry: $e'), backgroundColor: const Color(0xFFEF4444)),
        );
      }
    }
  }
}
