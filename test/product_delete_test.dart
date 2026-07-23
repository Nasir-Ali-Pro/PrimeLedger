import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:prime_ledger/database/database.dart';
import 'package:prime_ledger/database/daos/product_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late ProductDao productDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory(
      setup: (db) => db.execute('PRAGMA foreign_keys = ON;'),
    ));
    productDao = ProductDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Delete product with stock movements', () async {
    // 1. Insert a product
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

    // 2. Insert a stock movement
    await db.into(db.stockMovementsTbl).insert(StockMovementsTblCompanion(
      id: Value(const Uuid().v4()),
      productId: const Value('prod-1'),
      productName: const Value('Product 1'),
      quantityChange: const Value(10),
      balanceAfter: const Value(10),
      type: const Value('Adjustment'),
      referenceNumber: const Value(''),
      description: const Value('Manual stock increase'),
      createdAt: Value(DateTime.now()),
    ));

    // Verify product exists
    var fetchedProduct = await productDao.getById('prod-1');
    expect(fetchedProduct, isNotNull);

    // Verify stock movement exists
    final movements = await (db.select(db.stockMovementsTbl)..where((t) => t.productId.equals('prod-1'))).get();
    expect(movements.length, 1);

    // 3. Delete the product
    print('Attempting to delete product...');
    await productDao.delete('prod-1');
    print('Product deleted successfully!');

    // Verify product is gone
    fetchedProduct = await productDao.getById('prod-1');
    expect(fetchedProduct, isNull);

    // Verify stock movements are deleted
    final movementsAfterDelete = await (db.select(db.stockMovementsTbl)..where((t) => t.productId.equals('prod-1'))).get();
    expect(movementsAfterDelete.length, 0);
  });
}
