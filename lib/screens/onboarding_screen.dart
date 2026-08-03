import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../database/database_provider.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _OnboardingBody(ref: ref),
    );
  }
}

class _OnboardingBody extends StatefulWidget {
  final WidgetRef ref;
  const _OnboardingBody({required this.ref});

  @override
  State<_OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<_OnboardingBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Professional Invoicing',
      'subtitle': 'Create beautiful invoices, send to clients, and get paid faster. Fully customizable templates with your brand.',
      'icon': Icons.receipt_long,
      'color': const Color(0xFF6366F1),
    },
    {
      'title': 'Smart Inventory',
      'subtitle': 'Track your stock with real-time alerts, barcodes, and deep analytics. Never run out of your best-sellers.',
      'icon': Icons.inventory_2,
      'color': const Color(0xFF14B8A6),
    },
    {
      'title': 'Powerful Insights',
      'subtitle': 'Detailed reporting, P&L statements, and analytics right at your fingertips. 100% offline-first.',
      'icon': Icons.insights,
      'color': const Color(0xFFF59E0B),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: _completeOnboarding,
              child: const Text('Skip', style: TextStyle(color: Colors.grey)),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (index == 0) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'assets/images/prime_ledger_logo.png',
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ] else ...[
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _pages[index]['color'].withValues(alpha: 0.1),
                          ),
                          child: Icon(_pages[index]['icon'], size: 80, color: _pages[index]['color']),
                        ),
                      ],
                      const SizedBox(height: 48),
                      Text(
                        _pages[index]['title'],
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _pages[index]['subtitle'],
                        style: const TextStyle(fontSize: 16, color: Color(0xFF6B7280), height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? const Color(0xFF6366F1) : const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      _completeOnboarding();
                    } else {
                      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(_currentPage == _pages.length - 1 ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _completeOnboarding() async {
    final settingsDao = widget.ref.read(settingsDaoProvider);
    await settingsDao.setBool('has_seen_onboarding', true);
    if (mounted) context.go('/dashboard');
  }
}
