class Client {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final DateTime createdAt;
  final String? contactPerson;
  final String? taxNumber;
  final int paymentTermsDays;
  final double creditLimit;

  Client({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    required this.createdAt,
    this.contactPerson,
    this.taxNumber,
    this.paymentTermsDays = 14,
    this.creditLimit = 0.0,
  });

  factory Client.empty() => Client(
    id: '',
    name: '',
    email: null,
    phone: null,
    address: null,
    createdAt: DateTime.now(),
    contactPerson: null,
    taxNumber: null,
    paymentTermsDays: 14,
    creditLimit: 0.0,
  );

  Client copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    DateTime? createdAt,
    String? contactPerson,
    String? taxNumber,
    int? paymentTermsDays,
    double? creditLimit,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      contactPerson: contactPerson ?? this.contactPerson,
      taxNumber: taxNumber ?? this.taxNumber,
      paymentTermsDays: paymentTermsDays ?? this.paymentTermsDays,
      creditLimit: creditLimit ?? this.creditLimit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
      'contactPerson': contactPerson,
      'taxNumber': taxNumber,
      'paymentTermsDays': paymentTermsDays,
      'creditLimit': creditLimit,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      createdAt: DateTime.parse(map['createdAt']),
      contactPerson: map['contactPerson'],
      taxNumber: map['taxNumber'],
      paymentTermsDays: (map['paymentTermsDays'] as num?)?.toInt() ?? 14,
      creditLimit: (map['creditLimit'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
