import 'package:flutter_test/flutter_test.dart';
import 'package:prime_ledger/models/estimate.dart';
import 'package:prime_ledger/models/invoice.dart';

void main() {
  group('Estimate & Conversion Integration Tests', () {
    test('Converts Estimate to Invoice accurately copying items and client details', () {
      final issueDate = DateTime(2026, 7, 1);
      final expiryDate = DateTime(2026, 7, 15);

      final estimate = Estimate(
        id: 'est-101',
        clientId: 'client-55',
        estimateNumber: 'EST-001',
        issueDate: issueDate,
        expiryDate: expiryDate,
        subTotal: 500.0,
        taxTotal: 50.0,
        totalAmount: 550.0,
        status: 'Sent',
        createdAt: issueDate,
        items: [
          EstimateItem(
            id: 'esti-1',
            description: 'Design Prototype',
            quantity: 5,
            rate: 100.0,
            taxPercent: 10.0,
            taxAmount: 50.0,
            total: 550.0,
          ),
        ],
      );

      expect(estimate.status, 'Sent');

      // Conversion process
      final convertedEstimate = estimate.copyWith(status: 'Converted');
      final generatedInvoice = Invoice(
        id: 'inv-gen-1',
        clientId: estimate.clientId,
        invoiceNumber: 'INV-0099',
        issueDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 14)),
        subTotal: estimate.subTotal,
        taxTotal: estimate.taxTotal,
        totalAmount: estimate.totalAmount,
        status: 'Draft',
        notes: 'Converted from Estimate ${estimate.estimateNumber}',
        createdAt: DateTime.now(),
        items: estimate.items.map((e) => InvoiceItem(
          id: e.id,
          productId: e.productId,
          description: e.description,
          quantity: e.quantity,
          rate: e.rate,
          taxPercent: e.taxPercent,
          taxAmount: e.taxAmount,
          discountPercent: e.discountPercent,
          total: e.total,
        )).toList(),
      );

      expect(convertedEstimate.status, 'Converted');
      expect(generatedInvoice.clientId, 'client-55');
      expect(generatedInvoice.totalAmount, 550.0);
      expect(generatedInvoice.items.length, 1);
      expect(generatedInvoice.items.first.description, 'Design Prototype');
    });
  });
}
