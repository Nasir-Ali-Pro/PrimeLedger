import 'dart:convert';

class PurchaseOrderItem {
  final String id;
  final String? productId;
  final String description;
  final int quantity;
  final int receivedQuantity;
  final double unitPrice;
  final double taxPercent;
  final double taxAmount;
  final double total;

  PurchaseOrderItem({
    this.id = '',
    this.productId,
    required this.description,
    required this.quantity,
    this.receivedQuantity = 0,
    required this.unitPrice,
    this.taxPercent = 0,
    this.taxAmount = 0,
    required this.total,
  });

  PurchaseOrderItem copyWith({
    String? id,
    String? productId,
    String? description,
    int? quantity,
    int? receivedQuantity,
    double? unitPrice,
    double? taxPercent,
    double? taxAmount,
    double? total,
  }) {
    return PurchaseOrderItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      receivedQuantity: receivedQuantity ?? this.receivedQuantity,
      unitPrice: unitPrice ?? this.unitPrice,
      taxPercent: taxPercent ?? this.taxPercent,
      taxAmount: taxAmount ?? this.taxAmount,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'description': description,
      'quantity': quantity,
      'receivedQuantity': receivedQuantity,
      'unitPrice': unitPrice,
      'taxPercent': taxPercent,
      'taxAmount': taxAmount,
      'total': total,
    };
  }

  factory PurchaseOrderItem.fromMap(Map<String, dynamic> map) {
    return PurchaseOrderItem(
      id: map['id'] ?? '',
      productId: map['productId'],
      description: map['description'],
      quantity: (map['quantity'] as num).toInt(),
      receivedQuantity: (map['receivedQuantity'] as num?)?.toInt() ?? 0,
      unitPrice: (map['unitPrice'] as num).toDouble(),
      taxPercent: (map['taxPercent'] as num?)?.toDouble() ?? 0,
      taxAmount: (map['taxAmount'] as num?)?.toDouble() ?? (map['tax'] as num?)?.toDouble() ?? 0,
      total: (map['total'] as num).toDouble(),
    );
  }
}

class PurchaseOrder {
  final String id;
  final String supplierId;
  final String poNumber;
  final DateTime issueDate;
  final DateTime expectedDate;
  final double subTotal;
  final double taxTotal;
  final double totalAmount;
  final String status;
  final List<PurchaseOrderItem> items;
  final String? notes;
  final DateTime createdAt;

  PurchaseOrder({
    required this.id,
    required this.supplierId,
    required this.poNumber,
    required this.issueDate,
    required this.expectedDate,
    required this.subTotal,
    required this.taxTotal,
    required this.totalAmount,
    required this.status,
    required this.items,
    this.notes,
    required this.createdAt,
  });

  PurchaseOrder copyWith({
    String? id,
    String? supplierId,
    String? poNumber,
    DateTime? issueDate,
    DateTime? expectedDate,
    double? subTotal,
    double? taxTotal,
    double? totalAmount,
    String? status,
    List<PurchaseOrderItem>? items,
    String? notes,
    DateTime? createdAt,
  }) {
    return PurchaseOrder(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      poNumber: poNumber ?? this.poNumber,
      issueDate: issueDate ?? this.issueDate,
      expectedDate: expectedDate ?? this.expectedDate,
      subTotal: subTotal ?? this.subTotal,
      taxTotal: taxTotal ?? this.taxTotal,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      items: items ?? this.items,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'supplierId': supplierId,
      'poNumber': poNumber,
      'issueDate': issueDate.toIso8601String(),
      'expectedDate': expectedDate.toIso8601String(),
      'subTotal': subTotal,
      'taxTotal': taxTotal,
      'totalAmount': totalAmount,
      'status': status,
      'items': jsonEncode(items.map((e) => e.toMap()).toList()),
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory PurchaseOrder.fromMap(Map<String, dynamic> map) {
    List<dynamic> itemsList = map['items'] is String ? jsonDecode(map['items']) : (map['items'] as List<dynamic>? ?? []);
    return PurchaseOrder(
      id: map['id'],
      supplierId: map['supplierId'],
      poNumber: map['poNumber'],
      issueDate: DateTime.parse(map['issueDate']),
      expectedDate: DateTime.parse(map['expectedDate']),
      subTotal: (map['subTotal'] as num).toDouble(),
      taxTotal: (map['taxTotal'] as num).toDouble(),
      totalAmount: (map['totalAmount'] as num).toDouble(),
      status: map['status'],
      items: itemsList.map((e) => PurchaseOrderItem.fromMap(Map<String, dynamic>.from(e))).toList(),
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
