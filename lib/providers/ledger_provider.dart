import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ledger_entry.dart';
import 'invoice_provider.dart';
import 'payment_provider.dart';
import 'expense_provider.dart';
import 'purchase_order_provider.dart';
import 'estimate_provider.dart';
import 'client_provider.dart';
import 'supplier_provider.dart';
import 'supplier_payment_provider.dart';
import '../models/payment.dart';
import '../models/supplier_payment.dart';

enum LedgerSortOrder {
  recent,
  oldest,
  amountHigh,
  amountLow,
}

class LedgerFilterState {
  final DateTime? startDate;
  final DateTime? endDate;
  final LedgerEntryType? typeFilter;
  final String searchQuery;
  final String? clientId;
  final String? supplierId;
  final LedgerSortOrder sortOrder;

  const LedgerFilterState({
    this.startDate,
    this.endDate,
    this.typeFilter,
    this.searchQuery = '',
    this.clientId,
    this.supplierId,
    this.sortOrder = LedgerSortOrder.recent,
  });

  LedgerFilterState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    LedgerEntryType? typeFilter,
    String? searchQuery,
    String? clientId,
    String? supplierId,
    LedgerSortOrder? sortOrder,
    bool clearStartDate = false,
    bool clearEndDate = false,
    bool clearTypeFilter = false,
    bool clearClientId = false,
    bool clearSupplierId = false,
  }) {
    return LedgerFilterState(
      startDate: clearStartDate ? null : (startDate ?? this.startDate),
      endDate: clearEndDate ? null : (endDate ?? this.endDate),
      typeFilter: clearTypeFilter ? null : (typeFilter ?? this.typeFilter),
      searchQuery: searchQuery ?? this.searchQuery,
      clientId: clearClientId ? null : (clientId ?? this.clientId),
      supplierId: clearSupplierId ? null : (supplierId ?? this.supplierId),
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

final ledgerFilterProvider = NotifierProvider<LedgerFilterNotifier, LedgerFilterState>(() {
  return LedgerFilterNotifier();
});

class LedgerFilterNotifier extends Notifier<LedgerFilterState> {
  @override
  LedgerFilterState build() => const LedgerFilterState();

  void setDateRange(DateTime? start, DateTime? end) {
    state = state.copyWith(startDate: start, endDate: end);
  }

  void setTypeFilter(LedgerEntryType? type) {
    state = state.copyWith(typeFilter: type, clearTypeFilter: type == null);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setClientFilter(String? clientId) {
    state = state.copyWith(
      clientId: clientId,
      clearClientId: clientId == null,
      clearSupplierId: true,
    );
  }

  void setSupplierFilter(String? supplierId) {
    state = state.copyWith(
      supplierId: supplierId,
      clearSupplierId: supplierId == null,
      clearClientId: true,
    );
  }

  void setSortOrder(LedgerSortOrder order) {
    state = state.copyWith(sortOrder: order);
  }

  void clearFilters() {
    state = const LedgerFilterState();
  }
}

final ledgerProvider = Provider<List<LedgerEntry>>((ref) {
  final invoices = ref.watch(invoicesProvider);
  final payments = ref.watch(paymentsProvider);
  final expenses = ref.watch(expensesProvider);
  final pos = ref.watch(purchaseOrdersProvider);
  final estimates = ref.watch(estimatesProvider);
  final clients = ref.watch(clientsProvider);
  final suppliers = ref.watch(suppliersProvider);
  final filter = ref.watch(ledgerFilterProvider);
  final supplierPayments = ref.watch(supplierPaymentsProvider);

  return buildLedgerEntries(
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
});

List<LedgerEntry> buildLedgerEntries({
  required List<dynamic> invoices,
  required List<dynamic> payments,
  required List<dynamic> expenses,
  required List<dynamic> pos,
  required List<dynamic> supplierPayments,
  required List<dynamic> estimates,
  required List<dynamic> clients,
  required List<dynamic> suppliers,
  required LedgerFilterState filter,
}) {
  final clientMap = {for (final c in clients) c.id: c.name};
  final supplierMap = {for (final s in suppliers) s.id: s.name};
  final invoiceMap = {for (final i in invoices) i.id: i};
  final poMap = {for (final po in pos) po.id: po};

  final paymentsByInvoice = <String, List<dynamic>>{};
  for (final p in payments) {
    paymentsByInvoice.putIfAbsent(p.invoiceId, () => []).add(p);
  }

  final supplierPaymentsByPo = <String, List<dynamic>>{};
  for (final sp in supplierPayments) {
    supplierPaymentsByPo.putIfAbsent(sp.purchaseOrderId, () => []).add(sp);
  }

  var entries = <LedgerEntry>[];

  String safeId(String id) => id.length >= 6 ? id.substring(0, 6) : id;

  for (final inv in invoices) {
    if (inv.status == 'Draft' || inv.status == 'Cancelled') continue;
    entries.add(LedgerEntry(
      id: 'inv_${inv.id}',
      date: inv.issueDate,
      type: LedgerEntryType.invoice,
      referenceNumber: inv.invoiceNumber,
      description: 'Invoice issued',
      counterpartyName: clientMap[inv.clientId] ?? 'Client #${safeId(inv.clientId)}',
      counterpartyId: inv.clientId,
      debit: inv.totalAmount,
      credit: 0,
      balance: 0,
      status: inv.status,
    ));
  }

  for (final pmt in payments) {
    final inv = invoiceMap[pmt.invoiceId];
    String pmtStatus = 'Completed';
    if (inv != null) {
      final invPayments = paymentsByInvoice[inv.id] ?? [];
      final totalPaid = invPayments.fold(0.0, (sum, p) => sum + p.amount);
      if (totalPaid < inv.totalAmount - 0.01) {
        pmtStatus = 'Partial';
      }
    }
    entries.add(LedgerEntry(
      id: 'pmt_${pmt.id}',
      date: pmt.date,
      type: LedgerEntryType.payment,
      referenceNumber: pmt.referenceNumber ?? 'PAY-${safeId(pmt.id)}',
      description: 'Payment received via ${pmt.paymentMethod}',
      counterpartyName: clientMap[pmt.clientId] ?? 'Client #${safeId(pmt.clientId)}',
      counterpartyId: pmt.clientId,
      debit: 0,
      credit: pmt.amount,
      balance: 0,
      status: pmtStatus,
    ));
  }

  for (final exp in expenses) {
    if (exp.isBillable) {
      bool isBilled = false;
      if (exp.invoiceId != null) {
        final linkedInv = invoiceMap[exp.invoiceId];
        if (linkedInv != null) {
          isBilled = linkedInv.status != 'Draft' && linkedInv.status != 'Cancelled';
        }
      }
      if (isBilled) continue;
    }

    final isClientExpense = exp.isBillable && exp.clientId != null;
    final amt = exp.isBillable 
        ? exp.amount * (1 + exp.markupPercent / 100) 
        : exp.amount;

    entries.add(LedgerEntry(
      id: 'exp_${exp.id}',
      date: exp.date,
      type: LedgerEntryType.expense,
      referenceNumber: 'EXP-${safeId(exp.id)}',
      description: exp.isBillable && exp.markupPercent > 0
          ? '${exp.description} (${exp.category}) + ${exp.markupPercent.toStringAsFixed(0)}% markup'
          : '${exp.description} (${exp.category})',
      counterpartyName: null,
      counterpartyId: exp.isBillable ? exp.clientId : null,
      debit: isClientExpense ? amt : 0,
      credit: isClientExpense ? 0 : amt,
      balance: 0,
      status: exp.isBillable ? 'Unbilled' : 'Paid',
    ));
  }

  for (final po in pos) {
    if (po.status == 'Draft' || po.status == 'Cancelled') continue;
    entries.add(LedgerEntry(
      id: 'po_${po.id}',
      date: po.issueDate,
      type: LedgerEntryType.purchaseOrder,
      referenceNumber: po.poNumber,
      description: 'Purchase order ${po.status == 'Received' ? 'received' : 'issued'}',
      counterpartyName: supplierMap[po.supplierId] ?? 'Supplier #${safeId(po.supplierId)}',
      counterpartyId: po.supplierId,
      debit: 0,
      credit: po.totalAmount,
      balance: 0,
      status: po.status,
    ));
  }

  for (final sp in supplierPayments) {
    final po = poMap[sp.purchaseOrderId];
    String spStatus = 'Completed';
    if (po != null) {
      final poPayments = supplierPaymentsByPo[po.id] ?? [];
      final totalPaid = poPayments.fold(0.0, (sum, p) => sum + p.amount);
      if (totalPaid < po.totalAmount - 0.01) {
        spStatus = 'Partial';
      }
    }
    entries.add(LedgerEntry(
      id: 'sp_${sp.id}',
      date: sp.date,
      type: LedgerEntryType.supplierPayment,
      referenceNumber: sp.referenceNumber ?? 'SP-${safeId(sp.id)}',
      description: 'Payment to supplier via ${sp.paymentMethod}',
      counterpartyName: supplierMap[sp.supplierId] ?? 'Supplier #${safeId(sp.supplierId)}',
      counterpartyId: sp.supplierId,
      debit: sp.amount,
      credit: 0,
      balance: 0,
      status: spStatus,
    ));
  }

  for (final est in estimates) {
    if (est.status == 'Draft' || est.status == 'Cancelled') continue;
    entries.add(LedgerEntry(
      id: 'est_${est.id}',
      date: est.issueDate,
      type: LedgerEntryType.estimate,
      referenceNumber: est.estimateNumber,
      description: 'Estimate ${est.status == 'Converted' ? 'converted to invoice' : 'sent to client'}',
      counterpartyName: clientMap[est.clientId] ?? 'Client #${safeId(est.clientId)}',
      counterpartyId: est.clientId,
      debit: est.totalAmount,
      credit: 0,
      balance: 0,
      status: est.status,
    ));
  }

  // Apply client and supplier account filtering
  if (filter.clientId != null) {
    entries = entries.where((e) => e.counterpartyId == filter.clientId).toList();
  } else if (filter.supplierId != null) {
    entries = entries.where((e) => e.counterpartyId == filter.supplierId).toList();
  }

  entries.sort((a, b) => a.date.compareTo(b.date));

  double running = 0;
  for (int i = 0; i < entries.length; i++) {
    final entry = entries[i];
    if (filter.clientId != null) {
      // Client ledger: Invoices and billable expenses increase what they owe us, Payments decrease it
      if (entry.type == LedgerEntryType.invoice) {
        running += entry.debit;
      } else if (entry.type == LedgerEntryType.payment) {
        running -= entry.credit;
      } else if (entry.type == LedgerEntryType.expense) {
        running += entry.debit;
      }
    } else if (filter.supplierId != null) {
      // Supplier ledger: PO increases what we owe them (credit), Supplier Payment decreases it (debit)
      if (entry.type == LedgerEntryType.purchaseOrder) {
        running += entry.credit;
      } else if (entry.type == LedgerEntryType.supplierPayment) {
        running -= entry.debit;
      }
    } else {
      // General Ledger (progressive running balance)
      if (entry.type != LedgerEntryType.estimate) {
        if (entry.type == LedgerEntryType.purchaseOrder) {
          running += entry.credit;
        } else if (entry.type == LedgerEntryType.supplierPayment) {
          running -= entry.debit;
        } else {
          running += entry.debit - entry.credit;
        }
      }
    }

    entries[i] = LedgerEntry(
      id: entry.id,
      date: entry.date,
      type: entry.type,
      referenceNumber: entry.referenceNumber,
      description: entry.description,
      counterpartyName: entry.counterpartyName,
      counterpartyId: entry.counterpartyId,
      debit: entry.debit,
      credit: entry.credit,
      balance: running,
      status: entry.status,
    );
  }

  if (filter.sortOrder == LedgerSortOrder.recent) {
    entries.sort((a, b) => b.date.compareTo(a.date));
  } else if (filter.sortOrder == LedgerSortOrder.oldest) {
    entries.sort((a, b) => a.date.compareTo(b.date));
  } else if (filter.sortOrder == LedgerSortOrder.amountHigh) {
    entries.sort((a, b) {
      final valA = a.debit > 0 ? a.debit : a.credit;
      final valB = b.debit > 0 ? b.debit : b.credit;
      return valB.compareTo(valA);
    });
  } else if (filter.sortOrder == LedgerSortOrder.amountLow) {
    entries.sort((a, b) {
      final valA = a.debit > 0 ? a.debit : a.credit;
      final valB = b.debit > 0 ? b.debit : b.credit;
      return valA.compareTo(valB);
    });
  }

  var filtered = entries;

  if (filter.startDate != null) {
    filtered = filtered.where((e) => e.date.isAfter(filter.startDate!.subtract(const Duration(days: 1)))).toList();
  }
  if (filter.endDate != null) {
    filtered = filtered.where((e) => e.date.isBefore(filter.endDate!.add(const Duration(days: 1)))).toList();
  }
  if (filter.typeFilter != null) {
    filtered = filtered.where((e) => e.type == filter.typeFilter).toList();
  }
  if (filter.searchQuery.isNotEmpty) {
    final q = filter.searchQuery.toLowerCase();
    filtered = filtered.where((e) =>
      e.referenceNumber.toLowerCase().contains(q) ||
      e.description.toLowerCase().contains(q) ||
      (e.counterpartyName?.toLowerCase().contains(q) ?? false)
    ).toList();
  }

  return filtered;
}
