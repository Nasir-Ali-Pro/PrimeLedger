import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme.dart';
import 'router.dart';
import 'database/database_provider.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Global Flutter Error: ${details.exceptionAsString()}');
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint('Global Async Error: $error\n$stack');
    return true;
  };

  runApp(
    const ProviderScope(
      child: PrimeLedgerApp(),
    ),
  );
}

class PrimeLedgerApp extends ConsumerStatefulWidget {
  const PrimeLedgerApp({super.key});

  @override
  ConsumerState<PrimeLedgerApp> createState() => _PrimeLedgerAppState();
}

class _PrimeLedgerAppState extends ConsumerState<PrimeLedgerApp> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    try {
      final paymentDao = ref.read(paymentDaoProvider);
      await paymentDao.syncAllInvoicesStatus();
    } catch (e) {
      debugPrint('Invoice status sync failed: $e');
    }
    if (mounted) {
      setState(() => _initialized = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);

    if (!_initialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp.router(
      title: 'PrimeLedger',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
