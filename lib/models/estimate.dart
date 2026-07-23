import 'dart:convert';

class EstimateItem {
  final String id;
  final String? productId;
  final String description;
  final int quantity;
  final double rate;
  final double taxPercent;
  final double taxAmount;
  final double discountPercent;
  final double total;

  EstimateItem({
    this.id = '',
    this.productId,
    required this.description,
    required this.quantity,
    required this.rate,
    this.taxPercent = 0,
    this.taxAmount = 0,
    this.discountPercent = 0,
    required this.total,
  });

  EstimateItem copyWith({
    String? id,
    String? productId,
    String? description,
    int? quantity,
    double? rate,
    double? taxPercent,
    double? taxAmount,
    double? discountPercent,
    double? total,
  }) {
    return EstimateItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      taxPercent: taxPercent ?? this.taxPercent,
      taxAmount: taxAmount ?? this.taxAmount,
      discountPercent: discountPercent ?? this.discountPercent,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'description': description,
      'quantity': quantity,
      'rate': rate,
      'taxPercent': taxPercent,
      'taxAmount': taxAmount,
      'discountPercent': discountPercent,
      'total': total,
    };
  }

  factory EstimateItem.fromMap(Map<String, dynamic> map) {
    return EstimateItem(
      id: map['id'] ?? '',
      productId: map['productId'],
      description: map['description'] ?? '',
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      rate: (map['rate'] as num?)?.toDouble() ?? 0.0,
      taxPercent: (map['taxPercent'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (map['taxAmount'] as num?)?.toDouble() ?? 0.0,
      discountPercent: (map['discountPercent'] as num?)?.toDouble() ?? 0.0,
      total: (map['total'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Estimate {
  final String id;
  final String clientId;
  final String estimateNumber;
  final DateTime issueDate;
  final DateTime expiryDate;
  final double subTotal;
  final double taxTotal;
  final double totalAmount;
  final String status;
  final List<EstimateItem> items;
  final String? notes;
  final DateTime createdAt;
  final double discountPercent;
  final double discountAmount;
  final double withholdingTaxPercent;
  final double withholdingTaxAmount;
  final double tax2Percent;

  Estimate({
    required this.id,
    required this.clientId,
    required this.estimateNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.subTotal,
    required this.taxTotal,
    required this.totalAmount,
    required this.status,
    required this.items,
    this.notes,
    DateTime? createdAt,
    this.discountPercent = 0,
    this.discountAmount = 0,
    this.withholdingTaxPercent = 0,
    this.withholdingTaxAmount = 0,
    this.tax2Percent = 0,
  }) : createdAt = createdAt ?? DateTime.now();

  Estimate copyWith({
    String? id,
    String? clientId,
    String? estimateNumber,
    DateTime? issueDate,
    DateTime? expiryDate,
    double? subTotal,
    double? taxTotal,
    double? totalAmount,
    String? status,
    List<EstimateItem>? items,
    String? notes,
    DateTime? createdAt,
    double? discountPercent,
    double? discountAmount,
    double? withholdingTaxPercent,
    double? withholdingTaxAmount,
    double? tax2Percent,
  }) {
    return Estimate(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      estimateNumber: estimateNumber ?? this.estimateNumber,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      subTotal: subTotal ?? this.subTotal,
      taxTotal: taxTotal ?? this.taxTotal,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      items: items ?? this.items,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
      withholdingTaxPercent: withholdingTaxPercent ?? this.withholdingTaxPercent,
      withholdingTaxAmount: withholdingTaxAmount ?? this.withholdingTaxAmount,
      tax2Percent: tax2Percent ?? this.tax2Percent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'estimateNumber': estimateNumber,
      'issueDate': issueDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'subTotal': subTotal,
      'taxTotal': taxTotal,
      'totalAmount': totalAmount,
      'status': status,
      'items': jsonEncode(items.map((e) => e.toMap()).toList()),
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'discountPercent': discountPercent,
      'discountAmount': discountAmount,
      'withholdingTaxPercent': withholdingTaxPercent,
      'withholdingTaxAmount': withholdingTaxAmount,
      'tax2Percent': tax2Percent,
    };
  }

  factory Estimate.fromMap(Map<String, dynamic> map) {
    List<dynamic> itemsList = map['items'] is String ? jsonDecode(map['items']) : (map['items'] as List<dynamic>? ?? []);
    return Estimate(
      id: map['id'],
      clientId: map['clientId'],
      estimateNumber: map['estimateNumber'],
      issueDate: DateTime.parse(map['issueDate']),
      expiryDate: DateTime.parse(map['expiryDate']),
      subTotal: (map['subTotal'] as num).toDouble(),
      taxTotal: (map['taxTotal'] as num).toDouble(),
      totalAmount: (map['totalAmount'] as num).toDouble(),
      status: map['status'],
      items: itemsList.map((e) => EstimateItem.fromMap(Map<String, dynamic>.from(e))).toList(),
      notes: map['notes'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      discountPercent: (map['discountPercent'] as num?)?.toDouble() ?? 0,
      discountAmount: (map['discountAmount'] as num?)?.toDouble() ?? 0,
      withholdingTaxPercent: (map['withholdingTaxPercent'] as num?)?.toDouble() ?? 0,
      withholdingTaxAmount: (map['withholdingTaxAmount'] as num?)?.toDouble() ?? 0,
      tax2Percent: (map['tax2Percent'] as num?)?.toDouble() ?? 0,
    );
  }
}
