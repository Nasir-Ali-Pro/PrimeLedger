class RecurringProfile {
  final String id;
  final String clientId;
  final String frequency;
  final DateTime nextIssueDate;
  final double amount;
  final String description;
  final bool isActive;
  final DateTime createdAt;

  RecurringProfile({
    required this.id,
    required this.clientId,
    required this.frequency,
    required this.nextIssueDate,
    required this.amount,
    required this.description,
    this.isActive = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  RecurringProfile copyWith({
    String? id,
    String? clientId,
    String? frequency,
    DateTime? nextIssueDate,
    double? amount,
    String? description,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return RecurringProfile(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      frequency: frequency ?? this.frequency,
      nextIssueDate: nextIssueDate ?? this.nextIssueDate,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'frequency': frequency,
      'nextIssueDate': nextIssueDate.toIso8601String(),
      'amount': amount,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RecurringProfile.fromMap(Map<String, dynamic> map) {
    return RecurringProfile(
      id: map['id'],
      clientId: map['clientId'],
      frequency: map['frequency'],
      nextIssueDate: DateTime.parse(map['nextIssueDate']),
      amount: (map['amount'] as num).toDouble(),
      description: map['description'],
      isActive: map['isActive'] ?? true,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
    );
  }
}
