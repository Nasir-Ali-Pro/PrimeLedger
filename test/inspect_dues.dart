import 'package:sqlite3/sqlite3.dart';

void main() {
  final dbPath = r'C:\Users\LaptopValley\.gemini\antigravity\scratch\emulator_invoicepro.db';
  final db = sqlite3.open(dbPath);
  
  print('=== PURCHASE ORDERS ===');
  final pos = db.select('SELECT po_number, issue_date, expected_date, total_amount, status FROM purchase_orders_tbl');
  for (final row in pos) {
    final issue = DateTime.fromMillisecondsSinceEpoch(row['issue_date'] * 1000);
    final expected = DateTime.fromMillisecondsSinceEpoch(row['expected_date'] * 1000);
    print('PO: ${row['po_number']}, Issue: $issue, Expected: $expected, Total: ${row['total_amount']}, Status: ${row['status']}');
  }

  print('\n=== SUPPLIER PAYMENTS ===');
  final pmts = db.select('SELECT id, purchase_order_id, amount, date FROM supplier_payments_tbl');
  for (final row in pmts) {
    final pmtDate = DateTime.fromMillisecondsSinceEpoch(row['date'] * 1000);
    print('Payment for PO ID: ${row['purchase_order_id']}, Amount: ${row['amount']}, Date: $pmtDate');
  }
  
  db.dispose();
}
