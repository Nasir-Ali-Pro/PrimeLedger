class Payment {
  final String id;
  final String invoiceId;
  final String clientId;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String? referenceNumber;
  final String? notes;
  final DateTime createdAt;

  Payment({
    required this.id,
    required this.invoiceId,
    required this.clientId,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    this.referenceNumber,
    this.notes,
    required this.createdAt,
  });

  Payment copyWith({
    String? id,
    String? invoiceId,
    String? clientId,
    double? amount,
    DateTime? date,
    String? paymentMethod,
    String? referenceNumber,
    String? notes,
    DateTime? createdAt,
  }) {
    return Payment(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      clientId: clientId ?? this.clientId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoiceId': invoiceId,
      'clientId': clientId,
      'amount': amount,
      'date': date.toIso8601String(),
      'paymentMethod': paymentMethod,
      'referenceNumber': referenceNumber,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      invoiceId: map['invoiceId'],
      clientId: map['clientId'],
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date']),
      paymentMethod: map['paymentMethod'],
      referenceNumber: map['referenceNumber'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  static const List<String> methods = [
    'Cash',
    'Bank Transfer',
    'Easypaisa',
    'JazzCash',
    'Credit/Debit Card',
    'Cheque',
    'Other'
  ];
}
