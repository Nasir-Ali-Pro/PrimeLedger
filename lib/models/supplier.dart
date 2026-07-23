class Supplier {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? contactPerson;
  final String? taxId;
  final DateTime createdAt;

  Supplier({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.contactPerson,
    this.taxId,
    required this.createdAt,
  });

  Supplier copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? contactPerson,
    String? taxId,
    DateTime? createdAt,
  }) {
    return Supplier(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      contactPerson: contactPerson ?? this.contactPerson,
      taxId: taxId ?? this.taxId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'contactPerson': contactPerson,
      'taxId': taxId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      contactPerson: map['contactPerson'],
      taxId: map['taxId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
