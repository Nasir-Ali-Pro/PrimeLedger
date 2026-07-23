import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/client.dart';
import '../database/database_provider.dart';

final clientsProvider = NotifierProvider<ClientsNotifier, List<Client>>(() {
  return ClientsNotifier();
});

class ClientsNotifier extends Notifier<List<Client>> {
  @override
  List<Client> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    try {
      final clients = await ref.read(clientDaoProvider).getAll();
      state = clients;
    } catch (e) {
      debugPrint('Error loading clients: $e');
    }
  }

  Future<void> addClient(Client client) async {
    try {
      await ref.read(clientDaoProvider).insert(client);
      await _load();
    } catch (e) {
      debugPrint('Error adding client: $e');
      rethrow;
    }
  }

  Future<void> updateClient(Client client) async {
    try {
      await ref.read(clientDaoProvider).update(client);
      await _load();
    } catch (e) {
      debugPrint('Error updating client: $e');
      rethrow;
    }
  }

  Future<void> deleteClient(String id) async {
    try {
      await ref.read(clientDaoProvider).delete(id);
      await _load();
    } catch (e) {
      debugPrint('Error deleting client: $e');
      rethrow;
    }
  }
}
