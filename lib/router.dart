import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'database/database_provider.dart';
import 'screens/dashboard_screen.dart';
import 'screens/clients_screen.dart';
import 'screens/client_form_screen.dart';
import 'screens/invoices_screen.dart';
import 'screens/invoice_form_screen.dart';
import 'screens/expenses_screen.dart';
import 'screens/expense_form_screen.dart';
import 'screens/products_screen.dart';
import 'screens/product_form_screen.dart';
import 'screens/estimates_screen.dart';
import 'screens/estimate_form_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/suppliers_screen.dart';
import 'screens/supplier_form_screen.dart';
import 'screens/purchase_orders_screen.dart';
import 'screens/purchase_order_form_screen.dart';
import 'screens/supplier_payment_form_screen.dart';
import 'screens/payment_form_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/pin_lock_screen.dart';
import 'screens/time_tracker_screen.dart';
import 'screens/time_entry_form_screen.dart';
import 'screens/recurring_invoices_screen.dart';
import 'screens/recurring_profile_form_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/ledger_screen.dart';
import 'screens/payment_history_screen.dart';
import 'providers/settings_provider.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final settingsDao = ref.watch(settingsDaoProvider);
  final isUnlocked = ref.watch(isUnlockedProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    redirect: (context, state) async {
      try {
        final hasSeenOnboarding = await settingsDao.getBool('has_seen_onboarding', defaultValue: false);
        final pin = await settingsDao.get('app_pin');

        if (!hasSeenOnboarding && state.uri.toString() != '/onboarding') {
          return '/onboarding';
        }

        if (hasSeenOnboarding && pin != null && pin.length == 4 && !isUnlocked) {
          final currentPath = state.uri.toString();
          if (currentPath != '/pin' && currentPath != '/onboarding' && currentPath != '/settings/pin') {
            return '/pin';
          }
        }
      } catch (_) {}

      return null;
    },
    routes: [
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: '/pin', builder: (context, state) => const PinLockScreen(isSettingPin: false)),
      GoRoute(path: '/settings/pin', builder: (context, state) => const PinLockScreen(isSettingPin: true)),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          final theme = Theme.of(context);
          final isMobile = MediaQuery.of(context).size.width < 800;
          final selectedIndex = _calculateSelectedIndex(state.uri.toString());

          void onNav(int index) {
            switch (index) {
              case 0: context.go('/dashboard'); break;
              case 1: context.go('/invoices'); break;
              case 2: context.go('/clients'); break;
              case 3: context.go('/menu'); break;
            }
          }

          if (isMobile) {
            return Scaffold(
              body: child,
              bottomNavigationBar: NavigationBar(
                selectedIndex: selectedIndex,
                onDestinationSelected: onNav,
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Dashboard'),
                  NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Invoices'),
                  NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Clients'),
                  NavigationDestination(icon: Icon(Icons.menu), selectedIcon: Icon(Icons.menu_open), label: 'More'),
                ],
              ),
            );
          }

          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onNav,
                  extended: MediaQuery.of(context).size.width > 1200,
                  labelType: MediaQuery.of(context).size.width > 1200 ? NavigationRailLabelType.none : NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: Text('Dashboard')),
                    NavigationRailDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: Text('Invoices')),
                    NavigationRailDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: Text('Clients')),
                    NavigationRailDestination(icon: Icon(Icons.menu), selectedIcon: Icon(Icons.menu_open), label: Text('More')),
                  ],
                ),
                VerticalDivider(thickness: 1, width: 1, color: theme.dividerTheme.color),
                Expanded(child: child),
              ],
            ),
          );
        },
        routes: [
          GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
          GoRoute(path: '/menu', builder: (context, state) => const MenuScreen()),
          GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
          GoRoute(path: '/reports', builder: (context, state) => const ReportsScreen()),
          GoRoute(path: '/ledger', builder: (context, state) => const LedgerScreen()),
          GoRoute(path: '/payments', builder: (context, state) => const PaymentHistoryScreen()),
          GoRoute(
            path: '/clients',
            builder: (context, state) => const ClientsScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ClientFormScreen()),
              GoRoute(path: 'edit/:id', builder: (context, state) => ClientFormScreen(id: state.pathParameters['id'])),
            ],
          ),
          GoRoute(
            path: '/suppliers',
            builder: (context, state) => const SuppliersScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const SupplierFormScreen()),
              GoRoute(path: 'edit/:id', builder: (context, state) => SupplierFormScreen(id: state.pathParameters['id'])),
            ],
          ),
          GoRoute(
            path: '/invoices',
            builder: (context, state) => const InvoicesScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const InvoiceFormScreen()),
              GoRoute(path: 'edit/:id', builder: (context, state) => InvoiceFormScreen(id: state.pathParameters['id'])),
              GoRoute(path: 'pay/:id', builder: (context, state) => PaymentFormScreen(invoiceId: state.pathParameters['id']!)),
            ],
          ),
          GoRoute(
            path: '/expenses',
            builder: (context, state) => const ExpensesScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ExpenseFormScreen()),
              GoRoute(path: 'edit/:id', builder: (context, state) => ExpenseFormScreen(id: state.pathParameters['id'])),
            ],
          ),
          GoRoute(
            path: '/products',
            builder: (context, state) => const ProductsScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ProductFormScreen()),
              GoRoute(path: 'edit/:id', builder: (context, state) => ProductFormScreen(id: state.pathParameters['id'])),
            ],
          ),
          GoRoute(
            path: '/purchase-orders',
            builder: (context, state) => const PurchaseOrdersScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const PurchaseOrderFormScreen()),
              GoRoute(path: 'edit/:id', builder: (context, state) => PurchaseOrderFormScreen(id: state.pathParameters['id'])),
              GoRoute(path: 'pay/:id', builder: (context, state) => SupplierPaymentFormScreen(purchaseOrderId: state.pathParameters['id']!)),
            ],
          ),
          GoRoute(
            path: '/estimates',
            builder: (context, state) => const EstimatesScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const EstimateFormScreen()),
              GoRoute(path: 'edit/:id', builder: (context, state) => EstimateFormScreen(id: state.pathParameters['id'])),
            ],
          ),
          GoRoute(
            path: '/time-tracker',
            builder: (context, state) => const TimeTrackerScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const TimeEntryFormScreen()),
              GoRoute(path: 'edit/:id', builder: (context, state) => TimeEntryFormScreen(id: state.pathParameters['id'])),
            ],
          ),
          GoRoute(
            path: '/recurring',
            builder: (context, state) => const RecurringInvoicesScreen(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const RecurringProfileFormScreen()),
              GoRoute(path: 'edit/:id', builder: (context, state) => RecurringProfileFormScreen(id: state.pathParameters['id'])),
            ],
          ),
        ],
      ),
    ],
  );
});

int _calculateSelectedIndex(String location) {
  if (location.startsWith('/dashboard')) {
    return 0;
  }
  if (location.startsWith('/invoices')) {
    return 1;
  }
  if (location.startsWith('/clients')) {
    return 2;
  }
  if (location.startsWith('/menu')) {
    return 3;
  }
  if (location.startsWith('/products') || 
      location.startsWith('/purchase-orders') || 
      location.startsWith('/reports') || 
      location.startsWith('/settings') ||
      location.startsWith('/estimates') ||
      location.startsWith('/expenses') ||
      location.startsWith('/suppliers') ||
      location.startsWith('/time-tracker') ||
      location.startsWith('/recurring') ||
      location.startsWith('/ledger') ||
      location.startsWith('/payments')) {
    return 3;
  }
  return 0;
}
