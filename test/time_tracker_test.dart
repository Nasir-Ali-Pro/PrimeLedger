import 'package:flutter_test/flutter_test.dart';
import 'package:prime_ledger/models/time_entry.dart';

void main() {
  group('Time Tracker & Billing Unit Tests', () {
    test('Calculates total billable amount accurately for time entries', () {
      final entry1 = TimeEntry(
        id: 'te-1',
        clientId: 'client-1',
        taskName: 'UI Design & Wireframing',
        hours: 5.5,
        rate: 60.0,
        isBillable: true,
        date: DateTime.now(),
        createdAt: DateTime.now(),
      );

      final entry2 = TimeEntry(
        id: 'te-2',
        clientId: 'client-1',
        taskName: 'Internal Sync Meeting',
        hours: 2.0,
        rate: 60.0,
        isBillable: false,
        date: DateTime.now(),
        createdAt: DateTime.now(),
      );

      final entries = [entry1, entry2];

      final billableEntries = entries.where((e) => e.isBillable).toList();
      final totalBillableAmount = billableEntries.fold(0.0, (sum, e) => sum + (e.hours * e.rate));

      expect(billableEntries.length, 1);
      expect(totalBillableAmount, 330.0);
    });
  });
}
