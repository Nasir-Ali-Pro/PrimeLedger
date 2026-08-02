import 'package:flutter_test/flutter_test.dart';
import 'package:prime_ledger/models/ledger_entry.dart';
import 'package:prime_ledger/models/invoice.dart';
import 'package:prime_ledger/models/purchase_order.dart';
import 'package:prime_ledger/models/supplier_payment.dart';
import 'package:prime_ledger/models/payment.dart';
import 'package:prime_ledger/models/expense.dart';
import 'package:prime_ledger/providers/ledger_provider.dart';

void main() {
  group('General Ledger & Partial Payment Integration Tests', () {
    test('Calculates General Ledger progressive running balance accurately with partial payments', () {
      final date1 = DateTime(2026, 6, 1, 10, 0);
      final date2 = DateTime(2026, 6, 2, 10, 0);
      final date3 = DateTime(2026, 6, 3, 10, 0);
      final date4 = DateTime(2026, 6, 4, 10, 0);

      final invoices = [
        Invoice(
          id: 'inv-1',
          clientId: 'client-1',
          invoiceNumber: 'INV-001',
          issueDate: date1,
          dueDate: date1.add(const Duration(days: 14)),
          subTotal: 1000.0,
          taxTotal: 0.0,
          totalAmount: 1000.0,
          status: 'Partially Paid',
          createdAt: date1,
          items: [],
        ),
      ];

      final payments = [
        Payment(
          id: 'pmt-1',
          invoiceId: 'inv-1',
          clientId: 'client-1',
          amount: 400.0,
          date: date2,
          paymentMethod: 'Cash',
          createdAt: date2,
        ),
      ];

      final pos = [
        PurchaseOrder(
          id: 'po-1',
          supplierId: 'supplier-1',
          poNumber: 'PO-001',
          issueDate: date3,
          expectedDate: date3.add(const Duration(days: 7)),
          subTotal: 800.0,
          taxTotal: 0.0,
          totalAmount: 800.0,
          status: 'Partially Received',
          createdAt: date3,
          items: [],
        ),
      ];

      final supplierPayments = [
        SupplierPayment(
          id: 'sp-1',
          purchaseOrderId: 'po-1',
          supplierId: 'supplier-1',
          amount: 300.0,
          date: date4,
          paymentMethod: 'Bank Transfer',
          createdAt: date4,
        ),
      ];

      final expenses = <Expense>[];
      final estimates = [];
      final clients = [];
      final suppliers = [];

      final filter = const LedgerFilterState(sortOrder: LedgerSortOrder.oldest);

      final entries = buildLedgerEntries(
        invoices: invoices,
        payments: payments,
        expenses: expenses,
        pos: pos,
        supplierPayments: supplierPayments,
        estimates: estimates,
        clients: clients,
        suppliers: suppliers,
        filter: filter,
      );

      expect(entries.length, 4);

      // Entry 1: Invoice $1000 -> balance = $1000
      expect(entries[0].type, LedgerEntryType.invoice);
      expect(entries[0].debit, 1000.0);
      expect(entries[0].balance, 1000.0);

      // Entry 2: Payment $400 -> balance = $600
      expect(entries[1].type, LedgerEntryType.payment);
      expect(entries[1].credit, 400.0);
      expect(entries[1].balance, 600.0);

      // Entry 3: Purchase Order $800 -> Supplier balance = $800
      expect(entries[2].type, LedgerEntryType.purchaseOrder);
      expect(entries[2].credit, 800.0);
      expect(entries[2].balance, 800.0);

      // Entry 4: Supplier Partial Payment $300 -> Supplier balance = $500
      expect(entries[3].type, LedgerEntryType.supplierPayment);
      expect(entries[3].debit, 300.0);
      expect(entries[3].balance, 500.0);
    });

    test('Calculates Supplier Account Ledger balance and remaining amount owed accurately', () {
      final date1 = DateTime(2026, 6, 1, 10, 0);
      final date2 = DateTime(2026, 6, 2, 10, 0);

      final pos = [
        PurchaseOrder(
          id: 'po-100',
          supplierId: 'sup-99',
          poNumber: 'PO-100',
          issueDate: date1,
          expectedDate: date1.add(const Duration(days: 7)),
          subTotal: 1500.0,
          taxTotal: 0.0,
          totalAmount: 1500.0,
          status: 'Received',
          createdAt: date1,
          items: [],
        ),
      ];

      final supplierPayments = [
        SupplierPayment(
          id: 'sp-100',
          purchaseOrderId: 'po-100',
          supplierId: 'sup-99',
          amount: 500.0,
          date: date2,
          paymentMethod: 'Cash',
          createdAt: date2,
        ),
      ];

      final filter = const LedgerFilterState(supplierId: 'sup-99', sortOrder: LedgerSortOrder.oldest);

      final entries = buildLedgerEntries(
        invoices: [],
        payments: [],
        expenses: [],
        pos: pos,
        supplierPayments: supplierPayments,
        estimates: [],
        clients: [],
        suppliers: [],
        filter: filter,
      );

      expect(entries.length, 2);

      // PO entry: +1500 credit, running balance = 1500
      expect(entries[0].type, LedgerEntryType.purchaseOrder);
      expect(entries[0].credit, 1500.0);
      expect(entries[0].balance, 1500.0);

      // Supplier payment entry: -500 debit, running balance = 1000 (remaining owed)
      expect(entries[1].type, LedgerEntryType.supplierPayment);
      expect(entries[1].debit, 500.0);
      expect(entries[1].balance, 1000.0);
    });

    test('Excludes Draft and Cancelled Purchase Orders from Ledger', () {
      final date1 = DateTime(2026, 6, 1, 10, 0);

      final pos = [
        PurchaseOrder(
          id: 'po-draft',
          supplierId: 'sup-1',
          poNumber: 'PO-DRAFT',
          issueDate: date1,
          expectedDate: date1,
          subTotal: 500.0,
          taxTotal: 0.0,
          totalAmount: 500.0,
          status: 'Draft',
          createdAt: date1,
          items: [],
        ),
        PurchaseOrder(
          id: 'po-cancelled',
          supplierId: 'sup-1',
          poNumber: 'PO-CANCEL',
          issueDate: date1,
          expectedDate: date1,
          subTotal: 500.0,
          taxTotal: 0.0,
          totalAmount: 500.0,
          status: 'Cancelled',
          createdAt: date1,
          items: [],
        ),
      ];

      final filter = const LedgerFilterState(sortOrder: LedgerSortOrder.oldest);

      final entries = buildLedgerEntries(
        invoices: [],
        payments: [],
        expenses: [],
        pos: pos,
        supplierPayments: [],
        estimates: [],
        clients: [],
        suppliers: [],
        filter: filter,
      );

      expect(entries.isEmpty, isTrue);
    });
  });
}
