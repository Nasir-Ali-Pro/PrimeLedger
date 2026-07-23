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
                      return Slidable(
                        key: ValueKey(client.id),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (ctx) async {
                                final confirmed = await ConfirmDialog.show(
                                  context: context,
                                  title: 'Delete Client',
                                  message: 'Are you sure you want to delete ${client.name}? This will permanently delete all associated invoices and payment records! This action cannot be undone.',
                                  confirmLabel: 'Delete',
                                  confirmColor: theme.colorScheme.error,
                                );
                                if (confirmed == true) {
                                  try {
                                    await ref.read(clientsProvider.notifier).deleteClient(client.id);
                                    if (ctx.mounted) {
                                      ScaffoldMessenger.of(ctx).showSnackBar(
                                        SnackBar(
                                          content: Text('${client.name} deleted successfully.'),
                                          backgroundColor: const Color(0xFF10B981),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    if (ctx.mounted) {
                                      String errMsg = e.toString();
                                      if (errMsg.contains('Exception:')) {
                                        errMsg = errMsg.substring(errMsg.indexOf('Exception:') + 10);
                                      }
                                      showDialog(
                                        context: ctx,
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
                                            TextButton(
                                              onPressed: () => Navigator.pop(dialogCtx),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              backgroundColor: theme.colorScheme.error,
                              foregroundColor: theme.colorScheme.onError,
                              icon: Icons.delete,
                              label: 'Delete',
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                           child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            onTap: () {
                              ref.read(ledgerFilterProvider.notifier).setClientFilter(client.id);
                              context.go('/ledger');
                            },
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.1),
                              child: Text(
                                client.name.isNotEmpty ? client.name[0].toUpperCase() : 'C',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.colorScheme.secondary),
                              ),
                            ),
                            title: Text(client.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.colorScheme.onSurface)),
                            subtitle: (client.email == null || client.email!.isEmpty) && (client.phone == null || client.phone!.isEmpty)
                                ? null
                                : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (client.contactPerson != null && client.contactPerson!.isNotEmpty) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.person_outline, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                                        const SizedBox(width: 8),
                                        Text(client.contactPerson!, style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6), fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                  if (client.email != null && client.email!.isNotEmpty) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.email, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                                        const SizedBox(width: 8),
                                        Text(client.email!, style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                  if (client.phone != null && client.phone!.isNotEmpty) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.phone, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                                        const SizedBox(width: 8),
                                        Text(client.phone!, style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.edit, color: theme.colorScheme.primary),
                              onPressed: () {
                                context.go('/clients/edit/${client.id}');
                              },
                            ),
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
