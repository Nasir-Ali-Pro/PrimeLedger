import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12, top: 24),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required IconData icon, required String route, required Color color}) {
    return Card(
      elevation: 2,
      shadowColor: color.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () => context.push(route),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Financial'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildMenuCard(context, title: 'General Ledger', icon: Icons.book, route: '/ledger', color: const Color(0xFF6366F1)),
                _buildMenuCard(context, title: 'Reports', icon: Icons.bar_chart, route: '/reports', color: const Color(0xFF10B981)),
                _buildMenuCard(context, title: 'Payment History', icon: Icons.history, route: '/payments', color: const Color(0xFF00A651)),
              ],
            ),

            _buildSectionHeader('Sales & Purchasing'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildMenuCard(context, title: 'Estimates', icon: Icons.request_quote, route: '/estimates', color: AppTheme.amber),
                _buildMenuCard(context, title: 'Purchase Orders', icon: Icons.shopping_cart, route: '/purchase-orders', color: AppTheme.emerald),
                _buildMenuCard(context, title: 'Recurring Invoices', icon: Icons.autorenew, route: '/recurring', color: AppTheme.indigo),
                _buildMenuCard(context, title: 'Products', icon: Icons.inventory_2, route: '/products', color: AppTheme.rose),
              ],
            ),
            
            _buildSectionHeader('People & Contacts'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildMenuCard(context, title: 'Clients', icon: Icons.people, route: '/clients', color: const Color(0xFF3B82F6)),
                _buildMenuCard(context, title: 'Suppliers', icon: Icons.local_shipping, route: '/suppliers', color: const Color(0xFFF97316)),
              ],
            ),

            _buildSectionHeader('Tracking'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildMenuCard(context, title: 'Expenses', icon: Icons.receipt, route: '/expenses', color: const Color(0xFFEF4444)),
                _buildMenuCard(context, title: 'Time Tracker', icon: Icons.timer, route: '/time-tracker', color: const Color(0xFF8B5CF6)),
              ],
            ),

            _buildSectionHeader('System'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildMenuCard(context, title: 'Settings', icon: Icons.settings, route: '/settings', color: const Color(0xFF64748B)),
              ],
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
