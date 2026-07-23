import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/client.dart';

class ClientDao {
  final AppDatabase _db;

  ClientDao(this._db);

  Future<List<Client>> getAll() async {
    try {
      final rows = await _db.select(_db.clientsTbl).get();
      return rows.map(_toModel).toList();
    } catch (e) {
      debugPrint('ClientDao.getAll error: $e');
      rethrow;
    }
  }

  Future<Client?> getById(String id) async {
    try {
      final row = await (_db.select(_db.clientsTbl)..where((t) => t.id.equals(id))).getSingleOrNull();
      return row != null ? _toModel(row) : null;
    } catch (e) {
      debugPrint('ClientDao.getById error: $e');
      rethrow;
    }
  }

  Future<void> insert(Client client) async {
    try {
      await _db.into(_db.clientsTbl).insert(_toCompanion(client));
    } catch (e) {
      debugPrint('ClientDao.insert error: $e');
      rethrow;
    }
  }

  Future<void> update(Client client) async {
    try {
      await (_db.update(_db.clientsTbl)..where((t) => t.id.equals(client.id))).write(_toCompanion(client));
    } catch (e) {
      debugPrint('ClientDao.update error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await _db.transaction(() async {
        // Check if there are any dependent records
        final invoiceCount = await (_db.select(_db.invoicesTbl)..where((t) => t.clientId.equals(id))).get();
        final paymentCount = await (_db.select(_db.paymentsTbl)..where((t) => t.clientId.equals(id))).get();
        final estimateCount = await (_db.select(_db.estimatesTbl)..where((t) => t.clientId.equals(id))).get();
        final expenseCount = await (_db.select(_db.expensesTbl)..where((t) => t.clientId.equals(id))).get();
        final timeEntryCount = await (_db.select(_db.timeEntriesTbl)..where((t) => t.clientId.equals(id))).get();
        final recurringCount = await (_db.select(_db.recurringProfilesTbl)..where((t) => t.clientId.equals(id))).get();

        if (invoiceCount.isNotEmpty || 
            paymentCount.isNotEmpty || 
            estimateCount.isNotEmpty || 
            expenseCount.isNotEmpty || 
            timeEntryCount.isNotEmpty || 
            recurringCount.isNotEmpty) {
          throw Exception(
            'Cannot delete client because they have existing history '
            '(${invoiceCount.length} Invoices, ${paymentCount.length} Payments, '
            '${estimateCount.length} Estimates, ${expenseCount.length} Expenses, '
            '${timeEntryCount.length} Time Entries, ${recurringCount.length} Recurring Profiles). '
            'Please delete these transactions first.'
          );
        }

        // Delete the client itself
        await (_db.delete(_db.clientsTbl)..where((t) => t.id.equals(id))).go();
      });
    } catch (e) {
      debugPrint('ClientDao.delete error: $e');
      rethrow;
    }
  }

  Client _toModel(ClientsTblData row) {
    return Client(
      id: row.id,
      name: row.name,
      email: row.email,
      phone: row.phone,
      address: row.address,
      createdAt: row.createdAt,
      contactPerson: row.contactPerson,
      taxNumber: row.taxNumber,
      paymentTermsDays: row.paymentTermsDays,
      creditLimit: row.creditLimit,
    );
  }

  ClientsTblCompanion _toCompanion(Client model) {
    return ClientsTblCompanion(
      id: Value(model.id),
      name: Value(model.name),
      email: Value(model.email),
      phone: Value(model.phone),
      address: Value(model.address),
      createdAt: Value(model.createdAt),
      contactPerson: Value(model.contactPerson),
      taxNumber: Value(model.taxNumber),
      paymentTermsDays: Value(model.paymentTermsDays),
      creditLimit: Value(model.creditLimit),
    );
  }
}
