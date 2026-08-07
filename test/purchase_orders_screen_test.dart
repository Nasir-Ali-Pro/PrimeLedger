import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:prime_ledger/database/database.dart';
import 'package:prime_ledger/database/database_provider.dart';
import 'package:prime_ledger/screens/purchase_orders_screen.dart';

void main() {
  testWidgets('Delete purchase order from screen', (WidgetTester tester) async {
    final testDb = AppDatabase(NativeDatabase.memory(
      setup: (db) => db.execute('PRAGMA foreign_keys = ON;'),
    ));

    // 1. Insert seed data
    await testDb.into(testDb.suppliersTbl).insert(SuppliersTblCompanion.insert(
      id: 'sup-1',
      name: 'Test Supplier',
      createdAt: DateTime.now(),
    ));

    await testDb.into(testDb.purchaseOrdersTbl).insert(PurchaseOrdersTblCompanion.insert(
      id: 'po-1',
      supplierId: 'sup-1',
      poNumber: 'PO-1001',
      issueDate: DateTime.now(),
      expectedDate: DateTime.now().add(const Duration(days: 7)),
      subTotal: 100.0,
      taxTotal: 10.0,
      totalAmount: 110.0,
      status: 'Pending',
      createdAt: DateTime.now(),
    ));

    await testDb.into(testDb.poItemsTbl).insert(PoItemsTblCompanion.insert(
      id: 'poi-1',
      purchaseOrderId: 'po-1',
      description: 'Item 1',
      quantity: 5,
      receivedQty: 0,
      unitPrice: 20.0,
      taxPercent: 10.0,
      taxAmount: 10.0,
      total: 110.0,
    ));

    // 2. Build the screen
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(testDb),
        ],
        child: const MaterialApp(
          home: PurchaseOrdersScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify PO is displayed
    expect(find.text('PO-1001'), findsOneWidget);

    // 3. Tap the directly visible delete button
    print('Tapping delete action...');
    final deleteButton = find.byIcon(Icons.delete_outline);
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // Verify confirmation dialog is shown
    expect(find.text('Confirm Delete'), findsOneWidget);

    // Tap confirm delete
    print('Tapping confirm...');
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpAndSettle();

    // Verify PO is removed from the screen
    print('Verifying PO is removed from screen...');
    expect(find.text('PO-1001'), findsNothing);

    // Verify PO is removed from database
    final poInDb = await (testDb.select(testDb.purchaseOrdersTbl)
      ..where((t) => t.id.equals('po-1'))
    ).getSingleOrNull();
    expect(poInDb, isNull);

    await testDb.close();
  });
}
