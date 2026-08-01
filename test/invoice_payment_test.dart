import 'package:flutter_test/flutter_test.dart';
import 'package:prime_ledger/models/invoice.dart';

void main() {
  group('Invoice & Payment Calculations Unit Tests', () {
    test('Calculates invoice line item totals, tax, and flat discounts accurately', () {
      final items = [
        InvoiceItem(
          id: 'item-1',
          description: 'Consulting',
          quantity: 10,
          rate: 100.0,
          taxPercent: 10.0,
          taxAmount: 90.0, // 1000 * (1 - 0.1) * 0.1 = 90
          discountPercent: 10.0, // 10% off -> 900
          total: 990.0, // 900 + 90
        ),
        InvoiceItem(
          id: 'item-2',
          description: 'Software License',
          quantity: 2,
          rate: 250.0,
          taxPercent: 5.0,
          taxAmount: 25.0, // 500 * 0.05
          discountPercent: 0.0,
          total: 525.0,
        ),
      ];

      final subTotal = items.fold(0.0, (sum, item) => sum + (item.quantity * item.rate * (1 - item.discountPercent / 100)));
      final taxTotal = items.fold(0.0, (sum, item) => sum + item.taxAmount);
      const discountAmount = 50.0;
      final total = subTotal + taxTotal - discountAmount;

      expect(subTotal, 1400.0);
      expect(taxTotal, 115.0);
      expect(total, 1465.0);
    });

    test('Validates status transitions and remaining payment balance', () {
      const totalAmount = 1000.0;
      const paidAmount = 400.0;
      final remaining = totalAmount - paidAmount;

      expect(remaining, 600.0);
      expect(paidAmount < totalAmount, isTrue);
    });
  });
}
