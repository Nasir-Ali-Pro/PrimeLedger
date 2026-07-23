import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:prime_ledger/database/database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('Backup and Restore database data integrity test', () async {
    // 1. Insert initial dummy data
    await db.into(db.appSettingsTbl).insert(
      const AppSettingsTblCompanion(
        key: Value('companyName'),
        value: Value('Test Backup Corp'),
      ),
    );

    await db.into(db.clientsTbl).insert(
      ClientsTblCompanion.insert(
        id: 'client-123',
        name: 'John Doe',
        createdAt: DateTime.now(),
      ),
    );

    // Verify initial state
    final settingsBefore = await db.select(db.appSettingsTbl).get();
    expect(settingsBefore.length, 1);
    expect(settingsBefore.first.value, 'Test Backup Corp');

    final clientsBefore = await db.select(db.clientsTbl).get();
    expect(clientsBefore.length, 1);
    expect(clientsBefore.first.name, 'John Doe');

    // 2. Export backup
    final backupJson = await db.exportBackup();
    expect(backupJson, contains('Test Backup Corp'));
    expect(backupJson, contains('John Doe'));

    // 3. Clear database
    await db.clearAll();

    // Verify cleared state
    final settingsCleared = await db.select(db.appSettingsTbl).get();
    expect(settingsCleared.isEmpty, true);

    final clientsCleared = await db.select(db.clientsTbl).get();
    expect(clientsCleared.isEmpty, true);

    // 4. Import backup
    await db.importBackup(backupJson);

    // 5. Verify restored state
    final settingsAfter = await db.select(db.appSettingsTbl).get();
    expect(settingsAfter.length, 1);
    expect(settingsAfter.first.value, 'Test Backup Corp');

    final clientsAfter = await db.select(db.clientsTbl).get();
    expect(clientsAfter.length, 1);
    expect(clientsAfter.first.name, 'John Doe');
  });
}
