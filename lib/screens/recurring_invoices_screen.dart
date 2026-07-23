import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/recurring_profile_provider.dart';
import '../providers/client_provider.dart';
import '../providers/settings_provider.dart';
import '../models/recurring_profile.dart';
import '../models/client.dart';
import '../widgets/loading_overlay.dart';
import 'package:intl/intl.dart';

class RecurringInvoicesScreen extends ConsumerStatefulWidget {
  const RecurringInvoicesScreen({super.key});

  @override
  ConsumerState<RecurringInvoicesScreen> createState() => _RecurringInvoicesScreenState();
}

class _RecurringInvoicesScreenState extends ConsumerState<RecurringInvoicesScreen> {
  Future<void> _runCheck() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    LoadingOverlay.show(context, message: 'Checking profiles...');
    try {
      final count = await ref.read(recurringProfilesProvider.notifier).checkAndGenerateInvoices();
      LoadingOverlay.hide();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(count > 0 
              ? 'Generated $count new invoice(s) successfully.'
              : 'No new invoices need to be generated at this time.'),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    } catch (e) {
      LoadingOverlay.hide();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Error generating invoices: $e'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profiles = ref.watch(recurringProfilesProvider);
    final clients = ref.watch(clientsProvider);
    final settings = ref.watch(settingsProvider);
    final clientMap = {for (final c in clients) c.id: c};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recurring Invoices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_circle_outline),
            tooltip: 'Run Check Now',
            onPressed: _runCheck,
          ),
          IconButton(icon: const Icon(Icons.add), onPressed: () => context.go('/recurring/new')),
        ],
      ),
      body: profiles.isEmpty
          ? const Center(child: Text('No recurring profiles yet.'))
          : ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                final client = clientMap[profile.clientId] ?? Client.empty();

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: profile.isActive ? const Color(0xFF10B981) : Colors.grey,
                      child: const Icon(Icons.autorenew, color: Colors.white),
                    ),
                    title: Text('${client.name} • ${settings.formatCurrency(profile.amount)}'),
                    subtitle: Text('${profile.frequency} • Next: ${DateFormat.yMd().format(profile.nextIssueDate)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Delete Recurring Profile'),
                                content: const Text('Are you sure you want to delete this recurring profile? This action cannot be undone.'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                                  TextButton(onPressed: () => Navigator.pop(ctx, true), style: TextButton.styleFrom(foregroundColor: Colors.red), child: const Text('Delete')),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              if (!context.mounted) return;
                              LoadingOverlay.show(context, message: 'Deleting profile...');
                              try {
                                await ref.read(recurringProfilesProvider.notifier).deleteProfile(profile.id);
                                LoadingOverlay.hide();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Profile deleted successfully.'), backgroundColor: Color(0xFF10B981)),
                                  );
                                }
                              } catch (e) {
                                LoadingOverlay.hide();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Failed to delete: $e'), backgroundColor: const Color(0xFFEF4444)),
                                  );
                                }
                              }
                            }
                          },
                        ),
                        Switch(
                          value: profile.isActive,
                          onChanged: (v) async {
                            final updated = RecurringProfile(
                              id: profile.id,
                              clientId: profile.clientId,
                              frequency: profile.frequency,
                              nextIssueDate: profile.nextIssueDate,
                              amount: profile.amount,
                              description: profile.description,
                              isActive: v,
                            );
                            LoadingOverlay.show(context, message: v ? 'Activating...' : 'Deactivating...');
                            try {
                              await ref.read(recurringProfilesProvider.notifier).updateProfile(updated);
                              LoadingOverlay.hide();
                            } catch (e) {
                              LoadingOverlay.hide();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to update: $e'), backgroundColor: const Color(0xFFEF4444)),
                                );
                              }
                            }
                          },
                          activeThumbColor: const Color(0xFF6366F1),
                        ),
                      ],
                    ),
                    onTap: () => context.go('/recurring/edit/${profile.id}'),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/recurring/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
