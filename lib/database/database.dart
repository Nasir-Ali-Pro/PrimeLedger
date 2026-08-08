import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class ClientsTbl extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get contactPerson => text().nullable()();
  TextColumn get taxNumber => text().nullable()();
  IntColumn get paymentTermsDays => integer().withDefault(const Constant(14))();
  RealColumn get creditLimit => real().withDefault(const Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'invoices_client', columns: {#clientId})
class InvoicesTbl extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text().references(ClientsTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get invoiceNumber => text().unique()();
  DateTimeColumn get issueDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  RealColumn get subTotal => real()();
  RealColumn get taxTotal => real()();
  RealColumn get totalAmount => real()();
  TextColumn get status => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  RealColumn get discountPercent => real().withDefault(const Constant(0.0))();
  RealColumn get discountAmount => real().withDefault(const Constant(0.0))();
  RealColumn get withholdingTaxPercent => real().withDefault(const Constant(0.0))();
  RealColumn get withholdingTaxAmount => real().withDefault(const Constant(0.0))();
  RealColumn get tax2Percent => real().withDefault(const Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'invoice_items_invoice', columns: {#invoiceId})
class InvoiceItemsTbl extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId => text().references(InvoicesTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get productId => text().nullable()();
  TextColumn get description => text()();
  IntColumn get quantity => integer()();
  RealColumn get rate => real()();
  RealColumn get taxPercent => real()();
  RealColumn get taxAmount => real()();
  RealColumn get discountPercent => real().withDefault(const Constant(0.0))();
  RealColumn get total => real()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'estimates_client', columns: {#clientId})
class EstimatesTbl extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text().references(ClientsTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get estimateNumber => text().unique()();
  DateTimeColumn get issueDate => dateTime()();
  DateTimeColumn get expiryDate => dateTime()();
  RealColumn get subTotal => real()();
  RealColumn get taxTotal => real()();
  RealColumn get totalAmount => real()();
  TextColumn get status => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  RealColumn get discountPercent => real().withDefault(const Constant(0.0))();
  RealColumn get discountAmount => real().withDefault(const Constant(0.0))();
  RealColumn get withholdingTaxPercent => real().withDefault(const Constant(0.0))();
  RealColumn get withholdingTaxAmount => real().withDefault(const Constant(0.0))();
  RealColumn get tax2Percent => real().withDefault(const Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'estimate_items_estimate', columns: {#estimateId})
class EstimateItemsTbl extends Table {
  TextColumn get id => text()();
  TextColumn get estimateId => text().references(EstimatesTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get productId => text().nullable()();
  TextColumn get description => text()();
  IntColumn get quantity => integer()();
  RealColumn get rate => real()();
  RealColumn get taxPercent => real()();
  RealColumn get taxAmount => real()();
  RealColumn get discountPercent => real().withDefault(const Constant(0.0))();
  RealColumn get total => real()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'expenses_client', columns: {#clientId})
class ExpensesTbl extends Table {
  TextColumn get id => text()();
  TextColumn get description => text()();
  RealColumn get amount => real()();
  TextColumn get category => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get clientId => text().references(ClientsTbl, #id, onDelete: KeyAction.setNull).nullable()();
  BoolColumn get isBillable => boolean()();
  TextColumn get receiptPath => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  RealColumn get markupPercent => real().withDefault(const Constant(0.0))();
  TextColumn get invoiceId => text().references(InvoicesTbl, #id, onDelete: KeyAction.setNull).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'payments_invoice', columns: {#invoiceId})
@TableIndex(name: 'payments_client', columns: {#clientId})
class PaymentsTbl extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId => text().references(InvoicesTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get clientId => text().references(ClientsTbl, #id, onDelete: KeyAction.cascade)();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get paymentMethod => text()();
  TextColumn get referenceNumber => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductsTbl extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get sku => text().nullable()();
  TextColumn get barcode => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get category => text()();
  RealColumn get costPrice => real()();
  RealColumn get sellingPrice => real()();
  IntColumn get quantity => integer()();
  IntColumn get reorderLevel => integer()();
  TextColumn get unit => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'po_supplier', columns: {#supplierId})
class PurchaseOrdersTbl extends Table {
  TextColumn get id => text()();
  TextColumn get supplierId => text().references(SuppliersTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get poNumber => text().unique()();
  DateTimeColumn get issueDate => dateTime()();
  DateTimeColumn get expectedDate => dateTime()();
  RealColumn get subTotal => real()();
  RealColumn get taxTotal => real()();
  RealColumn get totalAmount => real()();
  TextColumn get status => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'po_items_po', columns: {#purchaseOrderId})
class PoItemsTbl extends Table {
  TextColumn get id => text()();
  TextColumn get purchaseOrderId => text().references(PurchaseOrdersTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get productId => text().nullable()();
  TextColumn get description => text()();
  IntColumn get quantity => integer()();
  IntColumn get receivedQty => integer()();
  RealColumn get unitPrice => real()();
  RealColumn get taxPercent => real()();
  RealColumn get taxAmount => real()();
  RealColumn get total => real()();

  @override
  Set<Column> get primaryKey => {id};
}

class SuppliersTbl extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get contactPerson => text().nullable()();
  TextColumn get taxId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'time_entries_client', columns: {#clientId})
class TimeEntriesTbl extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text().references(ClientsTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get taskName => text()();
  TextColumn get description => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get hours => real()();
  RealColumn get rate => real()();
  BoolColumn get isBillable => boolean()();
  BoolColumn get isInvoiced => boolean()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'recurring_client', columns: {#clientId})
class RecurringProfilesTbl extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text().references(ClientsTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get frequency => text()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  DateTimeColumn get nextIssueDate => dateTime()();
  RealColumn get amount => real()();
  TextColumn get description => text()();
  BoolColumn get isActive => boolean()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'stock_product', columns: {#productId})
class StockMovementsTbl extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text().references(ProductsTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get productName => text()();
  IntColumn get quantityChange => integer()();
  IntColumn get balanceAfter => integer()();
  TextColumn get type => text()();
  TextColumn get referenceNumber => text()();
  TextColumn get referenceId => text().nullable()();
  TextColumn get description => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class AppSettingsTbl extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@TableIndex(name: 'supplier_payments_po', columns: {#purchaseOrderId})
@TableIndex(name: 'supplier_payments_supplier', columns: {#supplierId})
class SupplierPaymentsTbl extends Table {
  TextColumn get id => text()();
  TextColumn get purchaseOrderId => text().references(PurchaseOrdersTbl, #id, onDelete: KeyAction.cascade)();
  TextColumn get supplierId => text().references(SuppliersTbl, #id, onDelete: KeyAction.cascade)();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get paymentMethod => text()();
  TextColumn get referenceNumber => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    ClientsTbl,
    InvoicesTbl,
    InvoiceItemsTbl,
    EstimatesTbl,
    EstimateItemsTbl,
    ExpensesTbl,
    PaymentsTbl,
    ProductsTbl,
    PurchaseOrdersTbl,
    PoItemsTbl,
    SuppliersTbl,
    TimeEntriesTbl,
    RecurringProfilesTbl,
    StockMovementsTbl,
    AppSettingsTbl,
    SupplierPaymentsTbl,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          // Add new columns to existing tables
          await m.addColumn(invoicesTbl, invoicesTbl.discountPercent);
          await m.addColumn(invoicesTbl, invoicesTbl.discountAmount);
          await m.addColumn(invoicesTbl, invoicesTbl.withholdingTaxPercent);
          await m.addColumn(invoicesTbl, invoicesTbl.withholdingTaxAmount);
          await m.addColumn(invoicesTbl, invoicesTbl.tax2Percent);

          await m.addColumn(invoiceItemsTbl, invoiceItemsTbl.discountPercent);

          await m.addColumn(estimatesTbl, estimatesTbl.discountPercent);
          await m.addColumn(estimatesTbl, estimatesTbl.discountAmount);
          await m.addColumn(estimatesTbl, estimatesTbl.withholdingTaxPercent);
          await m.addColumn(estimatesTbl, estimatesTbl.withholdingTaxAmount);
          await m.addColumn(estimatesTbl, estimatesTbl.tax2Percent);

          await m.addColumn(estimateItemsTbl, estimateItemsTbl.discountPercent);
        }
        if (from < 3) {
          // Client fields are now nullable - SQLite doesn't need migration for this
          // as text columns in SQLite are inherently nullable
        }
        if (from < 4) {
          // Add database indexes for common queries
          await customStatement('CREATE INDEX IF NOT EXISTS invoices_client_idx ON invoices_tbl (client_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS invoice_items_invoice_idx ON invoice_items_tbl (invoice_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS payments_invoice_idx ON payments_tbl (invoice_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS payments_client_idx ON payments_tbl (client_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS expenses_client_idx ON expenses_tbl (client_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS po_items_po_idx ON po_items_tbl (purchase_order_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS estimates_client_idx ON estimates_tbl (client_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS estimate_items_estimate_idx ON estimate_items_tbl (estimate_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS po_supplier_idx ON purchase_orders_tbl (supplier_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS time_entries_client_idx ON time_entries_tbl (client_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS recurring_client_idx ON recurring_profiles_tbl (client_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS stock_product_idx ON stock_movements_tbl (product_id);');
        }
        if (from < 5) {
          // Create SupplierPaymentsTbl and its indexes
          await m.createTable(supplierPaymentsTbl);
          await customStatement('CREATE INDEX IF NOT EXISTS supplier_payments_po_idx ON supplier_payments_tbl (purchase_order_id);');
          await customStatement('CREATE INDEX IF NOT EXISTS supplier_payments_supplier_idx ON supplier_payments_tbl (supplier_id);');
        }
        if (from < 6) {
          await m.addColumn(expensesTbl, expensesTbl.markupPercent);
          await m.addColumn(expensesTbl, expensesTbl.invoiceId);
        }
        if (from < 7) {
          await m.addColumn(clientsTbl, clientsTbl.contactPerson);
          await m.addColumn(clientsTbl, clientsTbl.taxNumber);
          await m.addColumn(clientsTbl, clientsTbl.paymentTermsDays);
          await m.addColumn(clientsTbl, clientsTbl.creditLimit);
        }
        if (from < 8) {
          await customStatement('ALTER TABLE recurring_profiles_tbl ADD COLUMN start_date INTEGER;');
          await customStatement('ALTER TABLE recurring_profiles_tbl ADD COLUMN end_date INTEGER;');
        }
      },
    );
  }

  Future<void> clearAll() async {
    await transaction(() async {
      // 1. Delete all child/dependent tables first
      await delete(paymentsTbl).go();
      await delete(supplierPaymentsTbl).go();
      await delete(invoiceItemsTbl).go();
      await delete(estimateItemsTbl).go();
      await delete(poItemsTbl).go();
      await delete(stockMovementsTbl).go();
      
      // 2. Delete tables that are parents of items/payments but children of clients/suppliers
      await delete(invoicesTbl).go();
      await delete(estimatesTbl).go();
      await delete(purchaseOrdersTbl).go();
      await delete(timeEntriesTbl).go();
      await delete(recurringProfilesTbl).go();
      await delete(expensesTbl).go();

      // 3. Delete top-level parents
      await delete(productsTbl).go();
      await delete(clientsTbl).go();
      await delete(suppliersTbl).go();
      await delete(appSettingsTbl).go();
    });
  }

  Future<String> exportBackup() async {
    final Map<String, dynamic> backup = {};

    backup['clients'] = (await select(clientsTbl).get()).map((e) => e.toJson()).toList();
    backup['invoices'] = (await select(invoicesTbl).get()).map((e) => e.toJson()).toList();
    backup['invoiceItems'] = (await select(invoiceItemsTbl).get()).map((e) => e.toJson()).toList();
    backup['estimates'] = (await select(estimatesTbl).get()).map((e) => e.toJson()).toList();
    backup['estimateItems'] = (await select(estimateItemsTbl).get()).map((e) => e.toJson()).toList();
    backup['expenses'] = (await select(expensesTbl).get()).map((e) => e.toJson()).toList();
    backup['payments'] = (await select(paymentsTbl).get()).map((e) => e.toJson()).toList();
    backup['products'] = (await select(productsTbl).get()).map((e) => e.toJson()).toList();
    backup['purchaseOrders'] = (await select(purchaseOrdersTbl).get()).map((e) => e.toJson()).toList();
    backup['poItems'] = (await select(poItemsTbl).get()).map((e) => e.toJson()).toList();
    backup['suppliers'] = (await select(suppliersTbl).get()).map((e) => e.toJson()).toList();
    backup['timeEntries'] = (await select(timeEntriesTbl).get()).map((e) => e.toJson()).toList();
    backup['recurringProfiles'] = (await select(recurringProfilesTbl).get()).map((e) => e.toJson()).toList();
    backup['stockMovements'] = (await select(stockMovementsTbl).get()).map((e) => e.toJson()).toList();
    backup['appSettings'] = (await select(appSettingsTbl).get()).map((e) => e.toJson()).toList();
    backup['supplierPayments'] = (await select(supplierPaymentsTbl).get()).map((e) => e.toJson()).toList();

    return jsonEncode(backup);
  }

  Future<void> importBackup(String backupJson) async {
    final Map<String, dynamic> backup = jsonDecode(backupJson);

    await transaction(() async {
      // 1. Clear database
      await clearAll();

      // 2. Insert records in dependency order (parents first, then children)
      
      // Top-level parents
      if (backup['appSettings'] != null) {
        for (final item in backup['appSettings']) {
          await into(appSettingsTbl).insert(AppSettingsTblData.fromJson(item));
        }
      }
      if (backup['clients'] != null) {
        for (final item in backup['clients']) {
          await into(clientsTbl).insert(ClientsTblData.fromJson(item));
        }
      }
      if (backup['suppliers'] != null) {
        for (final item in backup['suppliers']) {
          await into(suppliersTbl).insert(SuppliersTblData.fromJson(item));
        }
      }
      if (backup['products'] != null) {
        for (final item in backup['products']) {
          await into(productsTbl).insert(ProductsTblData.fromJson(item));
        }
      }

      // First-level children
      if (backup['invoices'] != null) {
        for (final item in backup['invoices']) {
          await into(invoicesTbl).insert(InvoicesTblData.fromJson(item));
        }
      }
      if (backup['estimates'] != null) {
        for (final item in backup['estimates']) {
          await into(estimatesTbl).insert(EstimatesTblData.fromJson(item));
        }
      }
      if (backup['purchaseOrders'] != null) {
        for (final item in backup['purchaseOrders']) {
          await into(purchaseOrdersTbl).insert(PurchaseOrdersTblData.fromJson(item));
        }
      }
      if (backup['expenses'] != null) {
        for (final item in backup['expenses']) {
          await into(expensesTbl).insert(ExpensesTblData.fromJson(item));
        }
      }
      if (backup['timeEntries'] != null) {
        for (final item in backup['timeEntries']) {
          await into(timeEntriesTbl).insert(TimeEntriesTblData.fromJson(item));
        }
      }
      if (backup['recurringProfiles'] != null) {
        for (final item in backup['recurringProfiles']) {
          await into(recurringProfilesTbl).insert(RecurringProfilesTblData.fromJson(item));
        }
      }
      if (backup['stockMovements'] != null) {
        for (final item in backup['stockMovements']) {
          await into(stockMovementsTbl).insert(StockMovementsTblData.fromJson(item));
        }
      }

      // Second-level children
      if (backup['invoiceItems'] != null) {
        for (final item in backup['invoiceItems']) {
          await into(invoiceItemsTbl).insert(InvoiceItemsTblData.fromJson(item));
        }
      }
      if (backup['estimateItems'] != null) {
        for (final item in backup['estimateItems']) {
          await into(estimateItemsTbl).insert(EstimateItemsTblData.fromJson(item));
        }
      }
      if (backup['poItems'] != null) {
        for (final item in backup['poItems']) {
          await into(poItemsTbl).insert(PoItemsTblData.fromJson(item));
        }
      }
      if (backup['payments'] != null) {
        for (final item in backup['payments']) {
          await into(paymentsTbl).insert(PaymentsTblData.fromJson(item));
        }
      }
      if (backup['supplierPayments'] != null) {
        for (final item in backup['supplierPayments']) {
          await into(supplierPaymentsTbl).insert(SupplierPaymentsTblData.fromJson(item));
        }
      }
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'invoicepro.db'));
    return NativeDatabase(
      file,
      setup: (db) {
        db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  });
}
