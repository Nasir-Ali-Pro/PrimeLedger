import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../providers/client_provider.dart';
import '../providers/ledger_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/confirm_dialog.dart';

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allClients = ref.watch(clientsProvider);
    final clients = _searchQuery.isEmpty
        ? allClients
        : allClients.where((c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Clients', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search clients...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          Expanded(
            child: clients.isEmpty
                    ? EmptyState(
                        icon: Icons.people_outline,
                        title: _searchQuery.isEmpty ? 'No clients yet' : 'No clients found',
                        subtitle: _searchQuery.isEmpty
                            ? 'Tap the button below to add your first client'
                            : 'No clients match your search query',
                        actionLabel: _searchQuery.isEmpty ? 'Add Client' : null,
                        onAction: _searchQuery.isEmpty ? () => context.go('/clients/new') : null,
                      )
                    : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: clients.length,
                    itemBuilder: (context, index) {
                      final client = clients[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.1),
                                    child: Text(
                                      client.name.isNotEmpty ? client.name[0].toUpperCase() : 'C',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.secondary),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(client.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: theme.colorScheme.onSurface)),
                                        if (client.contactPerson != null && client.contactPerson!.isNotEmpty)
                                          Text('Contact: ${client.contactPerson}', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if ((client.email != null && client.email!.isNotEmpty) || (client.phone != null && client.phone!.isNotEmpty)) ...[
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 6,
                                  children: [
                                    if (client.email != null && client.email!.isNotEmpty)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.email, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                                          const SizedBox(width: 6),
                                          Text(client.email!, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                                        ],
                                      ),
                                    if (client.phone != null && client.phone!.isNotEmpty)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.phone, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                                          const SizedBox(width: 6),
                                          Text(client.phone!, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                                        ],
                                      ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 12),
                              const Divider(height: 1),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: () => context.go('/clients/edit/${client.id}'),
                                    icon: const Icon(Icons.edit, size: 16, color: Color(0xFF4F46E5)),
                                    label: const Text('Edit', style: TextStyle(color: Color(0xFF4F46E5), fontSize: 12, fontWeight: FontWeight.bold)),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                      side: const BorderSide(color: Color(0xFF4F46E5)),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                    tooltip: 'Delete',
                                    onPressed: () async {
                                      final confirmed = await ConfirmDialog.show(
                                        context: context,
                                        title: 'Delete Client',
                                        message: 'Are you sure you want to delete ${client.name}? This will permanently delete all associated invoices and payment records!',
                                        confirmLabel: 'Delete',
                                        confirmColor: theme.colorScheme.error,
                                      );
                                      if (confirmed == true) {
                                        try {
                                          await ref.read(clientsProvider.notifier).deleteClient(client.id);
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('${client.name} deleted successfully.'),
                                                backgroundColor: const Color(0xFF10B981),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            String errMsg = e.toString();
                                            if (errMsg.contains('Exception:')) {
                                              errMsg = errMsg.substring(errMsg.indexOf('Exception:') + 10);
                                            }
                                            showDialog(
                                              context: context,
                                              builder: (dialogCtx) => AlertDialog(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                title: const Row(
                                                  children: [
                                                    Icon(Icons.warning_amber_rounded, color: Colors.orange),
                                                    SizedBox(width: 8),
                                                    Text('Deletion Blocked'),
                                                  ],
                                                ),
                                                content: Text(errMsg),
                                                actions: [
                                                  TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('OK')),
                                                ],
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    },
                                  ),
                                  const Spacer(),
                                  TextButton.icon(
                                    onPressed: () {
                                      ref.read(ledgerFilterProvider.notifier).setClientFilter(client.id);
                                      context.go('/ledger');
                                    },
                                    icon: const Icon(Icons.menu_book, size: 16),
                                    label: const Text('View Ledger', style: TextStyle(fontSize: 12)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go('/clients/new');
        },
        backgroundColor: theme.colorScheme.secondary,
        icon: Icon(Icons.add, color: theme.colorScheme.onSecondary),
        label: Text('Add Client', style: TextStyle(color: theme.colorScheme.onSecondary, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
