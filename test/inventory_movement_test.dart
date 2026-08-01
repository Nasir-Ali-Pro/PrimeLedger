import 'package:flutter_test/flutter_test.dart';
import 'package:prime_ledger/models/product.dart';
import 'package:prime_ledger/models/stock_movement.dart';

void main() {
  group('Inventory Stock & Movement Unit Tests', () {
    test('Calculates stock quantity additions and deductions correctly', () {
      final product = Product(
        id: 'prod-10',
        name: 'Wireless Mouse',
        category: 'Electronics',
        costPrice: 15.0,
        sellingPrice: 25.0,
        quantity: 50,
        reorderLevel: 10,
        unit: 'pcs',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(product.isLowStock, isFalse);

      // Sale movement (-5 units)
      final saleMovement = StockMovement(
        id: 'sm-1',
        productId: product.id,
        productName: product.name,
        quantityChange: -5,
        balanceAfter: 45,
        type: 'sale',
        referenceId: 'inv-1',
        description: 'Sold via Invoice INV-001',
        createdAt: DateTime.now(),
      );

      final updatedQtyAfterSale = product.quantity + saleMovement.quantityChange;
      expect(updatedQtyAfterSale, 45);

      // Restock movement (+20 units)
      final restockMovement = StockMovement(
        id: 'sm-2',
        productId: product.id,
        productName: product.name,
        quantityChange: 20,
        balanceAfter: 65,
        type: 'purchase',
        referenceId: 'po-1',
        description: 'Received via Purchase Order PO-001',
        createdAt: DateTime.now(),
      );

      final updatedQtyAfterRestock = updatedQtyAfterSale + restockMovement.quantityChange;
      expect(updatedQtyAfterRestock, 65);
    });

    test('Triggers low stock alert when quantity drops below reorder level', () {
      final product = Product(
        id: 'prod-low',
        name: 'Keyboard',
        category: 'Electronics',
        costPrice: 20.0,
        sellingPrice: 35.0,
        quantity: 3,
        reorderLevel: 5,
        unit: 'pcs',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(product.isLowStock, isTrue);
    });
  });
}
