import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../providers/time_entry_provider.dart';
import '../providers/client_provider.dart';
import '../providers/settings_provider.dart';
import '../models/client.dart';
import '../widgets/empty_state.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/loading_overlay.dart';

class TimeTrackerScreen extends ConsumerStatefulWidget {
  const TimeTrackerScreen({super.key});

  @override
  ConsumerState<TimeTrackerScreen> createState() => _TimeTrackerScreenState();
}

class _TimeTrackerScreenState extends ConsumerState<TimeTrackerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _filter = 'All'; // 'All', 'Billable', 'Invoiced'

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(timeEntriesProvider);
    final clients = ref.watch(clientsProvider);
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);
    final clientMap = {for (final c in clients) c.id: c.name};

    final filteredEntries = entries.where((entry) {
      final clientName = clientMap[entry.clientId] ?? '';
      final q = _searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty ||
          entry.taskName.toLowerCase().contains(q) ||
          clientName.toLowerCase().contains(q);

      final matchesFilter = _filter == 'All' ||
          (_filter == 'Billable' && entry.isBillable && !entry.isInvoiced) ||
          (_filter == 'Invoiced' && entry.isInvoiced);

      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () => context.go('/time-tracker/new')),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tasks or clients...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Row(
              children: ['All', 'Billable', 'Invoiced'].map((f) {
                final isSelected = _filter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      f,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF6366F1) : null,
                        fontWeight: isSelected ? FontWeight.bold : null,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFF6366F1).withValues(alpha: 0.15),
                    checkmarkColor: const Color(0xFF6366F1),
                    onSelected: (_) => setState(() => _filter = f),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    side: BorderSide.none,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredEntries.isEmpty
                ? EmptyState(
                    icon: Icons.timer_outlined,
                    title: _searchQuery.isEmpty ? 'No time entries' : 'No matches found',
                    subtitle: _searchQuery.isEmpty
                        ? 'Log billable hours for your clients'
                        : 'No entries match your search query',
                    actionLabel: _searchQuery.isEmpty ? 'Log Time' : null,
                    onAction: _searchQuery.isEmpty ? () => context.go('/time-tracker/new') : null,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredEntries.length,
                    itemBuilder: (context, index) {
                      final entry = filteredEntries[index];
                      final client = clients.firstWhere((c) => c.id == entry.clientId, orElse: () => Client.empty());

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Slidable(
                          key: ValueKey(entry.id),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) => _confirmDelete(entry),
                                backgroundColor: const Color(0xFFEF4444),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              leading: const CircleAvatar(backgroundColor: Color(0xFF8B5CF6), child: Icon(Icons.timer, color: Colors.white)),
                              title: Text(entry.taskName, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('${client.name} • ${entry.hours} hrs @ ${settings.currencySymbol}${entry.rate}/hr'),
                              trailing: entry.isInvoiced
                                ? const Chip(label: Text('Invoiced'), backgroundColor: Colors.green, labelStyle: TextStyle(color: Colors.white, fontSize: 10))
                                : IconButton(icon: const Icon(Icons.edit, color: Color(0xFF6366F1)), onPressed: () => context.go('/time-tracker/edit/${entry.id}')),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/time-tracker/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(dynamic entry) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Delete Time Entry',
      message: 'Delete time entry for "${entry.taskName}"? This cannot be undone.',
    );
    if (confirmed == true) {
      // ignore: use_build_context_synchronously
      LoadingOverlay.show(context, message: 'Deleting...');
      try {
        await ref.read(timeEntriesProvider.notifier).deleteTimeEntry(entry.id);
        LoadingOverlay.hide();
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Time entry deleted successfully.'), backgroundColor: Color(0xFF10B981)),
        );
      } catch (e) {
        LoadingOverlay.hide();
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Failed to delete time entry: $e'), backgroundColor: const Color(0xFFEF4444)),
        );
      }
    }
  }
}
