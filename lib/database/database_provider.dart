import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database.dart';
import 'daos/client_dao.dart';
import 'daos/invoice_dao.dart';
import 'daos/estimate_dao.dart';
import 'daos/expense_dao.dart';
import 'daos/payment_dao.dart';
import 'daos/product_dao.dart';
import 'daos/purchase_order_dao.dart';
import 'daos/supplier_dao.dart';
import 'daos/time_entry_dao.dart';
import 'daos/recurring_profile_dao.dart';
import 'daos/settings_dao.dart';
import 'daos/stock_movement_dao.dart';
import 'daos/supplier_payment_dao.dart';

import '../services/secure_storage_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final clientDaoProvider = Provider<ClientDao>((ref) => ClientDao(ref.watch(databaseProvider)));
final invoiceDaoProvider = Provider<InvoiceDao>((ref) => InvoiceDao(ref.watch(databaseProvider)));
final estimateDaoProvider = Provider<EstimateDao>((ref) => EstimateDao(ref.watch(databaseProvider)));
final expenseDaoProvider = Provider<ExpenseDao>((ref) => ExpenseDao(ref.watch(databaseProvider)));
final paymentDaoProvider = Provider<PaymentDao>((ref) => PaymentDao(ref.watch(databaseProvider)));
final productDaoProvider = Provider<ProductDao>((ref) => ProductDao(ref.watch(databaseProvider)));
final purchaseOrderDaoProvider = Provider<PurchaseOrderDao>((ref) => PurchaseOrderDao(ref.watch(databaseProvider)));
final supplierDaoProvider = Provider<SupplierDao>((ref) => SupplierDao(ref.watch(databaseProvider)));
final timeEntryDaoProvider = Provider<TimeEntryDao>((ref) => TimeEntryDao(ref.watch(databaseProvider)));
final recurringProfileDaoProvider = Provider<RecurringProfileDao>((ref) => RecurringProfileDao(ref.watch(databaseProvider)));
final settingsDaoProvider = Provider<SettingsDao>((ref) => SettingsDao(
  ref.watch(databaseProvider),
  ref.watch(secureStorageServiceProvider),
));
final stockMovementDaoProvider = Provider<StockMovementDao>((ref) => StockMovementDao(ref.watch(databaseProvider)));
final supplierPaymentDaoProvider = Provider<SupplierPaymentDao>((ref) => SupplierPaymentDao(ref.watch(databaseProvider)));
