import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:prime_ledger/database/database.dart';
import 'package:prime_ledger/database/daos/purchase_order_dao.dart';
import 'package:prime_ledger/database/daos/supplier_dao.dart';
import 'package:prime_ledger/database/daos/supplier_payment_dao.dart';
import 'package:prime_ledger/models/purchase_order.dart';
import 'package:prime_ledger/models/supplier.dart';
import 'package:prime_ledger/models/supplier_payment.dart';

void main() {
  late AppDatabase db;
  late PurchaseOrderDao poDao;
  late SupplierDao supplierDao;
  late SupplierPaymentDao supplierPaymentDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory(
      setup: (database) {
        database.execute('PRAGMA foreign_keys = ON;');
      },
    ));
    poDao = PurchaseOrderDao(db);
    supplierDao = SupplierDao(db);
    supplierPaymentDao = SupplierPaymentDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Delete purchase order with items and payments', () async {
    // 1. Insert a supplier
    final supplier = Supplier(
      id: 'sup-1',
      name: 'Supplier 1',
      createdAt: DateTime.now(),
    );
    await supplierDao.insert(supplier);

    // 1b. Insert a product
    await db.into(db.productsTbl).insert(ProductsTblCompanion(
      id: const Value('prod-1'),
      name: const Value('Product 1'),
      category: const Value('Category 1'),
      costPrice: const Value(10.0),
      sellingPrice: const Value(15.0),
      quantity: const Value(10),
      reorderLevel: const Value(2),
      unit: const Value('pcs'),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    ));

    // 2. Insert a purchase order
    final po = PurchaseOrder(
      id: 'po-1',
      supplierId: 'sup-1',
      poNumber: 'PO-001',
      issueDate: DateTime.now(),
      expectedDate: DateTime.now().add(const Duration(days: 7)),
      subTotal: 100.0,
      taxTotal: 10.0,
      totalAmount: 110.0,
      status: 'Received',
      notes: 'Test PO',
      createdAt: DateTime.now(),
      items: [
        PurchaseOrderItem(
          id: 'poi-1',
          productId: 'prod-1',
          description: 'Product 1',
          quantity: 5,
          receivedQuantity: 5,
          unitPrice: 20.0,
          taxPercent: 10.0,
          taxAmount: 10.0,
          total: 110.0,
        ),
      ],
    );
    await poDao.insert(po);

    // 3. Add a supplier payment
    final payment = SupplierPayment(
      id: 'sp-1',
      purchaseOrderId: 'po-1',
      supplierId: 'sup-1',
      amount: 50.0,
      date: DateTime.now(),
      paymentMethod: 'Cash',
      createdAt: DateTime.now(),
    );
    await supplierPaymentDao.insert(payment);

    // Verify PO exists
    var fetchedPo = await poDao.getById('po-1');
    expect(fetchedPo, isNotNull);
    expect(fetchedPo!.items.length, 1);

    // Verify payment exists
    final payments = await supplierPaymentDao.getByPurchaseOrderId('po-1');
    expect(payments.length, 1);

    // 4. Delete the PO
    print('Attempting to delete PO...');
    await poDao.delete('po-1');
    print('PO deleted successfully!');

    // Verify PO is gone
    fetchedPo = await poDao.getById('po-1');
    expect(fetchedPo, isNull);

    // Verify payment is also deleted (cascade)
    final paymentsAfterDelete = await supplierPaymentDao.getByPurchaseOrderId('po-1');
    expect(paymentsAfterDelete.length, 0);
  });
}
