class Expense {
  final String id;
  final String description;
  final double amount;
  final String category;
  final DateTime date;
  final String? clientId;
  final bool isBillable;
  final String? receiptPath;
  final String? notes;
  final DateTime createdAt;
  final double markupPercent;
  final String? invoiceId;

  Expense({
    required this.id,
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
    this.clientId,
    this.isBillable = false,
    this.receiptPath,
    this.notes,
    required this.createdAt,
    this.markupPercent = 0.0,
    this.invoiceId,
  });

  bool get isInvoiced => invoiceId != null;

  Expense copyWith({
    String? id,
    String? description,
    double? amount,
    String? category,
    DateTime? date,
    String? clientId,
    bool? isBillable,
    String? receiptPath,
    String? notes,
    DateTime? createdAt,
    double? markupPercent,
    String? invoiceId,
  }) {
    return Expense(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      clientId: clientId ?? this.clientId,
      isBillable: isBillable ?? this.isBillable,
      receiptPath: receiptPath ?? this.receiptPath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      markupPercent: markupPercent ?? this.markupPercent,
      invoiceId: invoiceId ?? this.invoiceId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'clientId': clientId,
      'isBillable': isBillable,
      'receiptPath': receiptPath,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'markupPercent': markupPercent,
      'invoiceId': invoiceId,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      description: map['description'],
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] ?? 'General',
      date: DateTime.parse(map['date']),
      clientId: map['clientId'],
      isBillable: map['isBillable'] ?? false,
      receiptPath: map['receiptPath'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
      markupPercent: (map['markupPercent'] as num?)?.toDouble() ?? 0.0,
      invoiceId: map['invoiceId'],
    );
  }

  static const List<String> categories = [
    'Office Supplies',
    'Travel',
    'Software',
    'Marketing',
    'Utilities',
    'Rent',
    'Equipment',
    'Meals',
    'Insurance',
    'Professional Services',
    'Shipping',
    'Other',
  ];
}
