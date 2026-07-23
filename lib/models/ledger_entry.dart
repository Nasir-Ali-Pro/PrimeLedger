import 'package:flutter/material.dart';

enum LedgerEntryType {
  invoice,
  payment,
  expense,
  purchaseOrder,
  estimate,
  supplierPayment;

  String get label {
    switch (this) {
      case LedgerEntryType.invoice:
        return 'Invoice';
      case LedgerEntryType.payment:
        return 'Payment';
      case LedgerEntryType.expense:
        return 'Expense';
      case LedgerEntryType.purchaseOrder:
        return 'Purchase Order';
      case LedgerEntryType.estimate:
        return 'Estimate';
      case LedgerEntryType.supplierPayment:
        return 'Supplier Payment';
    }
  }

  IconData get icon {
    switch (this) {
      case LedgerEntryType.invoice:
        return Icons.receipt_long;
      case LedgerEntryType.payment:
        return Icons.payments;
      case LedgerEntryType.expense:
        return Icons.money_off;
      case LedgerEntryType.purchaseOrder:
        return Icons.shopping_cart;
      case LedgerEntryType.estimate:
        return Icons.request_quote;
      case LedgerEntryType.supplierPayment:
        return Icons.payment;
    }
  }

  Color get color {
    switch (this) {
      case LedgerEntryType.invoice:
        return const Color(0xFF6366F1);
      case LedgerEntryType.payment:
        return const Color(0xFF10B981);
      case LedgerEntryType.expense:
        return const Color(0xFFEF4444);
      case LedgerEntryType.purchaseOrder:
        return const Color(0xFFF59E0B);
      case LedgerEntryType.estimate:
        return const Color(0xFF8B5CF6);
      case LedgerEntryType.supplierPayment:
        return const Color(0xFFEC4899);
    }
  }
}

class LedgerEntry {
  final String id;
  final DateTime date;
  final LedgerEntryType type;
  final String referenceNumber;
  final String description;
  final String? counterpartyName;
  final String? counterpartyId;
  final double debit;
  final double credit;
  final double balance;
  final String status;

  const LedgerEntry({
    required this.id,
    required this.date,
    required this.type,
    required this.referenceNumber,
    required this.description,
    this.counterpartyName,
    this.counterpartyId,
    required this.debit,
    required this.credit,
    required this.balance,
    required this.status,
  });

  String get readableType => type.label;

  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String get dateGroup {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  int get dateGroupSort => date.year * 12 + date.month;
}
