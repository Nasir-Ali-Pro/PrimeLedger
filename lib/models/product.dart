class Product {
  final String id;
  final String name;
  final String? sku;
  final String? barcode;
  final String? description;
  final String category;
  final double costPrice;
  final double sellingPrice;
  final int quantity;
  final int reorderLevel;
  final String unit;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    this.sku,
    this.barcode,
    this.description,
    required this.category,
    required this.costPrice,
    required this.sellingPrice,
    required this.quantity,
    this.reorderLevel = 10,
    this.unit = 'pcs',
    required this.createdAt,
    required this.updatedAt,
  });

  double get profit => sellingPrice - costPrice;
  double get margin => costPrice > 0 ? (profit / costPrice) * 100 : 0;
  double get stockValue => costPrice * quantity;
  bool get isLowStock => quantity <= reorderLevel;

  Product copyWith({
    String? id,
    String? name,
    String? sku,
    String? barcode,
    String? description,
    String? category,
    double? costPrice,
    double? sellingPrice,
    int? quantity,
    int? reorderLevel,
    String? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      description: description ?? this.description,
      category: category ?? this.category,
      costPrice: costPrice ?? this.costPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      unit: unit ?? this.unit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'barcode': barcode,
      'description': description,
      'category': category,
      'costPrice': costPrice,
      'sellingPrice': sellingPrice,
      'quantity': quantity,
      'reorderLevel': reorderLevel,
      'unit': unit,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      sku: map['sku'],
      barcode: map['barcode'],
      description: map['description'],
      category: map['category'] ?? 'General',
      costPrice: (map['costPrice'] as num).toDouble(),
      sellingPrice: (map['sellingPrice'] as num).toDouble(),
      quantity: (map['quantity'] as num).toInt(),
      reorderLevel: (map['reorderLevel'] as num?)?.toInt() ?? 10,
      unit: map['unit'] ?? 'pcs',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  static const List<String> defaultCategories = [
    'Electronics',
    'Clothing',
    'Food & Beverage',
    'Office Supplies',
    'Raw Materials',
    'Packaging',
    'Furniture',
    'Tools',
    'Health & Beauty',
    'Purchased',
    'Other',
  ];

  static const List<String> units = [
    'pcs', 'kg', 'g', 'liters', 'ml', 'meters', 'feet', 'boxes', 'packs', 'dozen',
  ];
}
