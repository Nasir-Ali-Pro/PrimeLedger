class TimeEntry {
  final String id;
  final String clientId;
  final String taskName;
  final String description;
  final DateTime date;
  final double hours;
  final double rate;
  final bool isBillable;
  final bool isInvoiced;
  final DateTime createdAt;

  TimeEntry({
    required this.id,
    required this.clientId,
    required this.taskName,
    this.description = '',
    required this.date,
    required this.hours,
    required this.rate,
    required this.isBillable,
    this.isInvoiced = false,
    required this.createdAt,
  });

  TimeEntry copyWith({
    String? id,
    String? clientId,
    String? taskName,
    String? description,
    DateTime? date,
    double? hours,
    double? rate,
    bool? isBillable,
    bool? isInvoiced,
    DateTime? createdAt,
  }) {
    return TimeEntry(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      date: date ?? this.date,
      hours: hours ?? this.hours,
      rate: rate ?? this.rate,
      isBillable: isBillable ?? this.isBillable,
      isInvoiced: isInvoiced ?? this.isInvoiced,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'taskName': taskName,
      'description': description,
      'date': date.toIso8601String(),
      'hours': hours,
      'rate': rate,
      'isBillable': isBillable,
      'isInvoiced': isInvoiced,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TimeEntry.fromMap(Map<String, dynamic> map) {
    return TimeEntry(
      id: map['id'],
      clientId: map['clientId'],
      taskName: map['taskName'] ?? map['taskId'] ?? '',
      description: map['description'] ?? '',
      date: DateTime.parse(map['date']),
      hours: (map['hours'] as num).toDouble(),
      rate: (map['rate'] as num).toDouble(),
      isBillable: map['isBillable'] ?? false,
      isInvoiced: map['isInvoiced'] ?? false,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
