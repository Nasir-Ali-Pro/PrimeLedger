import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/time_entry.dart';
import '../database/database_provider.dart';

final timeEntriesProvider = NotifierProvider<TimeEntryNotifier, List<TimeEntry>>(() {
  return TimeEntryNotifier();
});

class TimeEntryNotifier extends Notifier<List<TimeEntry>> {
  @override
  List<TimeEntry> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final entries = await ref.read(timeEntryDaoProvider).getAll();
      state = entries;
    } catch (e) {
      debugPrint('Error loading time entries: $e');
    }
  }

  Future<void> addTimeEntry(TimeEntry entry) async {
    try {
      await ref.read(timeEntryDaoProvider).insert(entry);
      await _load();
    } catch (e) {
      debugPrint('Error adding time entry: $e');
      rethrow;
    }
  }

  Future<void> updateTimeEntry(TimeEntry entry) async {
    try {
      await ref.read(timeEntryDaoProvider).update(entry);
      await _load();
    } catch (e) {
      debugPrint('Error updating time entry: $e');
      rethrow;
    }
  }

  Future<void> deleteTimeEntry(String id) async {
    try {
      await ref.read(timeEntryDaoProvider).delete(id);
      await _load();
    } catch (e) {
      debugPrint('Error deleting time entry: $e');
      rethrow;
    }
  }
}
