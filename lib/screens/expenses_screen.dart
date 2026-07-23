import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../providers/expense_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/empty_state.dart';

import 'package:intl/intl.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allExpenses = ref.watch(expensesProvider);
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    final categories = ['All', ...allExpenses.map((e) => e.category).toSet()];

    final expenses = allExpenses.where((e) {
      final q = _searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty || e.description.toLowerCase().contains(q);
      final matchesCategory = _selectedCategory == null || _selectedCategory == 'All' ||
          e.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    final totalExpenses = expenses.fold(0.0, (sum, e) => sum + e.amount);

    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEF4444), Color(0xFFF97316)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.trending_down, color: Colors.white.withValues(alpha: 0.8), size: 28),
                  const SizedBox(height: 12),
                  Text('Total Expenses', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(settings.formatCurrency(totalExpenses), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
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
          if (categories.length > 2)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((cat) {
                    final isSelected = (_selectedCategory ?? 'All') == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: isSelected,
                        label: Text(
                          cat,
                          style: TextStyle(
                            color: isSelected ? const Color(0xFF6366F1) : null,
                            fontWeight: isSelected ? FontWeight.bold : null,
                          ),
                        ),
                        selectedColor: const Color(0xFF6366F1).withValues(alpha: 0.15),
                        checkmarkColor: const Color(0xFF6366F1),
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = selected ? cat : null;
                          });
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: BorderSide.none,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: expenses.isEmpty
                    ? EmptyState(
                        icon: Icons.receipt_long,
                        title: 'No expenses found',
                        subtitle: _selectedCategory == null || _selectedCategory == 'All'
                            ? 'Tap the button below to add your first expense'
                            : 'No expenses found for category "$_selectedCategory"',
                        actionLabel: _selectedCategory == null || _selectedCategory == 'All' ? 'Add Expense' : null,
                        onAction: _selectedCategory == null || _selectedCategory == 'All'
                            ? () => context.go('/expenses/new')
                            : null,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          final expense = expenses[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Slidable(
                              key: ValueKey(expense.id),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) => _confirmDelete(expense),
                                    backgroundColor: const Color(0xFFEF4444),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Card(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.1),
                                    child: const Icon(Icons.receipt, color: Color(0xFF6366F1)),
                                  ),
                                  title: Text(expense.description, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 4,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(expense.category, style: const TextStyle(fontSize: 11, color: Color(0xFF6366F1), fontWeight: FontWeight.w600)),
                                          ),
                                          Text(DateFormat('MMM dd, yyyy').format(expense.date), style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Text(settings.formatCurrency(expense.amount), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFEF4444))),
                                  onTap: () => context.go('/expenses/edit/${expense.id}'),
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
        onPressed: () => context.go('/expenses/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add Expense', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _confirmDelete(expense) async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Delete Expense',
      message: 'Are you sure you want to delete "${expense.description}"? This action cannot be undone.',
      confirmLabel: 'Delete',
      icon: Icons.delete,
    );
    if (confirmed == true) {
      ref.read(expensesProvider.notifier).deleteExpense(expense.id);
    }
  }
}
