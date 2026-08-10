import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:prime_ledger/database/database.dart';
import 'package:prime_ledger/database/daos/client_dao.dart';
import 'package:prime_ledger/database/daos/time_entry_dao.dart';
import 'package:prime_ledger/database/daos/invoice_dao.dart';
import 'package:prime_ledger/models/client.dart';
import 'package:prime_ledger/models/time_entry.dart';
import 'package:prime_ledger/models/invoice.dart';

void main() {
  late AppDatabase db;
  late ClientDao clientDao;
  late TimeEntryDao timeEntryDao;
  late InvoiceDao invoiceDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    clientDao = ClientDao(db);
    timeEntryDao = TimeEntryDao(db);
    invoiceDao = InvoiceDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Time Tracker & Billing Unit Tests Calculates total billable amount accurately for time entries', () async {
    final client = Client(
      id: 'client-1',
      name: 'Acme Corp',
      email: 'acme@example.com',
      createdAt: DateTime.now(),
    );
    await clientDao.insert(client);

    final entry1 = TimeEntry(
      id: 'time-1',
      clientId: 'client-1',
      taskName: 'UI Design',
      description: 'Mobile layout design',
      date: DateTime.now(),
      hours: 5.5,
      rate: 80.0,
      isBillable: true,
      isInvoiced: false,
      createdAt: DateTime.now(),
    );
    await timeEntryDao.insert(entry1);

    final fetched = await timeEntryDao.getById('time-1');
    expect(fetched, isNotNull);
    expect(fetched!.taskName, equals('UI Design'));
    expect(fetched.hours * fetched.rate, equals(440.0));
    expect(fetched.isInvoiced, isFalse);

    // Update time entry to invoiced
    final updated = fetched.copyWith(isInvoiced: true);
    await timeEntryDao.update(updated);

    final refetched = await timeEntryDao.getById('time-1');
    expect(refetched!.isInvoiced, isTrue);

    // Delete time entry
    await timeEntryDao.delete('time-1');
    final deleted = await timeEntryDao.getById('time-1');
    expect(deleted, isNull);
  });
}
