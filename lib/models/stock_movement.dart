class StockMovement {
  final String id;
  final String productId;
  final String productName;
  final int quantityChange;
  final int balanceAfter;
  final String type;
  final String referenceNumber;
  final String? referenceId;
  final String description;
  final DateTime createdAt;

  StockMovement({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantityChange,
    required this.balanceAfter,
    required this.type,
    this.referenceNumber = '',
    this.referenceId,
    required this.description,
    required this.createdAt,
  });
}
