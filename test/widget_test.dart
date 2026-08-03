import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:prime_ledger/main.dart';
import 'package:prime_ledger/database/database.dart';
import 'package:prime_ledger/database/database_provider.dart';
import 'package:prime_ledger/services/secure_storage_service.dart';

class FakeSecureStorageService implements SecureStorageService {
  final Map<String, String> _data = {};

  @override
  Future<void> write(String key, String value) async {
    _data[key] = value;
  }

  @override
  Future<String?> read(String key) async {
    return _data[key];
  }

  @override
  Future<void> delete(String key) async {
    _data.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    _data.clear();
  }
}

void main() {
  testWidgets('PrimeLedger App Smoke Test', (WidgetTester tester) async {
    final testDb = AppDatabase(NativeDatabase.memory());
    final fakeSecureStorage = FakeSecureStorageService();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(testDb),
          secureStorageServiceProvider.overrideWithValue(fakeSecureStorage),
        ],
        child: const PrimeLedgerApp(),
      ),
    );

    // Wait for asynchronous initialization (_initApp) to complete
    await tester.idle();

    // Rebuild the app now that it is initialized
    await tester.pump();

    // Wait for the route transition animations to settle
    await tester.pumpAndSettle();

    // Verify that the onboarding screen is shown with its initial content
    expect(find.text('Professional Invoicing'), findsOneWidget);

    // Close the database connection
    await testDb.close();
  });
}

