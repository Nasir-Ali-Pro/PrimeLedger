import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/estimate.dart';
import '../database/database_provider.dart';

final estimatesProvider = NotifierProvider<EstimatesNotifier, List<Estimate>>(() {
  return EstimatesNotifier();
});

class EstimatesNotifier extends Notifier<List<Estimate>> {
  @override
  List<Estimate> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final estimates = await ref.read(estimateDaoProvider).getAll();
      state = estimates;
    } catch (e) {
      debugPrint('Error loading estimates: $e');
    }
  }

  Future<void> addEstimate(Estimate estimate) async {
    try {
      await ref.read(estimateDaoProvider).insert(estimate);
      await _load();
    } catch (e) {
      debugPrint('Error adding estimate: $e');
      rethrow;
    }
  }

  Future<void> updateEstimate(Estimate estimate) async {
    try {
      await ref.read(estimateDaoProvider).update(estimate);
      await _load();
    } catch (e) {
      debugPrint('Error updating estimate: $e');
      rethrow;
    }
  }

  Future<void> deleteEstimate(String id) async {
    try {
      await ref.read(estimateDaoProvider).delete(id);
      await _load();
    } catch (e) {
      debugPrint('Error deleting estimate: $e');
      rethrow;
    }
  }
}
