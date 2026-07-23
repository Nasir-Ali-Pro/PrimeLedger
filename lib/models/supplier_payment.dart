class SupplierPayment {
  final String id;
  final String purchaseOrderId;
  final String supplierId;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String? referenceNumber;
  final String? notes;
  final DateTime createdAt;

  SupplierPayment({
    required this.id,
    required this.purchaseOrderId,
    required this.supplierId,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    this.referenceNumber,
    this.notes,
    required this.createdAt,
  });

  SupplierPayment copyWith({
    String? id,
    String? purchaseOrderId,
    String? supplierId,
    double? amount,
    DateTime? date,
    String? paymentMethod,
    String? referenceNumber,
    String? notes,
    DateTime? createdAt,
  }) {
    return SupplierPayment(
      id: id ?? this.id,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      supplierId: supplierId ?? this.supplierId,
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
      'purchaseOrderId': purchaseOrderId,
      'supplierId': supplierId,
      'amount': amount,
      'date': date.toIso8601String(),
      'paymentMethod': paymentMethod,
      'referenceNumber': referenceNumber,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory SupplierPayment.fromMap(Map<String, dynamic> map) {
    return SupplierPayment(
      id: map['id'],
      purchaseOrderId: map['purchaseOrderId'],
      supplierId: map['supplierId'],
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
