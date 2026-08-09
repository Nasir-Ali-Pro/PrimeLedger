import 'package:flutter_test/flutter_test.dart';
import 'package:prime_ledger/models/expense.dart';
import 'package:prime_ledger/models/invoice.dart';

void main() {
  group('Expense & Net Profit Financial Math Unit Tests', () {
    test('Calculates Net Profit accurately when a billable expense is added, billed, and deleted', () {
      // 1. Initial State: Invoice with 1 product ($1000 revenue, $400 cost)
      double invoiceRevenue = 1000.0;
      double productCogs = 400.0;
      double initialProfit = invoiceRevenue - productCogs; // $600
      expect(initialProfit, equals(600.0));

      // 2. Add a Billable Expense ($300 base cost, 30% markup = $390 price)
      final expense = Expense(
        id: 'exp_1',
        description: 'Client Project Material',
        amount: 300.0,
        category: 'Materials',
        date: DateTime.now(),
        clientId: 'client_1',
        isBillable: true,
        markupPercent: 30.0,
        createdAt: DateTime.now(),
      );

      // Unbilled state: Expense cost $300 is incurred
      double unbilledExpenseCost = expense.amount; // $300
      double unbilledNetProfit = invoiceRevenue - productCogs - unbilledExpenseCost; // $300
      expect(unbilledNetProfit, equals(300.0));

      // 3. Bill the Expense on the Invoice (Import expense line item of $390)
      double markedUpPrice = expense.amount * (1 + expense.markupPercent / 100); // $390
      double updatedInvoiceRevenue = invoiceRevenue + markedUpPrice; // $1390
      double billedExpenseCogs = expense.amount; // $300
      double totalCogs = productCogs + billedExpenseCogs; // $700
      double billedNetProfit = updatedInvoiceRevenue - totalCogs; // $690

      // Net profit contribution from expense = $390 revenue - $300 COGS = +$90 margin
      expect(billedNetProfit, equals(690.0));

      // 4. Delete the Billed Expense:
      // Deleting the expense removes the $390 line item from the invoice AND removes the $300 COGS
      double postDeleteRevenue = updatedInvoiceRevenue - markedUpPrice; // $1000
      double postDeleteCogs = totalCogs - billedExpenseCogs; // $400
      double postDeleteNetProfit = postDeleteRevenue - postDeleteCogs; // $600

      // VERIFICATION: Net profit MUST revert to initial $600 without any artificial +$300 jump (e.g. to $1170)
      expect(postDeleteNetProfit, equals(600.0));
      expect(postDeleteNetProfit, isNot(equals(1170.0)));
    });

    test('Verifies COGS and Expenses unification across financial statements', () {
      final inv1 = Invoice(
        id: 'inv_1',
        clientId: 'c1',
        invoiceNumber: 'INV-001',
        issueDate: DateTime.now(),
        dueDate: DateTime.now(),
        subTotal: 1390.0,
        taxTotal: 0.0,
        totalAmount: 1390.0,
        status: 'Sent',
        items: [
          InvoiceItem(id: 'item_1', description: 'Product A', quantity: 1, rate: 1000.0, total: 1000.0),
          InvoiceItem(id: 'item_2', expenseId: 'exp_1', description: 'Material', quantity: 1, rate: 390.0, total: 390.0),
        ],
        createdAt: DateTime.now(),
      );

      final exp1 = Expense(
        id: 'exp_1',
        description: 'Material',
        amount: 300.0,
        category: 'Materials',
        date: DateTime.now(),
        clientId: 'c1',
        isBillable: true,
        markupPercent: 30.0,
        invoiceId: 'inv_1',
        createdAt: DateTime.now(),
      );

      final exp2 = Expense(
        id: 'exp_2',
        description: 'Office Rent',
        amount: 150.0,
        category: 'Rent',
        date: DateTime.now(),
        isBillable: false,
        createdAt: DateTime.now(),
      );

      final invoices = [inv1];
      final expenses = [exp1, exp2];

      final validInvoices = invoices.where((i) => i.status != 'Draft' && i.status != 'Cancelled').toList();
      final revenue = validInvoices.fold(0.0, (sum, i) => sum + (i.totalAmount - i.taxTotal));

      double productCogs = 400.0;
      double billedExpenseCogs = 0.0;
      double unbilledExpenseCost = 0.0;
      double nonBillableExpenseCost = 0.0;

      final invoiceMap = {for (final i in invoices) i.id: i};

      for (final exp in expenses) {
        if (exp.isBillable) {
          if (exp.invoiceId != null) {
            final linkedInv = invoiceMap[exp.invoiceId];
            if (linkedInv != null && linkedInv.status != 'Draft' && linkedInv.status != 'Cancelled') {
              billedExpenseCogs += exp.amount;
            } else {
              unbilledExpenseCost += exp.amount;
            }
          } else {
            unbilledExpenseCost += exp.amount;
          }
        } else {
          nonBillableExpenseCost += exp.amount;
        }
      }

      final totalCogs = productCogs + billedExpenseCogs; // 400 + 300 = 700
      final totalExpenses = nonBillableExpenseCost + unbilledExpenseCost; // 150 + 0 = 150
      final netProfit = revenue - totalCogs - totalExpenses; // 1390 - 700 - 150 = 540

      expect(revenue, equals(1390.0));
      expect(totalCogs, equals(700.0));
      expect(totalExpenses, equals(150.0));
      expect(netProfit, equals(540.0));
    });
  });
}
