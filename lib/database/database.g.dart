// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClientsTblTable extends ClientsTbl
    with TableInfo<$ClientsTblTable, ClientsTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactPersonMeta = const VerificationMeta(
    'contactPerson',
  );
  @override
  late final GeneratedColumn<String> contactPerson = GeneratedColumn<String>(
    'contact_person',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taxNumberMeta = const VerificationMeta(
    'taxNumber',
  );
  @override
  late final GeneratedColumn<String> taxNumber = GeneratedColumn<String>(
    'tax_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentTermsDaysMeta = const VerificationMeta(
    'paymentTermsDays',
  );
  @override
  late final GeneratedColumn<int> paymentTermsDays = GeneratedColumn<int>(
    'payment_terms_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(14),
  );
  static const VerificationMeta _creditLimitMeta = const VerificationMeta(
    'creditLimit',
  );
  @override
  late final GeneratedColumn<double> creditLimit = GeneratedColumn<double>(
    'credit_limit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    phone,
    address,
    createdAt,
    contactPerson,
    taxNumber,
    paymentTermsDays,
    creditLimit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientsTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('contact_person')) {
      context.handle(
        _contactPersonMeta,
        contactPerson.isAcceptableOrUnknown(
          data['contact_person']!,
          _contactPersonMeta,
        ),
      );
    }
    if (data.containsKey('tax_number')) {
      context.handle(
        _taxNumberMeta,
        taxNumber.isAcceptableOrUnknown(data['tax_number']!, _taxNumberMeta),
      );
    }
    if (data.containsKey('payment_terms_days')) {
      context.handle(
        _paymentTermsDaysMeta,
        paymentTermsDays.isAcceptableOrUnknown(
          data['payment_terms_days']!,
          _paymentTermsDaysMeta,
        ),
      );
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
        _creditLimitMeta,
        creditLimit.isAcceptableOrUnknown(
          data['credit_limit']!,
          _creditLimitMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientsTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientsTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      contactPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_person'],
      ),
      taxNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax_number'],
      ),
      paymentTermsDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_terms_days'],
      )!,
      creditLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_limit'],
      )!,
    );
  }

  @override
  $ClientsTblTable createAlias(String alias) {
    return $ClientsTblTable(attachedDatabase, alias);
  }
}

class ClientsTblData extends DataClass implements Insertable<ClientsTblData> {
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
  const ClientsTblData({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    required this.createdAt,
    this.contactPerson,
    this.taxNumber,
    required this.paymentTermsDays,
    required this.creditLimit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || contactPerson != null) {
      map['contact_person'] = Variable<String>(contactPerson);
    }
    if (!nullToAbsent || taxNumber != null) {
      map['tax_number'] = Variable<String>(taxNumber);
    }
    map['payment_terms_days'] = Variable<int>(paymentTermsDays);
    map['credit_limit'] = Variable<double>(creditLimit);
    return map;
  }

  ClientsTblCompanion toCompanion(bool nullToAbsent) {
    return ClientsTblCompanion(
      id: Value(id),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
      contactPerson: contactPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPerson),
      taxNumber: taxNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(taxNumber),
      paymentTermsDays: Value(paymentTermsDays),
      creditLimit: Value(creditLimit),
    );
  }

  factory ClientsTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientsTblData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      contactPerson: serializer.fromJson<String?>(json['contactPerson']),
      taxNumber: serializer.fromJson<String?>(json['taxNumber']),
      paymentTermsDays: serializer.fromJson<int>(json['paymentTermsDays']),
      creditLimit: serializer.fromJson<double>(json['creditLimit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'contactPerson': serializer.toJson<String?>(contactPerson),
      'taxNumber': serializer.toJson<String?>(taxNumber),
      'paymentTermsDays': serializer.toJson<int>(paymentTermsDays),
      'creditLimit': serializer.toJson<double>(creditLimit),
    };
  }

  ClientsTblData copyWith({
    String? id,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    DateTime? createdAt,
    Value<String?> contactPerson = const Value.absent(),
    Value<String?> taxNumber = const Value.absent(),
    int? paymentTermsDays,
    double? creditLimit,
  }) => ClientsTblData(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    createdAt: createdAt ?? this.createdAt,
    contactPerson: contactPerson.present
        ? contactPerson.value
        : this.contactPerson,
    taxNumber: taxNumber.present ? taxNumber.value : this.taxNumber,
    paymentTermsDays: paymentTermsDays ?? this.paymentTermsDays,
    creditLimit: creditLimit ?? this.creditLimit,
  );
  ClientsTblData copyWithCompanion(ClientsTblCompanion data) {
    return ClientsTblData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      contactPerson: data.contactPerson.present
          ? data.contactPerson.value
          : this.contactPerson,
      taxNumber: data.taxNumber.present ? data.taxNumber.value : this.taxNumber,
      paymentTermsDays: data.paymentTermsDays.present
          ? data.paymentTermsDays.value
          : this.paymentTermsDays,
      creditLimit: data.creditLimit.present
          ? data.creditLimit.value
          : this.creditLimit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientsTblData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('taxNumber: $taxNumber, ')
          ..write('paymentTermsDays: $paymentTermsDays, ')
          ..write('creditLimit: $creditLimit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    email,
    phone,
    address,
    createdAt,
    contactPerson,
    taxNumber,
    paymentTermsDays,
    creditLimit,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientsTblData &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.contactPerson == this.contactPerson &&
          other.taxNumber == this.taxNumber &&
          other.paymentTermsDays == this.paymentTermsDays &&
          other.creditLimit == this.creditLimit);
}

class ClientsTblCompanion extends UpdateCompanion<ClientsTblData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  final Value<String?> contactPerson;
  final Value<String?> taxNumber;
  final Value<int> paymentTermsDays;
  final Value<double> creditLimit;
  final Value<int> rowid;
  const ClientsTblCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.contactPerson = const Value.absent(),
    this.taxNumber = const Value.absent(),
    this.paymentTermsDays = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientsTblCompanion.insert({
    required String id,
    required String name,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    required DateTime createdAt,
    this.contactPerson = const Value.absent(),
    this.taxNumber = const Value.absent(),
    this.paymentTermsDays = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<ClientsTblData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<String>? contactPerson,
    Expression<String>? taxNumber,
    Expression<int>? paymentTermsDays,
    Expression<double>? creditLimit,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (contactPerson != null) 'contact_person': contactPerson,
      if (taxNumber != null) 'tax_number': taxNumber,
      if (paymentTermsDays != null) 'payment_terms_days': paymentTermsDays,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientsTblCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? address,
    Value<DateTime>? createdAt,
    Value<String?>? contactPerson,
    Value<String?>? taxNumber,
    Value<int>? paymentTermsDays,
    Value<double>? creditLimit,
    Value<int>? rowid,
  }) {
    return ClientsTblCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (contactPerson.present) {
      map['contact_person'] = Variable<String>(contactPerson.value);
    }
    if (taxNumber.present) {
      map['tax_number'] = Variable<String>(taxNumber.value);
    }
    if (paymentTermsDays.present) {
      map['payment_terms_days'] = Variable<int>(paymentTermsDays.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<double>(creditLimit.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsTblCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('taxNumber: $taxNumber, ')
          ..write('paymentTermsDays: $paymentTermsDays, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTblTable extends InvoicesTbl
    with TableInfo<$InvoicesTblTable, InvoicesTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<DateTime> issueDate = GeneratedColumn<DateTime>(
    'issue_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subTotalMeta = const VerificationMeta(
    'subTotal',
  );
  @override
  late final GeneratedColumn<double> subTotal = GeneratedColumn<double>(
    'sub_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxTotalMeta = const VerificationMeta(
    'taxTotal',
  );
  @override
  late final GeneratedColumn<double> taxTotal = GeneratedColumn<double>(
    'tax_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<double> discountPercent = GeneratedColumn<double>(
    'discount_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _discountAmountMeta = const VerificationMeta(
    'discountAmount',
  );
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
    'discount_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _withholdingTaxPercentMeta =
      const VerificationMeta('withholdingTaxPercent');
  @override
  late final GeneratedColumn<double> withholdingTaxPercent =
      GeneratedColumn<double>(
        'withholding_tax_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _withholdingTaxAmountMeta =
      const VerificationMeta('withholdingTaxAmount');
  @override
  late final GeneratedColumn<double> withholdingTaxAmount =
      GeneratedColumn<double>(
        'withholding_tax_amount',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _tax2PercentMeta = const VerificationMeta(
    'tax2Percent',
  );
  @override
  late final GeneratedColumn<double> tax2Percent = GeneratedColumn<double>(
    'tax2_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    invoiceNumber,
    issueDate,
    dueDate,
    subTotal,
    taxTotal,
    totalAmount,
    status,
    notes,
    createdAt,
    discountPercent,
    discountAmount,
    withholdingTaxPercent,
    withholdingTaxAmount,
    tax2Percent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoicesTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_issueDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('sub_total')) {
      context.handle(
        _subTotalMeta,
        subTotal.isAcceptableOrUnknown(data['sub_total']!, _subTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subTotalMeta);
    }
    if (data.containsKey('tax_total')) {
      context.handle(
        _taxTotalMeta,
        taxTotal.isAcceptableOrUnknown(data['tax_total']!, _taxTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_taxTotalMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
        _discountAmountMeta,
        discountAmount.isAcceptableOrUnknown(
          data['discount_amount']!,
          _discountAmountMeta,
        ),
      );
    }
    if (data.containsKey('withholding_tax_percent')) {
      context.handle(
        _withholdingTaxPercentMeta,
        withholdingTaxPercent.isAcceptableOrUnknown(
          data['withholding_tax_percent']!,
          _withholdingTaxPercentMeta,
        ),
      );
    }
    if (data.containsKey('withholding_tax_amount')) {
      context.handle(
        _withholdingTaxAmountMeta,
        withholdingTaxAmount.isAcceptableOrUnknown(
          data['withholding_tax_amount']!,
          _withholdingTaxAmountMeta,
        ),
      );
    }
    if (data.containsKey('tax2_percent')) {
      context.handle(
        _tax2PercentMeta,
        tax2Percent.isAcceptableOrUnknown(
          data['tax2_percent']!,
          _tax2PercentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoicesTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoicesTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issue_date'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      subTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sub_total'],
      )!,
      taxTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_total'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_percent'],
      )!,
      discountAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_amount'],
      )!,
      withholdingTaxPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}withholding_tax_percent'],
      )!,
      withholdingTaxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}withholding_tax_amount'],
      )!,
      tax2Percent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax2_percent'],
      )!,
    );
  }

  @override
  $InvoicesTblTable createAlias(String alias) {
    return $InvoicesTblTable(attachedDatabase, alias);
  }
}

class InvoicesTblData extends DataClass implements Insertable<InvoicesTblData> {
  final String id;
  final String clientId;
  final String invoiceNumber;
  final DateTime issueDate;
  final DateTime dueDate;
  final double subTotal;
  final double taxTotal;
  final double totalAmount;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final double discountPercent;
  final double discountAmount;
  final double withholdingTaxPercent;
  final double withholdingTaxAmount;
  final double tax2Percent;
  const InvoicesTblData({
    required this.id,
    required this.clientId,
    required this.invoiceNumber,
    required this.issueDate,
    required this.dueDate,
    required this.subTotal,
    required this.taxTotal,
    required this.totalAmount,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.discountPercent,
    required this.discountAmount,
    required this.withholdingTaxPercent,
    required this.withholdingTaxAmount,
    required this.tax2Percent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['issue_date'] = Variable<DateTime>(issueDate);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['sub_total'] = Variable<double>(subTotal);
    map['tax_total'] = Variable<double>(taxTotal);
    map['total_amount'] = Variable<double>(totalAmount);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['discount_percent'] = Variable<double>(discountPercent);
    map['discount_amount'] = Variable<double>(discountAmount);
    map['withholding_tax_percent'] = Variable<double>(withholdingTaxPercent);
    map['withholding_tax_amount'] = Variable<double>(withholdingTaxAmount);
    map['tax2_percent'] = Variable<double>(tax2Percent);
    return map;
  }

  InvoicesTblCompanion toCompanion(bool nullToAbsent) {
    return InvoicesTblCompanion(
      id: Value(id),
      clientId: Value(clientId),
      invoiceNumber: Value(invoiceNumber),
      issueDate: Value(issueDate),
      dueDate: Value(dueDate),
      subTotal: Value(subTotal),
      taxTotal: Value(taxTotal),
      totalAmount: Value(totalAmount),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      discountPercent: Value(discountPercent),
      discountAmount: Value(discountAmount),
      withholdingTaxPercent: Value(withholdingTaxPercent),
      withholdingTaxAmount: Value(withholdingTaxAmount),
      tax2Percent: Value(tax2Percent),
    );
  }

  factory InvoicesTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoicesTblData(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      issueDate: serializer.fromJson<DateTime>(json['issueDate']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      subTotal: serializer.fromJson<double>(json['subTotal']),
      taxTotal: serializer.fromJson<double>(json['taxTotal']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      discountPercent: serializer.fromJson<double>(json['discountPercent']),
      discountAmount: serializer.fromJson<double>(json['discountAmount']),
      withholdingTaxPercent: serializer.fromJson<double>(
        json['withholdingTaxPercent'],
      ),
      withholdingTaxAmount: serializer.fromJson<double>(
        json['withholdingTaxAmount'],
      ),
      tax2Percent: serializer.fromJson<double>(json['tax2Percent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'issueDate': serializer.toJson<DateTime>(issueDate),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'subTotal': serializer.toJson<double>(subTotal),
      'taxTotal': serializer.toJson<double>(taxTotal),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'discountPercent': serializer.toJson<double>(discountPercent),
      'discountAmount': serializer.toJson<double>(discountAmount),
      'withholdingTaxPercent': serializer.toJson<double>(withholdingTaxPercent),
      'withholdingTaxAmount': serializer.toJson<double>(withholdingTaxAmount),
      'tax2Percent': serializer.toJson<double>(tax2Percent),
    };
  }

  InvoicesTblData copyWith({
    String? id,
    String? clientId,
    String? invoiceNumber,
    DateTime? issueDate,
    DateTime? dueDate,
    double? subTotal,
    double? taxTotal,
    double? totalAmount,
    String? status,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    double? discountPercent,
    double? discountAmount,
    double? withholdingTaxPercent,
    double? withholdingTaxAmount,
    double? tax2Percent,
  }) => InvoicesTblData(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    issueDate: issueDate ?? this.issueDate,
    dueDate: dueDate ?? this.dueDate,
    subTotal: subTotal ?? this.subTotal,
    taxTotal: taxTotal ?? this.taxTotal,
    totalAmount: totalAmount ?? this.totalAmount,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    discountPercent: discountPercent ?? this.discountPercent,
    discountAmount: discountAmount ?? this.discountAmount,
    withholdingTaxPercent: withholdingTaxPercent ?? this.withholdingTaxPercent,
    withholdingTaxAmount: withholdingTaxAmount ?? this.withholdingTaxAmount,
    tax2Percent: tax2Percent ?? this.tax2Percent,
  );
  InvoicesTblData copyWithCompanion(InvoicesTblCompanion data) {
    return InvoicesTblData(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      subTotal: data.subTotal.present ? data.subTotal.value : this.subTotal,
      taxTotal: data.taxTotal.present ? data.taxTotal.value : this.taxTotal,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      withholdingTaxPercent: data.withholdingTaxPercent.present
          ? data.withholdingTaxPercent.value
          : this.withholdingTaxPercent,
      withholdingTaxAmount: data.withholdingTaxAmount.present
          ? data.withholdingTaxAmount.value
          : this.withholdingTaxAmount,
      tax2Percent: data.tax2Percent.present
          ? data.tax2Percent.value
          : this.tax2Percent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesTblData(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('issueDate: $issueDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('subTotal: $subTotal, ')
          ..write('taxTotal: $taxTotal, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('withholdingTaxPercent: $withholdingTaxPercent, ')
          ..write('withholdingTaxAmount: $withholdingTaxAmount, ')
          ..write('tax2Percent: $tax2Percent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    invoiceNumber,
    issueDate,
    dueDate,
    subTotal,
    taxTotal,
    totalAmount,
    status,
    notes,
    createdAt,
    discountPercent,
    discountAmount,
    withholdingTaxPercent,
    withholdingTaxAmount,
    tax2Percent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoicesTblData &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.invoiceNumber == this.invoiceNumber &&
          other.issueDate == this.issueDate &&
          other.dueDate == this.dueDate &&
          other.subTotal == this.subTotal &&
          other.taxTotal == this.taxTotal &&
          other.totalAmount == this.totalAmount &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.discountPercent == this.discountPercent &&
          other.discountAmount == this.discountAmount &&
          other.withholdingTaxPercent == this.withholdingTaxPercent &&
          other.withholdingTaxAmount == this.withholdingTaxAmount &&
          other.tax2Percent == this.tax2Percent);
}

class InvoicesTblCompanion extends UpdateCompanion<InvoicesTblData> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> invoiceNumber;
  final Value<DateTime> issueDate;
  final Value<DateTime> dueDate;
  final Value<double> subTotal;
  final Value<double> taxTotal;
  final Value<double> totalAmount;
  final Value<String> status;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<double> discountPercent;
  final Value<double> discountAmount;
  final Value<double> withholdingTaxPercent;
  final Value<double> withholdingTaxAmount;
  final Value<double> tax2Percent;
  final Value<int> rowid;
  const InvoicesTblCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.subTotal = const Value.absent(),
    this.taxTotal = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.withholdingTaxPercent = const Value.absent(),
    this.withholdingTaxAmount = const Value.absent(),
    this.tax2Percent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicesTblCompanion.insert({
    required String id,
    required String clientId,
    required String invoiceNumber,
    required DateTime issueDate,
    required DateTime dueDate,
    required double subTotal,
    required double taxTotal,
    required double totalAmount,
    required String status,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.discountPercent = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.withholdingTaxPercent = const Value.absent(),
    this.withholdingTaxAmount = const Value.absent(),
    this.tax2Percent = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       invoiceNumber = Value(invoiceNumber),
       issueDate = Value(issueDate),
       dueDate = Value(dueDate),
       subTotal = Value(subTotal),
       taxTotal = Value(taxTotal),
       totalAmount = Value(totalAmount),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<InvoicesTblData> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? invoiceNumber,
    Expression<DateTime>? issueDate,
    Expression<DateTime>? dueDate,
    Expression<double>? subTotal,
    Expression<double>? taxTotal,
    Expression<double>? totalAmount,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<double>? discountPercent,
    Expression<double>? discountAmount,
    Expression<double>? withholdingTaxPercent,
    Expression<double>? withholdingTaxAmount,
    Expression<double>? tax2Percent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (issueDate != null) 'issue_date': issueDate,
      if (dueDate != null) 'due_date': dueDate,
      if (subTotal != null) 'sub_total': subTotal,
      if (taxTotal != null) 'tax_total': taxTotal,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (withholdingTaxPercent != null)
        'withholding_tax_percent': withholdingTaxPercent,
      if (withholdingTaxAmount != null)
        'withholding_tax_amount': withholdingTaxAmount,
      if (tax2Percent != null) 'tax2_percent': tax2Percent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicesTblCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String>? invoiceNumber,
    Value<DateTime>? issueDate,
    Value<DateTime>? dueDate,
    Value<double>? subTotal,
    Value<double>? taxTotal,
    Value<double>? totalAmount,
    Value<String>? status,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<double>? discountPercent,
    Value<double>? discountAmount,
    Value<double>? withholdingTaxPercent,
    Value<double>? withholdingTaxAmount,
    Value<double>? tax2Percent,
    Value<int>? rowid,
  }) {
    return InvoicesTblCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      subTotal: subTotal ?? this.subTotal,
      taxTotal: taxTotal ?? this.taxTotal,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
      withholdingTaxPercent:
          withholdingTaxPercent ?? this.withholdingTaxPercent,
      withholdingTaxAmount: withholdingTaxAmount ?? this.withholdingTaxAmount,
      tax2Percent: tax2Percent ?? this.tax2Percent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<DateTime>(issueDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (subTotal.present) {
      map['sub_total'] = Variable<double>(subTotal.value);
    }
    if (taxTotal.present) {
      map['tax_total'] = Variable<double>(taxTotal.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<double>(discountPercent.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
    }
    if (withholdingTaxPercent.present) {
      map['withholding_tax_percent'] = Variable<double>(
        withholdingTaxPercent.value,
      );
    }
    if (withholdingTaxAmount.present) {
      map['withholding_tax_amount'] = Variable<double>(
        withholdingTaxAmount.value,
      );
    }
    if (tax2Percent.present) {
      map['tax2_percent'] = Variable<double>(tax2Percent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesTblCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('issueDate: $issueDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('subTotal: $subTotal, ')
          ..write('taxTotal: $taxTotal, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('withholdingTaxPercent: $withholdingTaxPercent, ')
          ..write('withholdingTaxAmount: $withholdingTaxAmount, ')
          ..write('tax2Percent: $tax2Percent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoiceItemsTblTable extends InvoiceItemsTbl
    with TableInfo<$InvoiceItemsTblTable, InvoiceItemsTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxPercentMeta = const VerificationMeta(
    'taxPercent',
  );
  @override
  late final GeneratedColumn<double> taxPercent = GeneratedColumn<double>(
    'tax_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<double> discountPercent = GeneratedColumn<double>(
    'discount_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    productId,
    description,
    quantity,
    rate,
    taxPercent,
    taxAmount,
    discountPercent,
    total,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceItemsTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('tax_percent')) {
      context.handle(
        _taxPercentMeta,
        taxPercent.isAcceptableOrUnknown(data['tax_percent']!, _taxPercentMeta),
      );
    } else if (isInserting) {
      context.missing(_taxPercentMeta);
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_taxAmountMeta);
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceItemsTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItemsTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate'],
      )!,
      taxPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_percent'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_percent'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
    );
  }

  @override
  $InvoiceItemsTblTable createAlias(String alias) {
    return $InvoiceItemsTblTable(attachedDatabase, alias);
  }
}

class InvoiceItemsTblData extends DataClass
    implements Insertable<InvoiceItemsTblData> {
  final String id;
  final String invoiceId;
  final String? productId;
  final String description;
  final int quantity;
  final double rate;
  final double taxPercent;
  final double taxAmount;
  final double discountPercent;
  final double total;
  const InvoiceItemsTblData({
    required this.id,
    required this.invoiceId,
    this.productId,
    required this.description,
    required this.quantity,
    required this.rate,
    required this.taxPercent,
    required this.taxAmount,
    required this.discountPercent,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_id'] = Variable<String>(invoiceId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<int>(quantity);
    map['rate'] = Variable<double>(rate);
    map['tax_percent'] = Variable<double>(taxPercent);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['discount_percent'] = Variable<double>(discountPercent);
    map['total'] = Variable<double>(total);
    return map;
  }

  InvoiceItemsTblCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsTblCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      description: Value(description),
      quantity: Value(quantity),
      rate: Value(rate),
      taxPercent: Value(taxPercent),
      taxAmount: Value(taxAmount),
      discountPercent: Value(discountPercent),
      total: Value(total),
    );
  }

  factory InvoiceItemsTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItemsTblData(
      id: serializer.fromJson<String>(json['id']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      productId: serializer.fromJson<String?>(json['productId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<int>(json['quantity']),
      rate: serializer.fromJson<double>(json['rate']),
      taxPercent: serializer.fromJson<double>(json['taxPercent']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      discountPercent: serializer.fromJson<double>(json['discountPercent']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'productId': serializer.toJson<String?>(productId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<int>(quantity),
      'rate': serializer.toJson<double>(rate),
      'taxPercent': serializer.toJson<double>(taxPercent),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'discountPercent': serializer.toJson<double>(discountPercent),
      'total': serializer.toJson<double>(total),
    };
  }

  InvoiceItemsTblData copyWith({
    String? id,
    String? invoiceId,
    Value<String?> productId = const Value.absent(),
    String? description,
    int? quantity,
    double? rate,
    double? taxPercent,
    double? taxAmount,
    double? discountPercent,
    double? total,
  }) => InvoiceItemsTblData(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    productId: productId.present ? productId.value : this.productId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    rate: rate ?? this.rate,
    taxPercent: taxPercent ?? this.taxPercent,
    taxAmount: taxAmount ?? this.taxAmount,
    discountPercent: discountPercent ?? this.discountPercent,
    total: total ?? this.total,
  );
  InvoiceItemsTblData copyWithCompanion(InvoiceItemsTblCompanion data) {
    return InvoiceItemsTblData(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      productId: data.productId.present ? data.productId.value : this.productId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      rate: data.rate.present ? data.rate.value : this.rate,
      taxPercent: data.taxPercent.present
          ? data.taxPercent.value
          : this.taxPercent,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsTblData(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('rate: $rate, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    productId,
    description,
    quantity,
    rate,
    taxPercent,
    taxAmount,
    discountPercent,
    total,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItemsTblData &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.rate == this.rate &&
          other.taxPercent == this.taxPercent &&
          other.taxAmount == this.taxAmount &&
          other.discountPercent == this.discountPercent &&
          other.total == this.total);
}

class InvoiceItemsTblCompanion extends UpdateCompanion<InvoiceItemsTblData> {
  final Value<String> id;
  final Value<String> invoiceId;
  final Value<String?> productId;
  final Value<String> description;
  final Value<int> quantity;
  final Value<double> rate;
  final Value<double> taxPercent;
  final Value<double> taxAmount;
  final Value<double> discountPercent;
  final Value<double> total;
  final Value<int> rowid;
  const InvoiceItemsTblCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.rate = const Value.absent(),
    this.taxPercent = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoiceItemsTblCompanion.insert({
    required String id,
    required String invoiceId,
    this.productId = const Value.absent(),
    required String description,
    required int quantity,
    required double rate,
    required double taxPercent,
    required double taxAmount,
    this.discountPercent = const Value.absent(),
    required double total,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       invoiceId = Value(invoiceId),
       description = Value(description),
       quantity = Value(quantity),
       rate = Value(rate),
       taxPercent = Value(taxPercent),
       taxAmount = Value(taxAmount),
       total = Value(total);
  static Insertable<InvoiceItemsTblData> custom({
    Expression<String>? id,
    Expression<String>? invoiceId,
    Expression<String>? productId,
    Expression<String>? description,
    Expression<int>? quantity,
    Expression<double>? rate,
    Expression<double>? taxPercent,
    Expression<double>? taxAmount,
    Expression<double>? discountPercent,
    Expression<double>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (rate != null) 'rate': rate,
      if (taxPercent != null) 'tax_percent': taxPercent,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoiceItemsTblCompanion copyWith({
    Value<String>? id,
    Value<String>? invoiceId,
    Value<String?>? productId,
    Value<String>? description,
    Value<int>? quantity,
    Value<double>? rate,
    Value<double>? taxPercent,
    Value<double>? taxAmount,
    Value<double>? discountPercent,
    Value<double>? total,
    Value<int>? rowid,
  }) {
    return InvoiceItemsTblCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      taxPercent: taxPercent ?? this.taxPercent,
      taxAmount: taxAmount ?? this.taxAmount,
      discountPercent: discountPercent ?? this.discountPercent,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (taxPercent.present) {
      map['tax_percent'] = Variable<double>(taxPercent.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<double>(discountPercent.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsTblCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('rate: $rate, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EstimatesTblTable extends EstimatesTbl
    with TableInfo<$EstimatesTblTable, EstimatesTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EstimatesTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _estimateNumberMeta = const VerificationMeta(
    'estimateNumber',
  );
  @override
  late final GeneratedColumn<String> estimateNumber = GeneratedColumn<String>(
    'estimate_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<DateTime> issueDate = GeneratedColumn<DateTime>(
    'issue_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subTotalMeta = const VerificationMeta(
    'subTotal',
  );
  @override
  late final GeneratedColumn<double> subTotal = GeneratedColumn<double>(
    'sub_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxTotalMeta = const VerificationMeta(
    'taxTotal',
  );
  @override
  late final GeneratedColumn<double> taxTotal = GeneratedColumn<double>(
    'tax_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<double> discountPercent = GeneratedColumn<double>(
    'discount_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _discountAmountMeta = const VerificationMeta(
    'discountAmount',
  );
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
    'discount_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _withholdingTaxPercentMeta =
      const VerificationMeta('withholdingTaxPercent');
  @override
  late final GeneratedColumn<double> withholdingTaxPercent =
      GeneratedColumn<double>(
        'withholding_tax_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _withholdingTaxAmountMeta =
      const VerificationMeta('withholdingTaxAmount');
  @override
  late final GeneratedColumn<double> withholdingTaxAmount =
      GeneratedColumn<double>(
        'withholding_tax_amount',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _tax2PercentMeta = const VerificationMeta(
    'tax2Percent',
  );
  @override
  late final GeneratedColumn<double> tax2Percent = GeneratedColumn<double>(
    'tax2_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    estimateNumber,
    issueDate,
    expiryDate,
    subTotal,
    taxTotal,
    totalAmount,
    status,
    notes,
    createdAt,
    discountPercent,
    discountAmount,
    withholdingTaxPercent,
    withholdingTaxAmount,
    tax2Percent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'estimates_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<EstimatesTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('estimate_number')) {
      context.handle(
        _estimateNumberMeta,
        estimateNumber.isAcceptableOrUnknown(
          data['estimate_number']!,
          _estimateNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimateNumberMeta);
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_issueDateMeta);
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_expiryDateMeta);
    }
    if (data.containsKey('sub_total')) {
      context.handle(
        _subTotalMeta,
        subTotal.isAcceptableOrUnknown(data['sub_total']!, _subTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subTotalMeta);
    }
    if (data.containsKey('tax_total')) {
      context.handle(
        _taxTotalMeta,
        taxTotal.isAcceptableOrUnknown(data['tax_total']!, _taxTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_taxTotalMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
        _discountAmountMeta,
        discountAmount.isAcceptableOrUnknown(
          data['discount_amount']!,
          _discountAmountMeta,
        ),
      );
    }
    if (data.containsKey('withholding_tax_percent')) {
      context.handle(
        _withholdingTaxPercentMeta,
        withholdingTaxPercent.isAcceptableOrUnknown(
          data['withholding_tax_percent']!,
          _withholdingTaxPercentMeta,
        ),
      );
    }
    if (data.containsKey('withholding_tax_amount')) {
      context.handle(
        _withholdingTaxAmountMeta,
        withholdingTaxAmount.isAcceptableOrUnknown(
          data['withholding_tax_amount']!,
          _withholdingTaxAmountMeta,
        ),
      );
    }
    if (data.containsKey('tax2_percent')) {
      context.handle(
        _tax2PercentMeta,
        tax2Percent.isAcceptableOrUnknown(
          data['tax2_percent']!,
          _tax2PercentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EstimatesTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EstimatesTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      estimateNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estimate_number'],
      )!,
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issue_date'],
      )!,
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiry_date'],
      )!,
      subTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sub_total'],
      )!,
      taxTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_total'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_percent'],
      )!,
      discountAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_amount'],
      )!,
      withholdingTaxPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}withholding_tax_percent'],
      )!,
      withholdingTaxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}withholding_tax_amount'],
      )!,
      tax2Percent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax2_percent'],
      )!,
    );
  }

  @override
  $EstimatesTblTable createAlias(String alias) {
    return $EstimatesTblTable(attachedDatabase, alias);
  }
}

class EstimatesTblData extends DataClass
    implements Insertable<EstimatesTblData> {
  final String id;
  final String clientId;
  final String estimateNumber;
  final DateTime issueDate;
  final DateTime expiryDate;
  final double subTotal;
  final double taxTotal;
  final double totalAmount;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final double discountPercent;
  final double discountAmount;
  final double withholdingTaxPercent;
  final double withholdingTaxAmount;
  final double tax2Percent;
  const EstimatesTblData({
    required this.id,
    required this.clientId,
    required this.estimateNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.subTotal,
    required this.taxTotal,
    required this.totalAmount,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.discountPercent,
    required this.discountAmount,
    required this.withholdingTaxPercent,
    required this.withholdingTaxAmount,
    required this.tax2Percent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    map['estimate_number'] = Variable<String>(estimateNumber);
    map['issue_date'] = Variable<DateTime>(issueDate);
    map['expiry_date'] = Variable<DateTime>(expiryDate);
    map['sub_total'] = Variable<double>(subTotal);
    map['tax_total'] = Variable<double>(taxTotal);
    map['total_amount'] = Variable<double>(totalAmount);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['discount_percent'] = Variable<double>(discountPercent);
    map['discount_amount'] = Variable<double>(discountAmount);
    map['withholding_tax_percent'] = Variable<double>(withholdingTaxPercent);
    map['withholding_tax_amount'] = Variable<double>(withholdingTaxAmount);
    map['tax2_percent'] = Variable<double>(tax2Percent);
    return map;
  }

  EstimatesTblCompanion toCompanion(bool nullToAbsent) {
    return EstimatesTblCompanion(
      id: Value(id),
      clientId: Value(clientId),
      estimateNumber: Value(estimateNumber),
      issueDate: Value(issueDate),
      expiryDate: Value(expiryDate),
      subTotal: Value(subTotal),
      taxTotal: Value(taxTotal),
      totalAmount: Value(totalAmount),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      discountPercent: Value(discountPercent),
      discountAmount: Value(discountAmount),
      withholdingTaxPercent: Value(withholdingTaxPercent),
      withholdingTaxAmount: Value(withholdingTaxAmount),
      tax2Percent: Value(tax2Percent),
    );
  }

  factory EstimatesTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EstimatesTblData(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      estimateNumber: serializer.fromJson<String>(json['estimateNumber']),
      issueDate: serializer.fromJson<DateTime>(json['issueDate']),
      expiryDate: serializer.fromJson<DateTime>(json['expiryDate']),
      subTotal: serializer.fromJson<double>(json['subTotal']),
      taxTotal: serializer.fromJson<double>(json['taxTotal']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      discountPercent: serializer.fromJson<double>(json['discountPercent']),
      discountAmount: serializer.fromJson<double>(json['discountAmount']),
      withholdingTaxPercent: serializer.fromJson<double>(
        json['withholdingTaxPercent'],
      ),
      withholdingTaxAmount: serializer.fromJson<double>(
        json['withholdingTaxAmount'],
      ),
      tax2Percent: serializer.fromJson<double>(json['tax2Percent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'estimateNumber': serializer.toJson<String>(estimateNumber),
      'issueDate': serializer.toJson<DateTime>(issueDate),
      'expiryDate': serializer.toJson<DateTime>(expiryDate),
      'subTotal': serializer.toJson<double>(subTotal),
      'taxTotal': serializer.toJson<double>(taxTotal),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'discountPercent': serializer.toJson<double>(discountPercent),
      'discountAmount': serializer.toJson<double>(discountAmount),
      'withholdingTaxPercent': serializer.toJson<double>(withholdingTaxPercent),
      'withholdingTaxAmount': serializer.toJson<double>(withholdingTaxAmount),
      'tax2Percent': serializer.toJson<double>(tax2Percent),
    };
  }

  EstimatesTblData copyWith({
    String? id,
    String? clientId,
    String? estimateNumber,
    DateTime? issueDate,
    DateTime? expiryDate,
    double? subTotal,
    double? taxTotal,
    double? totalAmount,
    String? status,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    double? discountPercent,
    double? discountAmount,
    double? withholdingTaxPercent,
    double? withholdingTaxAmount,
    double? tax2Percent,
  }) => EstimatesTblData(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    estimateNumber: estimateNumber ?? this.estimateNumber,
    issueDate: issueDate ?? this.issueDate,
    expiryDate: expiryDate ?? this.expiryDate,
    subTotal: subTotal ?? this.subTotal,
    taxTotal: taxTotal ?? this.taxTotal,
    totalAmount: totalAmount ?? this.totalAmount,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    discountPercent: discountPercent ?? this.discountPercent,
    discountAmount: discountAmount ?? this.discountAmount,
    withholdingTaxPercent: withholdingTaxPercent ?? this.withholdingTaxPercent,
    withholdingTaxAmount: withholdingTaxAmount ?? this.withholdingTaxAmount,
    tax2Percent: tax2Percent ?? this.tax2Percent,
  );
  EstimatesTblData copyWithCompanion(EstimatesTblCompanion data) {
    return EstimatesTblData(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      estimateNumber: data.estimateNumber.present
          ? data.estimateNumber.value
          : this.estimateNumber,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      subTotal: data.subTotal.present ? data.subTotal.value : this.subTotal,
      taxTotal: data.taxTotal.present ? data.taxTotal.value : this.taxTotal,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      withholdingTaxPercent: data.withholdingTaxPercent.present
          ? data.withholdingTaxPercent.value
          : this.withholdingTaxPercent,
      withholdingTaxAmount: data.withholdingTaxAmount.present
          ? data.withholdingTaxAmount.value
          : this.withholdingTaxAmount,
      tax2Percent: data.tax2Percent.present
          ? data.tax2Percent.value
          : this.tax2Percent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EstimatesTblData(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('estimateNumber: $estimateNumber, ')
          ..write('issueDate: $issueDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('subTotal: $subTotal, ')
          ..write('taxTotal: $taxTotal, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('withholdingTaxPercent: $withholdingTaxPercent, ')
          ..write('withholdingTaxAmount: $withholdingTaxAmount, ')
          ..write('tax2Percent: $tax2Percent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    estimateNumber,
    issueDate,
    expiryDate,
    subTotal,
    taxTotal,
    totalAmount,
    status,
    notes,
    createdAt,
    discountPercent,
    discountAmount,
    withholdingTaxPercent,
    withholdingTaxAmount,
    tax2Percent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EstimatesTblData &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.estimateNumber == this.estimateNumber &&
          other.issueDate == this.issueDate &&
          other.expiryDate == this.expiryDate &&
          other.subTotal == this.subTotal &&
          other.taxTotal == this.taxTotal &&
          other.totalAmount == this.totalAmount &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.discountPercent == this.discountPercent &&
          other.discountAmount == this.discountAmount &&
          other.withholdingTaxPercent == this.withholdingTaxPercent &&
          other.withholdingTaxAmount == this.withholdingTaxAmount &&
          other.tax2Percent == this.tax2Percent);
}

class EstimatesTblCompanion extends UpdateCompanion<EstimatesTblData> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> estimateNumber;
  final Value<DateTime> issueDate;
  final Value<DateTime> expiryDate;
  final Value<double> subTotal;
  final Value<double> taxTotal;
  final Value<double> totalAmount;
  final Value<String> status;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<double> discountPercent;
  final Value<double> discountAmount;
  final Value<double> withholdingTaxPercent;
  final Value<double> withholdingTaxAmount;
  final Value<double> tax2Percent;
  final Value<int> rowid;
  const EstimatesTblCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.estimateNumber = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.subTotal = const Value.absent(),
    this.taxTotal = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.withholdingTaxPercent = const Value.absent(),
    this.withholdingTaxAmount = const Value.absent(),
    this.tax2Percent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EstimatesTblCompanion.insert({
    required String id,
    required String clientId,
    required String estimateNumber,
    required DateTime issueDate,
    required DateTime expiryDate,
    required double subTotal,
    required double taxTotal,
    required double totalAmount,
    required String status,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.discountPercent = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.withholdingTaxPercent = const Value.absent(),
    this.withholdingTaxAmount = const Value.absent(),
    this.tax2Percent = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       estimateNumber = Value(estimateNumber),
       issueDate = Value(issueDate),
       expiryDate = Value(expiryDate),
       subTotal = Value(subTotal),
       taxTotal = Value(taxTotal),
       totalAmount = Value(totalAmount),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<EstimatesTblData> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? estimateNumber,
    Expression<DateTime>? issueDate,
    Expression<DateTime>? expiryDate,
    Expression<double>? subTotal,
    Expression<double>? taxTotal,
    Expression<double>? totalAmount,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<double>? discountPercent,
    Expression<double>? discountAmount,
    Expression<double>? withholdingTaxPercent,
    Expression<double>? withholdingTaxAmount,
    Expression<double>? tax2Percent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (estimateNumber != null) 'estimate_number': estimateNumber,
      if (issueDate != null) 'issue_date': issueDate,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (subTotal != null) 'sub_total': subTotal,
      if (taxTotal != null) 'tax_total': taxTotal,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (withholdingTaxPercent != null)
        'withholding_tax_percent': withholdingTaxPercent,
      if (withholdingTaxAmount != null)
        'withholding_tax_amount': withholdingTaxAmount,
      if (tax2Percent != null) 'tax2_percent': tax2Percent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EstimatesTblCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String>? estimateNumber,
    Value<DateTime>? issueDate,
    Value<DateTime>? expiryDate,
    Value<double>? subTotal,
    Value<double>? taxTotal,
    Value<double>? totalAmount,
    Value<String>? status,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<double>? discountPercent,
    Value<double>? discountAmount,
    Value<double>? withholdingTaxPercent,
    Value<double>? withholdingTaxAmount,
    Value<double>? tax2Percent,
    Value<int>? rowid,
  }) {
    return EstimatesTblCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      estimateNumber: estimateNumber ?? this.estimateNumber,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      subTotal: subTotal ?? this.subTotal,
      taxTotal: taxTotal ?? this.taxTotal,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
      withholdingTaxPercent:
          withholdingTaxPercent ?? this.withholdingTaxPercent,
      withholdingTaxAmount: withholdingTaxAmount ?? this.withholdingTaxAmount,
      tax2Percent: tax2Percent ?? this.tax2Percent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (estimateNumber.present) {
      map['estimate_number'] = Variable<String>(estimateNumber.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<DateTime>(issueDate.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (subTotal.present) {
      map['sub_total'] = Variable<double>(subTotal.value);
    }
    if (taxTotal.present) {
      map['tax_total'] = Variable<double>(taxTotal.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<double>(discountPercent.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
    }
    if (withholdingTaxPercent.present) {
      map['withholding_tax_percent'] = Variable<double>(
        withholdingTaxPercent.value,
      );
    }
    if (withholdingTaxAmount.present) {
      map['withholding_tax_amount'] = Variable<double>(
        withholdingTaxAmount.value,
      );
    }
    if (tax2Percent.present) {
      map['tax2_percent'] = Variable<double>(tax2Percent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EstimatesTblCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('estimateNumber: $estimateNumber, ')
          ..write('issueDate: $issueDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('subTotal: $subTotal, ')
          ..write('taxTotal: $taxTotal, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('withholdingTaxPercent: $withholdingTaxPercent, ')
          ..write('withholdingTaxAmount: $withholdingTaxAmount, ')
          ..write('tax2Percent: $tax2Percent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EstimateItemsTblTable extends EstimateItemsTbl
    with TableInfo<$EstimateItemsTblTable, EstimateItemsTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EstimateItemsTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimateIdMeta = const VerificationMeta(
    'estimateId',
  );
  @override
  late final GeneratedColumn<String> estimateId = GeneratedColumn<String>(
    'estimate_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES estimates_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxPercentMeta = const VerificationMeta(
    'taxPercent',
  );
  @override
  late final GeneratedColumn<double> taxPercent = GeneratedColumn<double>(
    'tax_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<double> discountPercent = GeneratedColumn<double>(
    'discount_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    estimateId,
    productId,
    description,
    quantity,
    rate,
    taxPercent,
    taxAmount,
    discountPercent,
    total,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'estimate_items_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<EstimateItemsTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('estimate_id')) {
      context.handle(
        _estimateIdMeta,
        estimateId.isAcceptableOrUnknown(data['estimate_id']!, _estimateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_estimateIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('tax_percent')) {
      context.handle(
        _taxPercentMeta,
        taxPercent.isAcceptableOrUnknown(data['tax_percent']!, _taxPercentMeta),
      );
    } else if (isInserting) {
      context.missing(_taxPercentMeta);
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_taxAmountMeta);
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EstimateItemsTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EstimateItemsTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      estimateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estimate_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate'],
      )!,
      taxPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_percent'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_percent'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
    );
  }

  @override
  $EstimateItemsTblTable createAlias(String alias) {
    return $EstimateItemsTblTable(attachedDatabase, alias);
  }
}

class EstimateItemsTblData extends DataClass
    implements Insertable<EstimateItemsTblData> {
  final String id;
  final String estimateId;
  final String? productId;
  final String description;
  final int quantity;
  final double rate;
  final double taxPercent;
  final double taxAmount;
  final double discountPercent;
  final double total;
  const EstimateItemsTblData({
    required this.id,
    required this.estimateId,
    this.productId,
    required this.description,
    required this.quantity,
    required this.rate,
    required this.taxPercent,
    required this.taxAmount,
    required this.discountPercent,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['estimate_id'] = Variable<String>(estimateId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<int>(quantity);
    map['rate'] = Variable<double>(rate);
    map['tax_percent'] = Variable<double>(taxPercent);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['discount_percent'] = Variable<double>(discountPercent);
    map['total'] = Variable<double>(total);
    return map;
  }

  EstimateItemsTblCompanion toCompanion(bool nullToAbsent) {
    return EstimateItemsTblCompanion(
      id: Value(id),
      estimateId: Value(estimateId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      description: Value(description),
      quantity: Value(quantity),
      rate: Value(rate),
      taxPercent: Value(taxPercent),
      taxAmount: Value(taxAmount),
      discountPercent: Value(discountPercent),
      total: Value(total),
    );
  }

  factory EstimateItemsTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EstimateItemsTblData(
      id: serializer.fromJson<String>(json['id']),
      estimateId: serializer.fromJson<String>(json['estimateId']),
      productId: serializer.fromJson<String?>(json['productId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<int>(json['quantity']),
      rate: serializer.fromJson<double>(json['rate']),
      taxPercent: serializer.fromJson<double>(json['taxPercent']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      discountPercent: serializer.fromJson<double>(json['discountPercent']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'estimateId': serializer.toJson<String>(estimateId),
      'productId': serializer.toJson<String?>(productId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<int>(quantity),
      'rate': serializer.toJson<double>(rate),
      'taxPercent': serializer.toJson<double>(taxPercent),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'discountPercent': serializer.toJson<double>(discountPercent),
      'total': serializer.toJson<double>(total),
    };
  }

  EstimateItemsTblData copyWith({
    String? id,
    String? estimateId,
    Value<String?> productId = const Value.absent(),
    String? description,
    int? quantity,
    double? rate,
    double? taxPercent,
    double? taxAmount,
    double? discountPercent,
    double? total,
  }) => EstimateItemsTblData(
    id: id ?? this.id,
    estimateId: estimateId ?? this.estimateId,
    productId: productId.present ? productId.value : this.productId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    rate: rate ?? this.rate,
    taxPercent: taxPercent ?? this.taxPercent,
    taxAmount: taxAmount ?? this.taxAmount,
    discountPercent: discountPercent ?? this.discountPercent,
    total: total ?? this.total,
  );
  EstimateItemsTblData copyWithCompanion(EstimateItemsTblCompanion data) {
    return EstimateItemsTblData(
      id: data.id.present ? data.id.value : this.id,
      estimateId: data.estimateId.present
          ? data.estimateId.value
          : this.estimateId,
      productId: data.productId.present ? data.productId.value : this.productId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      rate: data.rate.present ? data.rate.value : this.rate,
      taxPercent: data.taxPercent.present
          ? data.taxPercent.value
          : this.taxPercent,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EstimateItemsTblData(')
          ..write('id: $id, ')
          ..write('estimateId: $estimateId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('rate: $rate, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    estimateId,
    productId,
    description,
    quantity,
    rate,
    taxPercent,
    taxAmount,
    discountPercent,
    total,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EstimateItemsTblData &&
          other.id == this.id &&
          other.estimateId == this.estimateId &&
          other.productId == this.productId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.rate == this.rate &&
          other.taxPercent == this.taxPercent &&
          other.taxAmount == this.taxAmount &&
          other.discountPercent == this.discountPercent &&
          other.total == this.total);
}

class EstimateItemsTblCompanion extends UpdateCompanion<EstimateItemsTblData> {
  final Value<String> id;
  final Value<String> estimateId;
  final Value<String?> productId;
  final Value<String> description;
  final Value<int> quantity;
  final Value<double> rate;
  final Value<double> taxPercent;
  final Value<double> taxAmount;
  final Value<double> discountPercent;
  final Value<double> total;
  final Value<int> rowid;
  const EstimateItemsTblCompanion({
    this.id = const Value.absent(),
    this.estimateId = const Value.absent(),
    this.productId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.rate = const Value.absent(),
    this.taxPercent = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EstimateItemsTblCompanion.insert({
    required String id,
    required String estimateId,
    this.productId = const Value.absent(),
    required String description,
    required int quantity,
    required double rate,
    required double taxPercent,
    required double taxAmount,
    this.discountPercent = const Value.absent(),
    required double total,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       estimateId = Value(estimateId),
       description = Value(description),
       quantity = Value(quantity),
       rate = Value(rate),
       taxPercent = Value(taxPercent),
       taxAmount = Value(taxAmount),
       total = Value(total);
  static Insertable<EstimateItemsTblData> custom({
    Expression<String>? id,
    Expression<String>? estimateId,
    Expression<String>? productId,
    Expression<String>? description,
    Expression<int>? quantity,
    Expression<double>? rate,
    Expression<double>? taxPercent,
    Expression<double>? taxAmount,
    Expression<double>? discountPercent,
    Expression<double>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estimateId != null) 'estimate_id': estimateId,
      if (productId != null) 'product_id': productId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (rate != null) 'rate': rate,
      if (taxPercent != null) 'tax_percent': taxPercent,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EstimateItemsTblCompanion copyWith({
    Value<String>? id,
    Value<String>? estimateId,
    Value<String?>? productId,
    Value<String>? description,
    Value<int>? quantity,
    Value<double>? rate,
    Value<double>? taxPercent,
    Value<double>? taxAmount,
    Value<double>? discountPercent,
    Value<double>? total,
    Value<int>? rowid,
  }) {
    return EstimateItemsTblCompanion(
      id: id ?? this.id,
      estimateId: estimateId ?? this.estimateId,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      taxPercent: taxPercent ?? this.taxPercent,
      taxAmount: taxAmount ?? this.taxAmount,
      discountPercent: discountPercent ?? this.discountPercent,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (estimateId.present) {
      map['estimate_id'] = Variable<String>(estimateId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (taxPercent.present) {
      map['tax_percent'] = Variable<double>(taxPercent.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<double>(discountPercent.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EstimateItemsTblCompanion(')
          ..write('id: $id, ')
          ..write('estimateId: $estimateId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('rate: $rate, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTblTable extends ExpensesTbl
    with TableInfo<$ExpensesTblTable, ExpensesTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients_tbl (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _isBillableMeta = const VerificationMeta(
    'isBillable',
  );
  @override
  late final GeneratedColumn<bool> isBillable = GeneratedColumn<bool>(
    'is_billable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_billable" IN (0, 1))',
    ),
  );
  static const VerificationMeta _receiptPathMeta = const VerificationMeta(
    'receiptPath',
  );
  @override
  late final GeneratedColumn<String> receiptPath = GeneratedColumn<String>(
    'receipt_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _markupPercentMeta = const VerificationMeta(
    'markupPercent',
  );
  @override
  late final GeneratedColumn<double> markupPercent = GeneratedColumn<double>(
    'markup_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices_tbl (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    description,
    amount,
    category,
    date,
    clientId,
    isBillable,
    receiptPath,
    notes,
    createdAt,
    markupPercent,
    invoiceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpensesTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    }
    if (data.containsKey('is_billable')) {
      context.handle(
        _isBillableMeta,
        isBillable.isAcceptableOrUnknown(data['is_billable']!, _isBillableMeta),
      );
    } else if (isInserting) {
      context.missing(_isBillableMeta);
    }
    if (data.containsKey('receipt_path')) {
      context.handle(
        _receiptPathMeta,
        receiptPath.isAcceptableOrUnknown(
          data['receipt_path']!,
          _receiptPathMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('markup_percent')) {
      context.handle(
        _markupPercentMeta,
        markupPercent.isAcceptableOrUnknown(
          data['markup_percent']!,
          _markupPercentMeta,
        ),
      );
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpensesTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpensesTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      ),
      isBillable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_billable'],
      )!,
      receiptPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_path'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      markupPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}markup_percent'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      ),
    );
  }

  @override
  $ExpensesTblTable createAlias(String alias) {
    return $ExpensesTblTable(attachedDatabase, alias);
  }
}

class ExpensesTblData extends DataClass implements Insertable<ExpensesTblData> {
  final String id;
  final String description;
  final double amount;
  final String category;
  final DateTime date;
  final String? clientId;
  final bool isBillable;
  final String? receiptPath;
  final String? notes;
  final DateTime createdAt;
  final double markupPercent;
  final String? invoiceId;
  const ExpensesTblData({
    required this.id,
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
    this.clientId,
    required this.isBillable,
    this.receiptPath,
    this.notes,
    required this.createdAt,
    required this.markupPercent,
    this.invoiceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['description'] = Variable<String>(description);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
    }
    map['is_billable'] = Variable<bool>(isBillable);
    if (!nullToAbsent || receiptPath != null) {
      map['receipt_path'] = Variable<String>(receiptPath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['markup_percent'] = Variable<double>(markupPercent);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<String>(invoiceId);
    }
    return map;
  }

  ExpensesTblCompanion toCompanion(bool nullToAbsent) {
    return ExpensesTblCompanion(
      id: Value(id),
      description: Value(description),
      amount: Value(amount),
      category: Value(category),
      date: Value(date),
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
      isBillable: Value(isBillable),
      receiptPath: receiptPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptPath),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      markupPercent: Value(markupPercent),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
    );
  }

  factory ExpensesTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpensesTblData(
      id: serializer.fromJson<String>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      date: serializer.fromJson<DateTime>(json['date']),
      clientId: serializer.fromJson<String?>(json['clientId']),
      isBillable: serializer.fromJson<bool>(json['isBillable']),
      receiptPath: serializer.fromJson<String?>(json['receiptPath']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      markupPercent: serializer.fromJson<double>(json['markupPercent']),
      invoiceId: serializer.fromJson<String?>(json['invoiceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'description': serializer.toJson<String>(description),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'date': serializer.toJson<DateTime>(date),
      'clientId': serializer.toJson<String?>(clientId),
      'isBillable': serializer.toJson<bool>(isBillable),
      'receiptPath': serializer.toJson<String?>(receiptPath),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'markupPercent': serializer.toJson<double>(markupPercent),
      'invoiceId': serializer.toJson<String?>(invoiceId),
    };
  }

  ExpensesTblData copyWith({
    String? id,
    String? description,
    double? amount,
    String? category,
    DateTime? date,
    Value<String?> clientId = const Value.absent(),
    bool? isBillable,
    Value<String?> receiptPath = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    double? markupPercent,
    Value<String?> invoiceId = const Value.absent(),
  }) => ExpensesTblData(
    id: id ?? this.id,
    description: description ?? this.description,
    amount: amount ?? this.amount,
    category: category ?? this.category,
    date: date ?? this.date,
    clientId: clientId.present ? clientId.value : this.clientId,
    isBillable: isBillable ?? this.isBillable,
    receiptPath: receiptPath.present ? receiptPath.value : this.receiptPath,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    markupPercent: markupPercent ?? this.markupPercent,
    invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
  );
  ExpensesTblData copyWithCompanion(ExpensesTblCompanion data) {
    return ExpensesTblData(
      id: data.id.present ? data.id.value : this.id,
      description: data.description.present
          ? data.description.value
          : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      date: data.date.present ? data.date.value : this.date,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      isBillable: data.isBillable.present
          ? data.isBillable.value
          : this.isBillable,
      receiptPath: data.receiptPath.present
          ? data.receiptPath.value
          : this.receiptPath,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      markupPercent: data.markupPercent.present
          ? data.markupPercent.value
          : this.markupPercent,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTblData(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('clientId: $clientId, ')
          ..write('isBillable: $isBillable, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('markupPercent: $markupPercent, ')
          ..write('invoiceId: $invoiceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    description,
    amount,
    category,
    date,
    clientId,
    isBillable,
    receiptPath,
    notes,
    createdAt,
    markupPercent,
    invoiceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpensesTblData &&
          other.id == this.id &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.date == this.date &&
          other.clientId == this.clientId &&
          other.isBillable == this.isBillable &&
          other.receiptPath == this.receiptPath &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.markupPercent == this.markupPercent &&
          other.invoiceId == this.invoiceId);
}

class ExpensesTblCompanion extends UpdateCompanion<ExpensesTblData> {
  final Value<String> id;
  final Value<String> description;
  final Value<double> amount;
  final Value<String> category;
  final Value<DateTime> date;
  final Value<String?> clientId;
  final Value<bool> isBillable;
  final Value<String?> receiptPath;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<double> markupPercent;
  final Value<String?> invoiceId;
  final Value<int> rowid;
  const ExpensesTblCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.date = const Value.absent(),
    this.clientId = const Value.absent(),
    this.isBillable = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.markupPercent = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTblCompanion.insert({
    required String id,
    required String description,
    required double amount,
    required String category,
    required DateTime date,
    this.clientId = const Value.absent(),
    required bool isBillable,
    this.receiptPath = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.markupPercent = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       description = Value(description),
       amount = Value(amount),
       category = Value(category),
       date = Value(date),
       isBillable = Value(isBillable),
       createdAt = Value(createdAt);
  static Insertable<ExpensesTblData> custom({
    Expression<String>? id,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<DateTime>? date,
    Expression<String>? clientId,
    Expression<bool>? isBillable,
    Expression<String>? receiptPath,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<double>? markupPercent,
    Expression<String>? invoiceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (date != null) 'date': date,
      if (clientId != null) 'client_id': clientId,
      if (isBillable != null) 'is_billable': isBillable,
      if (receiptPath != null) 'receipt_path': receiptPath,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (markupPercent != null) 'markup_percent': markupPercent,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTblCompanion copyWith({
    Value<String>? id,
    Value<String>? description,
    Value<double>? amount,
    Value<String>? category,
    Value<DateTime>? date,
    Value<String?>? clientId,
    Value<bool>? isBillable,
    Value<String?>? receiptPath,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<double>? markupPercent,
    Value<String?>? invoiceId,
    Value<int>? rowid,
  }) {
    return ExpensesTblCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      clientId: clientId ?? this.clientId,
      isBillable: isBillable ?? this.isBillable,
      receiptPath: receiptPath ?? this.receiptPath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      markupPercent: markupPercent ?? this.markupPercent,
      invoiceId: invoiceId ?? this.invoiceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (isBillable.present) {
      map['is_billable'] = Variable<bool>(isBillable.value);
    }
    if (receiptPath.present) {
      map['receipt_path'] = Variable<String>(receiptPath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (markupPercent.present) {
      map['markup_percent'] = Variable<double>(markupPercent.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTblCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('clientId: $clientId, ')
          ..write('isBillable: $isBillable, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('markupPercent: $markupPercent, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTblTable extends PaymentsTbl
    with TableInfo<$PaymentsTblTable, PaymentsTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceNumberMeta = const VerificationMeta(
    'referenceNumber',
  );
  @override
  late final GeneratedColumn<String> referenceNumber = GeneratedColumn<String>(
    'reference_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    clientId,
    amount,
    date,
    paymentMethod,
    referenceNumber,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentsTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('reference_number')) {
      context.handle(
        _referenceNumberMeta,
        referenceNumber.isAcceptableOrUnknown(
          data['reference_number']!,
          _referenceNumberMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentsTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentsTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      referenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_number'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentsTblTable createAlias(String alias) {
    return $PaymentsTblTable(attachedDatabase, alias);
  }
}

class PaymentsTblData extends DataClass implements Insertable<PaymentsTblData> {
  final String id;
  final String invoiceId;
  final String clientId;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String? referenceNumber;
  final String? notes;
  final DateTime createdAt;
  const PaymentsTblData({
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['client_id'] = Variable<String>(clientId);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || referenceNumber != null) {
      map['reference_number'] = Variable<String>(referenceNumber);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentsTblCompanion toCompanion(bool nullToAbsent) {
    return PaymentsTblCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      clientId: Value(clientId),
      amount: Value(amount),
      date: Value(date),
      paymentMethod: Value(paymentMethod),
      referenceNumber: referenceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceNumber),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory PaymentsTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentsTblData(
      id: serializer.fromJson<String>(json['id']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      clientId: serializer.fromJson<String>(json['clientId']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      referenceNumber: serializer.fromJson<String?>(json['referenceNumber']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'clientId': serializer.toJson<String>(clientId),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'referenceNumber': serializer.toJson<String?>(referenceNumber),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PaymentsTblData copyWith({
    String? id,
    String? invoiceId,
    String? clientId,
    double? amount,
    DateTime? date,
    String? paymentMethod,
    Value<String?> referenceNumber = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => PaymentsTblData(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    clientId: clientId ?? this.clientId,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    referenceNumber: referenceNumber.present
        ? referenceNumber.value
        : this.referenceNumber,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  PaymentsTblData copyWithCompanion(PaymentsTblCompanion data) {
    return PaymentsTblData(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      referenceNumber: data.referenceNumber.present
          ? data.referenceNumber.value
          : this.referenceNumber,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTblData(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('clientId: $clientId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    clientId,
    amount,
    date,
    paymentMethod,
    referenceNumber,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentsTblData &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.clientId == this.clientId &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.paymentMethod == this.paymentMethod &&
          other.referenceNumber == this.referenceNumber &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class PaymentsTblCompanion extends UpdateCompanion<PaymentsTblData> {
  final Value<String> id;
  final Value<String> invoiceId;
  final Value<String> clientId;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String> paymentMethod;
  final Value<String?> referenceNumber;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PaymentsTblCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsTblCompanion.insert({
    required String id,
    required String invoiceId,
    required String clientId,
    required double amount,
    required DateTime date,
    required String paymentMethod,
    this.referenceNumber = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       invoiceId = Value(invoiceId),
       clientId = Value(clientId),
       amount = Value(amount),
       date = Value(date),
       paymentMethod = Value(paymentMethod),
       createdAt = Value(createdAt);
  static Insertable<PaymentsTblData> custom({
    Expression<String>? id,
    Expression<String>? invoiceId,
    Expression<String>? clientId,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? paymentMethod,
    Expression<String>? referenceNumber,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (clientId != null) 'client_id': clientId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (referenceNumber != null) 'reference_number': referenceNumber,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsTblCompanion copyWith({
    Value<String>? id,
    Value<String>? invoiceId,
    Value<String>? clientId,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<String>? paymentMethod,
    Value<String?>? referenceNumber,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PaymentsTblCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      clientId: clientId ?? this.clientId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (referenceNumber.present) {
      map['reference_number'] = Variable<String>(referenceNumber.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTblCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('clientId: $clientId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTblTable extends ProductsTbl
    with TableInfo<$ProductsTblTable, ProductsTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPriceMeta = const VerificationMeta(
    'costPrice',
  );
  @override
  late final GeneratedColumn<double> costPrice = GeneratedColumn<double>(
    'cost_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
    'selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reorderLevelMeta = const VerificationMeta(
    'reorderLevel',
  );
  @override
  late final GeneratedColumn<int> reorderLevel = GeneratedColumn<int>(
    'reorder_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    sku,
    barcode,
    description,
    category,
    costPrice,
    sellingPrice,
    quantity,
    reorderLevel,
    unit,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductsTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('cost_price')) {
      context.handle(
        _costPriceMeta,
        costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_costPriceMeta);
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('reorder_level')) {
      context.handle(
        _reorderLevelMeta,
        reorderLevel.isAcceptableOrUnknown(
          data['reorder_level']!,
          _reorderLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reorderLevelMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductsTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductsTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      costPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_price'],
      )!,
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}selling_price'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      reorderLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reorder_level'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProductsTblTable createAlias(String alias) {
    return $ProductsTblTable(attachedDatabase, alias);
  }
}

class ProductsTblData extends DataClass implements Insertable<ProductsTblData> {
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
  const ProductsTblData({
    required this.id,
    required this.name,
    this.sku,
    this.barcode,
    this.description,
    required this.category,
    required this.costPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.reorderLevel,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['category'] = Variable<String>(category);
    map['cost_price'] = Variable<double>(costPrice);
    map['selling_price'] = Variable<double>(sellingPrice);
    map['quantity'] = Variable<int>(quantity);
    map['reorder_level'] = Variable<int>(reorderLevel);
    map['unit'] = Variable<String>(unit);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsTblCompanion toCompanion(bool nullToAbsent) {
    return ProductsTblCompanion(
      id: Value(id),
      name: Value(name),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: Value(category),
      costPrice: Value(costPrice),
      sellingPrice: Value(sellingPrice),
      quantity: Value(quantity),
      reorderLevel: Value(reorderLevel),
      unit: Value(unit),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProductsTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductsTblData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sku: serializer.fromJson<String?>(json['sku']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      costPrice: serializer.fromJson<double>(json['costPrice']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      reorderLevel: serializer.fromJson<int>(json['reorderLevel']),
      unit: serializer.fromJson<String>(json['unit']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'sku': serializer.toJson<String?>(sku),
      'barcode': serializer.toJson<String?>(barcode),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String>(category),
      'costPrice': serializer.toJson<double>(costPrice),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'quantity': serializer.toJson<int>(quantity),
      'reorderLevel': serializer.toJson<int>(reorderLevel),
      'unit': serializer.toJson<String>(unit),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProductsTblData copyWith({
    String? id,
    String? name,
    Value<String?> sku = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? category,
    double? costPrice,
    double? sellingPrice,
    int? quantity,
    int? reorderLevel,
    String? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ProductsTblData(
    id: id ?? this.id,
    name: name ?? this.name,
    sku: sku.present ? sku.value : this.sku,
    barcode: barcode.present ? barcode.value : this.barcode,
    description: description.present ? description.value : this.description,
    category: category ?? this.category,
    costPrice: costPrice ?? this.costPrice,
    sellingPrice: sellingPrice ?? this.sellingPrice,
    quantity: quantity ?? this.quantity,
    reorderLevel: reorderLevel ?? this.reorderLevel,
    unit: unit ?? this.unit,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProductsTblData copyWithCompanion(ProductsTblCompanion data) {
    return ProductsTblData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sku: data.sku.present ? data.sku.value : this.sku,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      reorderLevel: data.reorderLevel.present
          ? data.reorderLevel.value
          : this.reorderLevel,
      unit: data.unit.present ? data.unit.value : this.unit,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTblData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('costPrice: $costPrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('quantity: $quantity, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('unit: $unit, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    sku,
    barcode,
    description,
    category,
    costPrice,
    sellingPrice,
    quantity,
    reorderLevel,
    unit,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsTblData &&
          other.id == this.id &&
          other.name == this.name &&
          other.sku == this.sku &&
          other.barcode == this.barcode &&
          other.description == this.description &&
          other.category == this.category &&
          other.costPrice == this.costPrice &&
          other.sellingPrice == this.sellingPrice &&
          other.quantity == this.quantity &&
          other.reorderLevel == this.reorderLevel &&
          other.unit == this.unit &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsTblCompanion extends UpdateCompanion<ProductsTblData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> sku;
  final Value<String?> barcode;
  final Value<String?> description;
  final Value<String> category;
  final Value<double> costPrice;
  final Value<double> sellingPrice;
  final Value<int> quantity;
  final Value<int> reorderLevel;
  final Value<String> unit;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductsTblCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.costPrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.reorderLevel = const Value.absent(),
    this.unit = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsTblCompanion.insert({
    required String id,
    required String name,
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.description = const Value.absent(),
    required String category,
    required double costPrice,
    required double sellingPrice,
    required int quantity,
    required int reorderLevel,
    required String unit,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       costPrice = Value(costPrice),
       sellingPrice = Value(sellingPrice),
       quantity = Value(quantity),
       reorderLevel = Value(reorderLevel),
       unit = Value(unit),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ProductsTblData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? sku,
    Expression<String>? barcode,
    Expression<String>? description,
    Expression<String>? category,
    Expression<double>? costPrice,
    Expression<double>? sellingPrice,
    Expression<int>? quantity,
    Expression<int>? reorderLevel,
    Expression<String>? unit,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sku != null) 'sku': sku,
      if (barcode != null) 'barcode': barcode,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (costPrice != null) 'cost_price': costPrice,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (quantity != null) 'quantity': quantity,
      if (reorderLevel != null) 'reorder_level': reorderLevel,
      if (unit != null) 'unit': unit,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsTblCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? sku,
    Value<String?>? barcode,
    Value<String?>? description,
    Value<String>? category,
    Value<double>? costPrice,
    Value<double>? sellingPrice,
    Value<int>? quantity,
    Value<int>? reorderLevel,
    Value<String>? unit,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProductsTblCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (costPrice.present) {
      map['cost_price'] = Variable<double>(costPrice.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (reorderLevel.present) {
      map['reorder_level'] = Variable<int>(reorderLevel.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTblCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('costPrice: $costPrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('quantity: $quantity, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('unit: $unit, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTblTable extends SuppliersTbl
    with TableInfo<$SuppliersTblTable, SuppliersTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactPersonMeta = const VerificationMeta(
    'contactPerson',
  );
  @override
  late final GeneratedColumn<String> contactPerson = GeneratedColumn<String>(
    'contact_person',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taxIdMeta = const VerificationMeta('taxId');
  @override
  late final GeneratedColumn<String> taxId = GeneratedColumn<String>(
    'tax_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    phone,
    address,
    contactPerson,
    taxId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<SuppliersTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('contact_person')) {
      context.handle(
        _contactPersonMeta,
        contactPerson.isAcceptableOrUnknown(
          data['contact_person']!,
          _contactPersonMeta,
        ),
      );
    }
    if (data.containsKey('tax_id')) {
      context.handle(
        _taxIdMeta,
        taxId.isAcceptableOrUnknown(data['tax_id']!, _taxIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SuppliersTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SuppliersTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      contactPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_person'],
      ),
      taxId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SuppliersTblTable createAlias(String alias) {
    return $SuppliersTblTable(attachedDatabase, alias);
  }
}

class SuppliersTblData extends DataClass
    implements Insertable<SuppliersTblData> {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? contactPerson;
  final String? taxId;
  final DateTime createdAt;
  const SuppliersTblData({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.contactPerson,
    this.taxId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || contactPerson != null) {
      map['contact_person'] = Variable<String>(contactPerson);
    }
    if (!nullToAbsent || taxId != null) {
      map['tax_id'] = Variable<String>(taxId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SuppliersTblCompanion toCompanion(bool nullToAbsent) {
    return SuppliersTblCompanion(
      id: Value(id),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      contactPerson: contactPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPerson),
      taxId: taxId == null && nullToAbsent
          ? const Value.absent()
          : Value(taxId),
      createdAt: Value(createdAt),
    );
  }

  factory SuppliersTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SuppliersTblData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      contactPerson: serializer.fromJson<String?>(json['contactPerson']),
      taxId: serializer.fromJson<String?>(json['taxId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'contactPerson': serializer.toJson<String?>(contactPerson),
      'taxId': serializer.toJson<String?>(taxId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SuppliersTblData copyWith({
    String? id,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> contactPerson = const Value.absent(),
    Value<String?> taxId = const Value.absent(),
    DateTime? createdAt,
  }) => SuppliersTblData(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    contactPerson: contactPerson.present
        ? contactPerson.value
        : this.contactPerson,
    taxId: taxId.present ? taxId.value : this.taxId,
    createdAt: createdAt ?? this.createdAt,
  );
  SuppliersTblData copyWithCompanion(SuppliersTblCompanion data) {
    return SuppliersTblData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      contactPerson: data.contactPerson.present
          ? data.contactPerson.value
          : this.contactPerson,
      taxId: data.taxId.present ? data.taxId.value : this.taxId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersTblData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('taxId: $taxId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    email,
    phone,
    address,
    contactPerson,
    taxId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SuppliersTblData &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.contactPerson == this.contactPerson &&
          other.taxId == this.taxId &&
          other.createdAt == this.createdAt);
}

class SuppliersTblCompanion extends UpdateCompanion<SuppliersTblData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> contactPerson;
  final Value<String?> taxId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SuppliersTblCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.contactPerson = const Value.absent(),
    this.taxId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuppliersTblCompanion.insert({
    required String id,
    required String name,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.contactPerson = const Value.absent(),
    this.taxId = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<SuppliersTblData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? contactPerson,
    Expression<String>? taxId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (contactPerson != null) 'contact_person': contactPerson,
      if (taxId != null) 'tax_id': taxId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuppliersTblCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? address,
    Value<String?>? contactPerson,
    Value<String?>? taxId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SuppliersTblCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      contactPerson: contactPerson ?? this.contactPerson,
      taxId: taxId ?? this.taxId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (contactPerson.present) {
      map['contact_person'] = Variable<String>(contactPerson.value);
    }
    if (taxId.present) {
      map['tax_id'] = Variable<String>(taxId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersTblCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('taxId: $taxId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrdersTblTable extends PurchaseOrdersTbl
    with TableInfo<$PurchaseOrdersTblTable, PurchaseOrdersTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrdersTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES suppliers_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _poNumberMeta = const VerificationMeta(
    'poNumber',
  );
  @override
  late final GeneratedColumn<String> poNumber = GeneratedColumn<String>(
    'po_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<DateTime> issueDate = GeneratedColumn<DateTime>(
    'issue_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedDateMeta = const VerificationMeta(
    'expectedDate',
  );
  @override
  late final GeneratedColumn<DateTime> expectedDate = GeneratedColumn<DateTime>(
    'expected_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subTotalMeta = const VerificationMeta(
    'subTotal',
  );
  @override
  late final GeneratedColumn<double> subTotal = GeneratedColumn<double>(
    'sub_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxTotalMeta = const VerificationMeta(
    'taxTotal',
  );
  @override
  late final GeneratedColumn<double> taxTotal = GeneratedColumn<double>(
    'tax_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    supplierId,
    poNumber,
    issueDate,
    expectedDate,
    subTotal,
    taxTotal,
    totalAmount,
    status,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_orders_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrdersTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('po_number')) {
      context.handle(
        _poNumberMeta,
        poNumber.isAcceptableOrUnknown(data['po_number']!, _poNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_poNumberMeta);
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_issueDateMeta);
    }
    if (data.containsKey('expected_date')) {
      context.handle(
        _expectedDateMeta,
        expectedDate.isAcceptableOrUnknown(
          data['expected_date']!,
          _expectedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedDateMeta);
    }
    if (data.containsKey('sub_total')) {
      context.handle(
        _subTotalMeta,
        subTotal.isAcceptableOrUnknown(data['sub_total']!, _subTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subTotalMeta);
    }
    if (data.containsKey('tax_total')) {
      context.handle(
        _taxTotalMeta,
        taxTotal.isAcceptableOrUnknown(data['tax_total']!, _taxTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_taxTotalMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrdersTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrdersTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      poNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}po_number'],
      )!,
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issue_date'],
      )!,
      expectedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_date'],
      )!,
      subTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sub_total'],
      )!,
      taxTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_total'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PurchaseOrdersTblTable createAlias(String alias) {
    return $PurchaseOrdersTblTable(attachedDatabase, alias);
  }
}

class PurchaseOrdersTblData extends DataClass
    implements Insertable<PurchaseOrdersTblData> {
  final String id;
  final String supplierId;
  final String poNumber;
  final DateTime issueDate;
  final DateTime expectedDate;
  final double subTotal;
  final double taxTotal;
  final double totalAmount;
  final String status;
  final String? notes;
  final DateTime createdAt;
  const PurchaseOrdersTblData({
    required this.id,
    required this.supplierId,
    required this.poNumber,
    required this.issueDate,
    required this.expectedDate,
    required this.subTotal,
    required this.taxTotal,
    required this.totalAmount,
    required this.status,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['supplier_id'] = Variable<String>(supplierId);
    map['po_number'] = Variable<String>(poNumber);
    map['issue_date'] = Variable<DateTime>(issueDate);
    map['expected_date'] = Variable<DateTime>(expectedDate);
    map['sub_total'] = Variable<double>(subTotal);
    map['tax_total'] = Variable<double>(taxTotal);
    map['total_amount'] = Variable<double>(totalAmount);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchaseOrdersTblCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrdersTblCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      poNumber: Value(poNumber),
      issueDate: Value(issueDate),
      expectedDate: Value(expectedDate),
      subTotal: Value(subTotal),
      taxTotal: Value(taxTotal),
      totalAmount: Value(totalAmount),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory PurchaseOrdersTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrdersTblData(
      id: serializer.fromJson<String>(json['id']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      poNumber: serializer.fromJson<String>(json['poNumber']),
      issueDate: serializer.fromJson<DateTime>(json['issueDate']),
      expectedDate: serializer.fromJson<DateTime>(json['expectedDate']),
      subTotal: serializer.fromJson<double>(json['subTotal']),
      taxTotal: serializer.fromJson<double>(json['taxTotal']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'supplierId': serializer.toJson<String>(supplierId),
      'poNumber': serializer.toJson<String>(poNumber),
      'issueDate': serializer.toJson<DateTime>(issueDate),
      'expectedDate': serializer.toJson<DateTime>(expectedDate),
      'subTotal': serializer.toJson<double>(subTotal),
      'taxTotal': serializer.toJson<double>(taxTotal),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PurchaseOrdersTblData copyWith({
    String? id,
    String? supplierId,
    String? poNumber,
    DateTime? issueDate,
    DateTime? expectedDate,
    double? subTotal,
    double? taxTotal,
    double? totalAmount,
    String? status,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => PurchaseOrdersTblData(
    id: id ?? this.id,
    supplierId: supplierId ?? this.supplierId,
    poNumber: poNumber ?? this.poNumber,
    issueDate: issueDate ?? this.issueDate,
    expectedDate: expectedDate ?? this.expectedDate,
    subTotal: subTotal ?? this.subTotal,
    taxTotal: taxTotal ?? this.taxTotal,
    totalAmount: totalAmount ?? this.totalAmount,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  PurchaseOrdersTblData copyWithCompanion(PurchaseOrdersTblCompanion data) {
    return PurchaseOrdersTblData(
      id: data.id.present ? data.id.value : this.id,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      poNumber: data.poNumber.present ? data.poNumber.value : this.poNumber,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      expectedDate: data.expectedDate.present
          ? data.expectedDate.value
          : this.expectedDate,
      subTotal: data.subTotal.present ? data.subTotal.value : this.subTotal,
      taxTotal: data.taxTotal.present ? data.taxTotal.value : this.taxTotal,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrdersTblData(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('poNumber: $poNumber, ')
          ..write('issueDate: $issueDate, ')
          ..write('expectedDate: $expectedDate, ')
          ..write('subTotal: $subTotal, ')
          ..write('taxTotal: $taxTotal, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    supplierId,
    poNumber,
    issueDate,
    expectedDate,
    subTotal,
    taxTotal,
    totalAmount,
    status,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrdersTblData &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.poNumber == this.poNumber &&
          other.issueDate == this.issueDate &&
          other.expectedDate == this.expectedDate &&
          other.subTotal == this.subTotal &&
          other.taxTotal == this.taxTotal &&
          other.totalAmount == this.totalAmount &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class PurchaseOrdersTblCompanion
    extends UpdateCompanion<PurchaseOrdersTblData> {
  final Value<String> id;
  final Value<String> supplierId;
  final Value<String> poNumber;
  final Value<DateTime> issueDate;
  final Value<DateTime> expectedDate;
  final Value<double> subTotal;
  final Value<double> taxTotal;
  final Value<double> totalAmount;
  final Value<String> status;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PurchaseOrdersTblCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.poNumber = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.expectedDate = const Value.absent(),
    this.subTotal = const Value.absent(),
    this.taxTotal = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseOrdersTblCompanion.insert({
    required String id,
    required String supplierId,
    required String poNumber,
    required DateTime issueDate,
    required DateTime expectedDate,
    required double subTotal,
    required double taxTotal,
    required double totalAmount,
    required String status,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       supplierId = Value(supplierId),
       poNumber = Value(poNumber),
       issueDate = Value(issueDate),
       expectedDate = Value(expectedDate),
       subTotal = Value(subTotal),
       taxTotal = Value(taxTotal),
       totalAmount = Value(totalAmount),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<PurchaseOrdersTblData> custom({
    Expression<String>? id,
    Expression<String>? supplierId,
    Expression<String>? poNumber,
    Expression<DateTime>? issueDate,
    Expression<DateTime>? expectedDate,
    Expression<double>? subTotal,
    Expression<double>? taxTotal,
    Expression<double>? totalAmount,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (poNumber != null) 'po_number': poNumber,
      if (issueDate != null) 'issue_date': issueDate,
      if (expectedDate != null) 'expected_date': expectedDate,
      if (subTotal != null) 'sub_total': subTotal,
      if (taxTotal != null) 'tax_total': taxTotal,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseOrdersTblCompanion copyWith({
    Value<String>? id,
    Value<String>? supplierId,
    Value<String>? poNumber,
    Value<DateTime>? issueDate,
    Value<DateTime>? expectedDate,
    Value<double>? subTotal,
    Value<double>? taxTotal,
    Value<double>? totalAmount,
    Value<String>? status,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PurchaseOrdersTblCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      poNumber: poNumber ?? this.poNumber,
      issueDate: issueDate ?? this.issueDate,
      expectedDate: expectedDate ?? this.expectedDate,
      subTotal: subTotal ?? this.subTotal,
      taxTotal: taxTotal ?? this.taxTotal,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (poNumber.present) {
      map['po_number'] = Variable<String>(poNumber.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<DateTime>(issueDate.value);
    }
    if (expectedDate.present) {
      map['expected_date'] = Variable<DateTime>(expectedDate.value);
    }
    if (subTotal.present) {
      map['sub_total'] = Variable<double>(subTotal.value);
    }
    if (taxTotal.present) {
      map['tax_total'] = Variable<double>(taxTotal.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrdersTblCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('poNumber: $poNumber, ')
          ..write('issueDate: $issueDate, ')
          ..write('expectedDate: $expectedDate, ')
          ..write('subTotal: $subTotal, ')
          ..write('taxTotal: $taxTotal, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PoItemsTblTable extends PoItemsTbl
    with TableInfo<$PoItemsTblTable, PoItemsTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PoItemsTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseOrderIdMeta = const VerificationMeta(
    'purchaseOrderId',
  );
  @override
  late final GeneratedColumn<String> purchaseOrderId = GeneratedColumn<String>(
    'purchase_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchase_orders_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedQtyMeta = const VerificationMeta(
    'receivedQty',
  );
  @override
  late final GeneratedColumn<int> receivedQty = GeneratedColumn<int>(
    'received_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxPercentMeta = const VerificationMeta(
    'taxPercent',
  );
  @override
  late final GeneratedColumn<double> taxPercent = GeneratedColumn<double>(
    'tax_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseOrderId,
    productId,
    description,
    quantity,
    receivedQty,
    unitPrice,
    taxPercent,
    taxAmount,
    total,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'po_items_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<PoItemsTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('purchase_order_id')) {
      context.handle(
        _purchaseOrderIdMeta,
        purchaseOrderId.isAcceptableOrUnknown(
          data['purchase_order_id']!,
          _purchaseOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseOrderIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('received_qty')) {
      context.handle(
        _receivedQtyMeta,
        receivedQty.isAcceptableOrUnknown(
          data['received_qty']!,
          _receivedQtyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_receivedQtyMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('tax_percent')) {
      context.handle(
        _taxPercentMeta,
        taxPercent.isAcceptableOrUnknown(data['tax_percent']!, _taxPercentMeta),
      );
    } else if (isInserting) {
      context.missing(_taxPercentMeta);
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_taxAmountMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PoItemsTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PoItemsTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      purchaseOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_order_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      receivedQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}received_qty'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      taxPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_percent'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
    );
  }

  @override
  $PoItemsTblTable createAlias(String alias) {
    return $PoItemsTblTable(attachedDatabase, alias);
  }
}

class PoItemsTblData extends DataClass implements Insertable<PoItemsTblData> {
  final String id;
  final String purchaseOrderId;
  final String? productId;
  final String description;
  final int quantity;
  final int receivedQty;
  final double unitPrice;
  final double taxPercent;
  final double taxAmount;
  final double total;
  const PoItemsTblData({
    required this.id,
    required this.purchaseOrderId,
    this.productId,
    required this.description,
    required this.quantity,
    required this.receivedQty,
    required this.unitPrice,
    required this.taxPercent,
    required this.taxAmount,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['purchase_order_id'] = Variable<String>(purchaseOrderId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<int>(quantity);
    map['received_qty'] = Variable<int>(receivedQty);
    map['unit_price'] = Variable<double>(unitPrice);
    map['tax_percent'] = Variable<double>(taxPercent);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['total'] = Variable<double>(total);
    return map;
  }

  PoItemsTblCompanion toCompanion(bool nullToAbsent) {
    return PoItemsTblCompanion(
      id: Value(id),
      purchaseOrderId: Value(purchaseOrderId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      description: Value(description),
      quantity: Value(quantity),
      receivedQty: Value(receivedQty),
      unitPrice: Value(unitPrice),
      taxPercent: Value(taxPercent),
      taxAmount: Value(taxAmount),
      total: Value(total),
    );
  }

  factory PoItemsTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PoItemsTblData(
      id: serializer.fromJson<String>(json['id']),
      purchaseOrderId: serializer.fromJson<String>(json['purchaseOrderId']),
      productId: serializer.fromJson<String?>(json['productId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<int>(json['quantity']),
      receivedQty: serializer.fromJson<int>(json['receivedQty']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      taxPercent: serializer.fromJson<double>(json['taxPercent']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'purchaseOrderId': serializer.toJson<String>(purchaseOrderId),
      'productId': serializer.toJson<String?>(productId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<int>(quantity),
      'receivedQty': serializer.toJson<int>(receivedQty),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'taxPercent': serializer.toJson<double>(taxPercent),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'total': serializer.toJson<double>(total),
    };
  }

  PoItemsTblData copyWith({
    String? id,
    String? purchaseOrderId,
    Value<String?> productId = const Value.absent(),
    String? description,
    int? quantity,
    int? receivedQty,
    double? unitPrice,
    double? taxPercent,
    double? taxAmount,
    double? total,
  }) => PoItemsTblData(
    id: id ?? this.id,
    purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
    productId: productId.present ? productId.value : this.productId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    receivedQty: receivedQty ?? this.receivedQty,
    unitPrice: unitPrice ?? this.unitPrice,
    taxPercent: taxPercent ?? this.taxPercent,
    taxAmount: taxAmount ?? this.taxAmount,
    total: total ?? this.total,
  );
  PoItemsTblData copyWithCompanion(PoItemsTblCompanion data) {
    return PoItemsTblData(
      id: data.id.present ? data.id.value : this.id,
      purchaseOrderId: data.purchaseOrderId.present
          ? data.purchaseOrderId.value
          : this.purchaseOrderId,
      productId: data.productId.present ? data.productId.value : this.productId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      receivedQty: data.receivedQty.present
          ? data.receivedQty.value
          : this.receivedQty,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      taxPercent: data.taxPercent.present
          ? data.taxPercent.value
          : this.taxPercent,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PoItemsTblData(')
          ..write('id: $id, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('receivedQty: $receivedQty, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseOrderId,
    productId,
    description,
    quantity,
    receivedQty,
    unitPrice,
    taxPercent,
    taxAmount,
    total,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PoItemsTblData &&
          other.id == this.id &&
          other.purchaseOrderId == this.purchaseOrderId &&
          other.productId == this.productId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.receivedQty == this.receivedQty &&
          other.unitPrice == this.unitPrice &&
          other.taxPercent == this.taxPercent &&
          other.taxAmount == this.taxAmount &&
          other.total == this.total);
}

class PoItemsTblCompanion extends UpdateCompanion<PoItemsTblData> {
  final Value<String> id;
  final Value<String> purchaseOrderId;
  final Value<String?> productId;
  final Value<String> description;
  final Value<int> quantity;
  final Value<int> receivedQty;
  final Value<double> unitPrice;
  final Value<double> taxPercent;
  final Value<double> taxAmount;
  final Value<double> total;
  final Value<int> rowid;
  const PoItemsTblCompanion({
    this.id = const Value.absent(),
    this.purchaseOrderId = const Value.absent(),
    this.productId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.receivedQty = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.taxPercent = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PoItemsTblCompanion.insert({
    required String id,
    required String purchaseOrderId,
    this.productId = const Value.absent(),
    required String description,
    required int quantity,
    required int receivedQty,
    required double unitPrice,
    required double taxPercent,
    required double taxAmount,
    required double total,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       purchaseOrderId = Value(purchaseOrderId),
       description = Value(description),
       quantity = Value(quantity),
       receivedQty = Value(receivedQty),
       unitPrice = Value(unitPrice),
       taxPercent = Value(taxPercent),
       taxAmount = Value(taxAmount),
       total = Value(total);
  static Insertable<PoItemsTblData> custom({
    Expression<String>? id,
    Expression<String>? purchaseOrderId,
    Expression<String>? productId,
    Expression<String>? description,
    Expression<int>? quantity,
    Expression<int>? receivedQty,
    Expression<double>? unitPrice,
    Expression<double>? taxPercent,
    Expression<double>? taxAmount,
    Expression<double>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseOrderId != null) 'purchase_order_id': purchaseOrderId,
      if (productId != null) 'product_id': productId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (receivedQty != null) 'received_qty': receivedQty,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (taxPercent != null) 'tax_percent': taxPercent,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PoItemsTblCompanion copyWith({
    Value<String>? id,
    Value<String>? purchaseOrderId,
    Value<String?>? productId,
    Value<String>? description,
    Value<int>? quantity,
    Value<int>? receivedQty,
    Value<double>? unitPrice,
    Value<double>? taxPercent,
    Value<double>? taxAmount,
    Value<double>? total,
    Value<int>? rowid,
  }) {
    return PoItemsTblCompanion(
      id: id ?? this.id,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      receivedQty: receivedQty ?? this.receivedQty,
      unitPrice: unitPrice ?? this.unitPrice,
      taxPercent: taxPercent ?? this.taxPercent,
      taxAmount: taxAmount ?? this.taxAmount,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (purchaseOrderId.present) {
      map['purchase_order_id'] = Variable<String>(purchaseOrderId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (receivedQty.present) {
      map['received_qty'] = Variable<int>(receivedQty.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (taxPercent.present) {
      map['tax_percent'] = Variable<double>(taxPercent.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PoItemsTblCompanion(')
          ..write('id: $id, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('receivedQty: $receivedQty, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimeEntriesTblTable extends TimeEntriesTbl
    with TableInfo<$TimeEntriesTblTable, TimeEntriesTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeEntriesTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _taskNameMeta = const VerificationMeta(
    'taskName',
  );
  @override
  late final GeneratedColumn<String> taskName = GeneratedColumn<String>(
    'task_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hoursMeta = const VerificationMeta('hours');
  @override
  late final GeneratedColumn<double> hours = GeneratedColumn<double>(
    'hours',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isBillableMeta = const VerificationMeta(
    'isBillable',
  );
  @override
  late final GeneratedColumn<bool> isBillable = GeneratedColumn<bool>(
    'is_billable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_billable" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isInvoicedMeta = const VerificationMeta(
    'isInvoiced',
  );
  @override
  late final GeneratedColumn<bool> isInvoiced = GeneratedColumn<bool>(
    'is_invoiced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_invoiced" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    taskName,
    description,
    date,
    hours,
    rate,
    isBillable,
    isInvoiced,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_entries_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeEntriesTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('task_name')) {
      context.handle(
        _taskNameMeta,
        taskName.isAcceptableOrUnknown(data['task_name']!, _taskNameMeta),
      );
    } else if (isInserting) {
      context.missing(_taskNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('hours')) {
      context.handle(
        _hoursMeta,
        hours.isAcceptableOrUnknown(data['hours']!, _hoursMeta),
      );
    } else if (isInserting) {
      context.missing(_hoursMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('is_billable')) {
      context.handle(
        _isBillableMeta,
        isBillable.isAcceptableOrUnknown(data['is_billable']!, _isBillableMeta),
      );
    } else if (isInserting) {
      context.missing(_isBillableMeta);
    }
    if (data.containsKey('is_invoiced')) {
      context.handle(
        _isInvoicedMeta,
        isInvoiced.isAcceptableOrUnknown(data['is_invoiced']!, _isInvoicedMeta),
      );
    } else if (isInserting) {
      context.missing(_isInvoicedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeEntriesTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeEntriesTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      taskName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      hours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hours'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate'],
      )!,
      isBillable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_billable'],
      )!,
      isInvoiced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_invoiced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TimeEntriesTblTable createAlias(String alias) {
    return $TimeEntriesTblTable(attachedDatabase, alias);
  }
}

class TimeEntriesTblData extends DataClass
    implements Insertable<TimeEntriesTblData> {
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
  const TimeEntriesTblData({
    required this.id,
    required this.clientId,
    required this.taskName,
    required this.description,
    required this.date,
    required this.hours,
    required this.rate,
    required this.isBillable,
    required this.isInvoiced,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    map['task_name'] = Variable<String>(taskName);
    map['description'] = Variable<String>(description);
    map['date'] = Variable<DateTime>(date);
    map['hours'] = Variable<double>(hours);
    map['rate'] = Variable<double>(rate);
    map['is_billable'] = Variable<bool>(isBillable);
    map['is_invoiced'] = Variable<bool>(isInvoiced);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TimeEntriesTblCompanion toCompanion(bool nullToAbsent) {
    return TimeEntriesTblCompanion(
      id: Value(id),
      clientId: Value(clientId),
      taskName: Value(taskName),
      description: Value(description),
      date: Value(date),
      hours: Value(hours),
      rate: Value(rate),
      isBillable: Value(isBillable),
      isInvoiced: Value(isInvoiced),
      createdAt: Value(createdAt),
    );
  }

  factory TimeEntriesTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeEntriesTblData(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      taskName: serializer.fromJson<String>(json['taskName']),
      description: serializer.fromJson<String>(json['description']),
      date: serializer.fromJson<DateTime>(json['date']),
      hours: serializer.fromJson<double>(json['hours']),
      rate: serializer.fromJson<double>(json['rate']),
      isBillable: serializer.fromJson<bool>(json['isBillable']),
      isInvoiced: serializer.fromJson<bool>(json['isInvoiced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'taskName': serializer.toJson<String>(taskName),
      'description': serializer.toJson<String>(description),
      'date': serializer.toJson<DateTime>(date),
      'hours': serializer.toJson<double>(hours),
      'rate': serializer.toJson<double>(rate),
      'isBillable': serializer.toJson<bool>(isBillable),
      'isInvoiced': serializer.toJson<bool>(isInvoiced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TimeEntriesTblData copyWith({
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
  }) => TimeEntriesTblData(
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
  TimeEntriesTblData copyWithCompanion(TimeEntriesTblCompanion data) {
    return TimeEntriesTblData(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      taskName: data.taskName.present ? data.taskName.value : this.taskName,
      description: data.description.present
          ? data.description.value
          : this.description,
      date: data.date.present ? data.date.value : this.date,
      hours: data.hours.present ? data.hours.value : this.hours,
      rate: data.rate.present ? data.rate.value : this.rate,
      isBillable: data.isBillable.present
          ? data.isBillable.value
          : this.isBillable,
      isInvoiced: data.isInvoiced.present
          ? data.isInvoiced.value
          : this.isInvoiced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntriesTblData(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('taskName: $taskName, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('hours: $hours, ')
          ..write('rate: $rate, ')
          ..write('isBillable: $isBillable, ')
          ..write('isInvoiced: $isInvoiced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    taskName,
    description,
    date,
    hours,
    rate,
    isBillable,
    isInvoiced,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeEntriesTblData &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.taskName == this.taskName &&
          other.description == this.description &&
          other.date == this.date &&
          other.hours == this.hours &&
          other.rate == this.rate &&
          other.isBillable == this.isBillable &&
          other.isInvoiced == this.isInvoiced &&
          other.createdAt == this.createdAt);
}

class TimeEntriesTblCompanion extends UpdateCompanion<TimeEntriesTblData> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> taskName;
  final Value<String> description;
  final Value<DateTime> date;
  final Value<double> hours;
  final Value<double> rate;
  final Value<bool> isBillable;
  final Value<bool> isInvoiced;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TimeEntriesTblCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.taskName = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.hours = const Value.absent(),
    this.rate = const Value.absent(),
    this.isBillable = const Value.absent(),
    this.isInvoiced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimeEntriesTblCompanion.insert({
    required String id,
    required String clientId,
    required String taskName,
    required String description,
    required DateTime date,
    required double hours,
    required double rate,
    required bool isBillable,
    required bool isInvoiced,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       taskName = Value(taskName),
       description = Value(description),
       date = Value(date),
       hours = Value(hours),
       rate = Value(rate),
       isBillable = Value(isBillable),
       isInvoiced = Value(isInvoiced),
       createdAt = Value(createdAt);
  static Insertable<TimeEntriesTblData> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? taskName,
    Expression<String>? description,
    Expression<DateTime>? date,
    Expression<double>? hours,
    Expression<double>? rate,
    Expression<bool>? isBillable,
    Expression<bool>? isInvoiced,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (taskName != null) 'task_name': taskName,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (hours != null) 'hours': hours,
      if (rate != null) 'rate': rate,
      if (isBillable != null) 'is_billable': isBillable,
      if (isInvoiced != null) 'is_invoiced': isInvoiced,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimeEntriesTblCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String>? taskName,
    Value<String>? description,
    Value<DateTime>? date,
    Value<double>? hours,
    Value<double>? rate,
    Value<bool>? isBillable,
    Value<bool>? isInvoiced,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TimeEntriesTblCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (taskName.present) {
      map['task_name'] = Variable<String>(taskName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (hours.present) {
      map['hours'] = Variable<double>(hours.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (isBillable.present) {
      map['is_billable'] = Variable<bool>(isBillable.value);
    }
    if (isInvoiced.present) {
      map['is_invoiced'] = Variable<bool>(isInvoiced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntriesTblCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('taskName: $taskName, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('hours: $hours, ')
          ..write('rate: $rate, ')
          ..write('isBillable: $isBillable, ')
          ..write('isInvoiced: $isInvoiced, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurringProfilesTblTable extends RecurringProfilesTbl
    with TableInfo<$RecurringProfilesTblTable, RecurringProfilesTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringProfilesTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextIssueDateMeta = const VerificationMeta(
    'nextIssueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextIssueDate =
      GeneratedColumn<DateTime>(
        'next_issue_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    frequency,
    startDate,
    endDate,
    nextIssueDate,
    amount,
    description,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_profiles_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringProfilesTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('next_issue_date')) {
      context.handle(
        _nextIssueDateMeta,
        nextIssueDate.isAcceptableOrUnknown(
          data['next_issue_date']!,
          _nextIssueDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextIssueDateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringProfilesTblData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringProfilesTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      nextIssueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_issue_date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RecurringProfilesTblTable createAlias(String alias) {
    return $RecurringProfilesTblTable(attachedDatabase, alias);
  }
}

class RecurringProfilesTblData extends DataClass
    implements Insertable<RecurringProfilesTblData> {
  final String id;
  final String clientId;
  final String frequency;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime nextIssueDate;
  final double amount;
  final String description;
  final bool isActive;
  final DateTime createdAt;
  const RecurringProfilesTblData({
    required this.id,
    required this.clientId,
    required this.frequency,
    this.startDate,
    this.endDate,
    required this.nextIssueDate,
    required this.amount,
    required this.description,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['next_issue_date'] = Variable<DateTime>(nextIssueDate);
    map['amount'] = Variable<double>(amount);
    map['description'] = Variable<String>(description);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecurringProfilesTblCompanion toCompanion(bool nullToAbsent) {
    return RecurringProfilesTblCompanion(
      id: Value(id),
      clientId: Value(clientId),
      frequency: Value(frequency),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      nextIssueDate: Value(nextIssueDate),
      amount: Value(amount),
      description: Value(description),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory RecurringProfilesTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringProfilesTblData(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      frequency: serializer.fromJson<String>(json['frequency']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      nextIssueDate: serializer.fromJson<DateTime>(json['nextIssueDate']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'frequency': serializer.toJson<String>(frequency),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'nextIssueDate': serializer.toJson<DateTime>(nextIssueDate),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecurringProfilesTblData copyWith({
    String? id,
    String? clientId,
    String? frequency,
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    DateTime? nextIssueDate,
    double? amount,
    String? description,
    bool? isActive,
    DateTime? createdAt,
  }) => RecurringProfilesTblData(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    frequency: frequency ?? this.frequency,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    nextIssueDate: nextIssueDate ?? this.nextIssueDate,
    amount: amount ?? this.amount,
    description: description ?? this.description,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  RecurringProfilesTblData copyWithCompanion(
    RecurringProfilesTblCompanion data,
  ) {
    return RecurringProfilesTblData(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      nextIssueDate: data.nextIssueDate.present
          ? data.nextIssueDate.value
          : this.nextIssueDate,
      amount: data.amount.present ? data.amount.value : this.amount,
      description: data.description.present
          ? data.description.value
          : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringProfilesTblData(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('frequency: $frequency, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('nextIssueDate: $nextIssueDate, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    frequency,
    startDate,
    endDate,
    nextIssueDate,
    amount,
    description,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringProfilesTblData &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.frequency == this.frequency &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.nextIssueDate == this.nextIssueDate &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class RecurringProfilesTblCompanion
    extends UpdateCompanion<RecurringProfilesTblData> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> frequency;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<DateTime> nextIssueDate;
  final Value<double> amount;
  final Value<String> description;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RecurringProfilesTblCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.frequency = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.nextIssueDate = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurringProfilesTblCompanion.insert({
    required String id,
    required String clientId,
    required String frequency,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    required DateTime nextIssueDate,
    required double amount,
    required String description,
    required bool isActive,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       frequency = Value(frequency),
       nextIssueDate = Value(nextIssueDate),
       amount = Value(amount),
       description = Value(description),
       isActive = Value(isActive),
       createdAt = Value(createdAt);
  static Insertable<RecurringProfilesTblData> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? frequency,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<DateTime>? nextIssueDate,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (frequency != null) 'frequency': frequency,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (nextIssueDate != null) 'next_issue_date': nextIssueDate,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurringProfilesTblCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String>? frequency,
    Value<DateTime?>? startDate,
    Value<DateTime?>? endDate,
    Value<DateTime>? nextIssueDate,
    Value<double>? amount,
    Value<String>? description,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RecurringProfilesTblCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      nextIssueDate: nextIssueDate ?? this.nextIssueDate,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (nextIssueDate.present) {
      map['next_issue_date'] = Variable<DateTime>(nextIssueDate.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringProfilesTblCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('frequency: $frequency, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('nextIssueDate: $nextIssueDate, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTblTable extends StockMovementsTbl
    with TableInfo<$StockMovementsTblTable, StockMovementsTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityChangeMeta = const VerificationMeta(
    'quantityChange',
  );
  @override
  late final GeneratedColumn<int> quantityChange = GeneratedColumn<int>(
    'quantity_change',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceAfterMeta = const VerificationMeta(
    'balanceAfter',
  );
  @override
  late final GeneratedColumn<int> balanceAfter = GeneratedColumn<int>(
    'balance_after',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceNumberMeta = const VerificationMeta(
    'referenceNumber',
  );
  @override
  late final GeneratedColumn<String> referenceNumber = GeneratedColumn<String>(
    'reference_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    productName,
    quantityChange,
    balanceAfter,
    type,
    referenceNumber,
    referenceId,
    description,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockMovementsTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('quantity_change')) {
      context.handle(
        _quantityChangeMeta,
        quantityChange.isAcceptableOrUnknown(
          data['quantity_change']!,
          _quantityChangeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantityChangeMeta);
    }
    if (data.containsKey('balance_after')) {
      context.handle(
        _balanceAfterMeta,
        balanceAfter.isAcceptableOrUnknown(
          data['balance_after']!,
          _balanceAfterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_balanceAfterMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('reference_number')) {
      context.handle(
        _referenceNumberMeta,
        referenceNumber.isAcceptableOrUnknown(
          data['reference_number']!,
          _referenceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceNumberMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovementsTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovementsTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      quantityChange: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity_change'],
      )!,
      balanceAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_after'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      referenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_number'],
      )!,
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StockMovementsTblTable createAlias(String alias) {
    return $StockMovementsTblTable(attachedDatabase, alias);
  }
}

class StockMovementsTblData extends DataClass
    implements Insertable<StockMovementsTblData> {
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
  const StockMovementsTblData({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantityChange,
    required this.balanceAfter,
    required this.type,
    required this.referenceNumber,
    this.referenceId,
    required this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['product_name'] = Variable<String>(productName);
    map['quantity_change'] = Variable<int>(quantityChange);
    map['balance_after'] = Variable<int>(balanceAfter);
    map['type'] = Variable<String>(type);
    map['reference_number'] = Variable<String>(referenceNumber);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StockMovementsTblCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsTblCompanion(
      id: Value(id),
      productId: Value(productId),
      productName: Value(productName),
      quantityChange: Value(quantityChange),
      balanceAfter: Value(balanceAfter),
      type: Value(type),
      referenceNumber: Value(referenceNumber),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      description: Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory StockMovementsTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovementsTblData(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      quantityChange: serializer.fromJson<int>(json['quantityChange']),
      balanceAfter: serializer.fromJson<int>(json['balanceAfter']),
      type: serializer.fromJson<String>(json['type']),
      referenceNumber: serializer.fromJson<String>(json['referenceNumber']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'productName': serializer.toJson<String>(productName),
      'quantityChange': serializer.toJson<int>(quantityChange),
      'balanceAfter': serializer.toJson<int>(balanceAfter),
      'type': serializer.toJson<String>(type),
      'referenceNumber': serializer.toJson<String>(referenceNumber),
      'referenceId': serializer.toJson<String?>(referenceId),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StockMovementsTblData copyWith({
    String? id,
    String? productId,
    String? productName,
    int? quantityChange,
    int? balanceAfter,
    String? type,
    String? referenceNumber,
    Value<String?> referenceId = const Value.absent(),
    String? description,
    DateTime? createdAt,
  }) => StockMovementsTblData(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    quantityChange: quantityChange ?? this.quantityChange,
    balanceAfter: balanceAfter ?? this.balanceAfter,
    type: type ?? this.type,
    referenceNumber: referenceNumber ?? this.referenceNumber,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  StockMovementsTblData copyWithCompanion(StockMovementsTblCompanion data) {
    return StockMovementsTblData(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      quantityChange: data.quantityChange.present
          ? data.quantityChange.value
          : this.quantityChange,
      balanceAfter: data.balanceAfter.present
          ? data.balanceAfter.value
          : this.balanceAfter,
      type: data.type.present ? data.type.value : this.type,
      referenceNumber: data.referenceNumber.present
          ? data.referenceNumber.value
          : this.referenceNumber,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsTblData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantityChange: $quantityChange, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('type: $type, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('referenceId: $referenceId, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    productName,
    quantityChange,
    balanceAfter,
    type,
    referenceNumber,
    referenceId,
    description,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovementsTblData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.quantityChange == this.quantityChange &&
          other.balanceAfter == this.balanceAfter &&
          other.type == this.type &&
          other.referenceNumber == this.referenceNumber &&
          other.referenceId == this.referenceId &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class StockMovementsTblCompanion
    extends UpdateCompanion<StockMovementsTblData> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String> productName;
  final Value<int> quantityChange;
  final Value<int> balanceAfter;
  final Value<String> type;
  final Value<String> referenceNumber;
  final Value<String?> referenceId;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StockMovementsTblCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.quantityChange = const Value.absent(),
    this.balanceAfter = const Value.absent(),
    this.type = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockMovementsTblCompanion.insert({
    required String id,
    required String productId,
    required String productName,
    required int quantityChange,
    required int balanceAfter,
    required String type,
    required String referenceNumber,
    this.referenceId = const Value.absent(),
    required String description,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       productId = Value(productId),
       productName = Value(productName),
       quantityChange = Value(quantityChange),
       balanceAfter = Value(balanceAfter),
       type = Value(type),
       referenceNumber = Value(referenceNumber),
       description = Value(description),
       createdAt = Value(createdAt);
  static Insertable<StockMovementsTblData> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? productName,
    Expression<int>? quantityChange,
    Expression<int>? balanceAfter,
    Expression<String>? type,
    Expression<String>? referenceNumber,
    Expression<String>? referenceId,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (quantityChange != null) 'quantity_change': quantityChange,
      if (balanceAfter != null) 'balance_after': balanceAfter,
      if (type != null) 'type': type,
      if (referenceNumber != null) 'reference_number': referenceNumber,
      if (referenceId != null) 'reference_id': referenceId,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockMovementsTblCompanion copyWith({
    Value<String>? id,
    Value<String>? productId,
    Value<String>? productName,
    Value<int>? quantityChange,
    Value<int>? balanceAfter,
    Value<String>? type,
    Value<String>? referenceNumber,
    Value<String?>? referenceId,
    Value<String>? description,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return StockMovementsTblCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantityChange: quantityChange ?? this.quantityChange,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      type: type ?? this.type,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      referenceId: referenceId ?? this.referenceId,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (quantityChange.present) {
      map['quantity_change'] = Variable<int>(quantityChange.value);
    }
    if (balanceAfter.present) {
      map['balance_after'] = Variable<int>(balanceAfter.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (referenceNumber.present) {
      map['reference_number'] = Variable<String>(referenceNumber.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsTblCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantityChange: $quantityChange, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('type: $type, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('referenceId: $referenceId, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTblTable extends AppSettingsTbl
    with TableInfo<$AppSettingsTblTable, AppSettingsTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSettingsTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsTblData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTblTable createAlias(String alias) {
    return $AppSettingsTblTable(attachedDatabase, alias);
  }
}

class AppSettingsTblData extends DataClass
    implements Insertable<AppSettingsTblData> {
  final String key;
  final String value;
  const AppSettingsTblData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsTblCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTblCompanion(key: Value(key), value: Value(value));
  }

  factory AppSettingsTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsTblData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSettingsTblData copyWith({String? key, String? value}) =>
      AppSettingsTblData(key: key ?? this.key, value: value ?? this.value);
  AppSettingsTblData copyWithCompanion(AppSettingsTblCompanion data) {
    return AppSettingsTblData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTblData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsTblData &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsTblCompanion extends UpdateCompanion<AppSettingsTblData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsTblCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsTblCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSettingsTblData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsTblCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsTblCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTblCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SupplierPaymentsTblTable extends SupplierPaymentsTbl
    with TableInfo<$SupplierPaymentsTblTable, SupplierPaymentsTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierPaymentsTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseOrderIdMeta = const VerificationMeta(
    'purchaseOrderId',
  );
  @override
  late final GeneratedColumn<String> purchaseOrderId = GeneratedColumn<String>(
    'purchase_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchase_orders_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES suppliers_tbl (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceNumberMeta = const VerificationMeta(
    'referenceNumber',
  );
  @override
  late final GeneratedColumn<String> referenceNumber = GeneratedColumn<String>(
    'reference_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseOrderId,
    supplierId,
    amount,
    date,
    paymentMethod,
    referenceNumber,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_payments_tbl';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierPaymentsTblData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('purchase_order_id')) {
      context.handle(
        _purchaseOrderIdMeta,
        purchaseOrderId.isAcceptableOrUnknown(
          data['purchase_order_id']!,
          _purchaseOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseOrderIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('reference_number')) {
      context.handle(
        _referenceNumberMeta,
        referenceNumber.isAcceptableOrUnknown(
          data['reference_number']!,
          _referenceNumberMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierPaymentsTblData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierPaymentsTblData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      purchaseOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_order_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      referenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_number'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SupplierPaymentsTblTable createAlias(String alias) {
    return $SupplierPaymentsTblTable(attachedDatabase, alias);
  }
}

class SupplierPaymentsTblData extends DataClass
    implements Insertable<SupplierPaymentsTblData> {
  final String id;
  final String purchaseOrderId;
  final String supplierId;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String? referenceNumber;
  final String? notes;
  final DateTime createdAt;
  const SupplierPaymentsTblData({
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['purchase_order_id'] = Variable<String>(purchaseOrderId);
    map['supplier_id'] = Variable<String>(supplierId);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || referenceNumber != null) {
      map['reference_number'] = Variable<String>(referenceNumber);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SupplierPaymentsTblCompanion toCompanion(bool nullToAbsent) {
    return SupplierPaymentsTblCompanion(
      id: Value(id),
      purchaseOrderId: Value(purchaseOrderId),
      supplierId: Value(supplierId),
      amount: Value(amount),
      date: Value(date),
      paymentMethod: Value(paymentMethod),
      referenceNumber: referenceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceNumber),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory SupplierPaymentsTblData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierPaymentsTblData(
      id: serializer.fromJson<String>(json['id']),
      purchaseOrderId: serializer.fromJson<String>(json['purchaseOrderId']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      referenceNumber: serializer.fromJson<String?>(json['referenceNumber']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'purchaseOrderId': serializer.toJson<String>(purchaseOrderId),
      'supplierId': serializer.toJson<String>(supplierId),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'referenceNumber': serializer.toJson<String?>(referenceNumber),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SupplierPaymentsTblData copyWith({
    String? id,
    String? purchaseOrderId,
    String? supplierId,
    double? amount,
    DateTime? date,
    String? paymentMethod,
    Value<String?> referenceNumber = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => SupplierPaymentsTblData(
    id: id ?? this.id,
    purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
    supplierId: supplierId ?? this.supplierId,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    referenceNumber: referenceNumber.present
        ? referenceNumber.value
        : this.referenceNumber,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  SupplierPaymentsTblData copyWithCompanion(SupplierPaymentsTblCompanion data) {
    return SupplierPaymentsTblData(
      id: data.id.present ? data.id.value : this.id,
      purchaseOrderId: data.purchaseOrderId.present
          ? data.purchaseOrderId.value
          : this.purchaseOrderId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      referenceNumber: data.referenceNumber.present
          ? data.referenceNumber.value
          : this.referenceNumber,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPaymentsTblData(')
          ..write('id: $id, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('supplierId: $supplierId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseOrderId,
    supplierId,
    amount,
    date,
    paymentMethod,
    referenceNumber,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierPaymentsTblData &&
          other.id == this.id &&
          other.purchaseOrderId == this.purchaseOrderId &&
          other.supplierId == this.supplierId &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.paymentMethod == this.paymentMethod &&
          other.referenceNumber == this.referenceNumber &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class SupplierPaymentsTblCompanion
    extends UpdateCompanion<SupplierPaymentsTblData> {
  final Value<String> id;
  final Value<String> purchaseOrderId;
  final Value<String> supplierId;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String> paymentMethod;
  final Value<String?> referenceNumber;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SupplierPaymentsTblCompanion({
    this.id = const Value.absent(),
    this.purchaseOrderId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SupplierPaymentsTblCompanion.insert({
    required String id,
    required String purchaseOrderId,
    required String supplierId,
    required double amount,
    required DateTime date,
    required String paymentMethod,
    this.referenceNumber = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       purchaseOrderId = Value(purchaseOrderId),
       supplierId = Value(supplierId),
       amount = Value(amount),
       date = Value(date),
       paymentMethod = Value(paymentMethod),
       createdAt = Value(createdAt);
  static Insertable<SupplierPaymentsTblData> custom({
    Expression<String>? id,
    Expression<String>? purchaseOrderId,
    Expression<String>? supplierId,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? paymentMethod,
    Expression<String>? referenceNumber,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseOrderId != null) 'purchase_order_id': purchaseOrderId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (referenceNumber != null) 'reference_number': referenceNumber,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SupplierPaymentsTblCompanion copyWith({
    Value<String>? id,
    Value<String>? purchaseOrderId,
    Value<String>? supplierId,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<String>? paymentMethod,
    Value<String?>? referenceNumber,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SupplierPaymentsTblCompanion(
      id: id ?? this.id,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      supplierId: supplierId ?? this.supplierId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (purchaseOrderId.present) {
      map['purchase_order_id'] = Variable<String>(purchaseOrderId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (referenceNumber.present) {
      map['reference_number'] = Variable<String>(referenceNumber.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPaymentsTblCompanion(')
          ..write('id: $id, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('supplierId: $supplierId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTblTable clientsTbl = $ClientsTblTable(this);
  late final $InvoicesTblTable invoicesTbl = $InvoicesTblTable(this);
  late final $InvoiceItemsTblTable invoiceItemsTbl = $InvoiceItemsTblTable(
    this,
  );
  late final $EstimatesTblTable estimatesTbl = $EstimatesTblTable(this);
  late final $EstimateItemsTblTable estimateItemsTbl = $EstimateItemsTblTable(
    this,
  );
  late final $ExpensesTblTable expensesTbl = $ExpensesTblTable(this);
  late final $PaymentsTblTable paymentsTbl = $PaymentsTblTable(this);
  late final $ProductsTblTable productsTbl = $ProductsTblTable(this);
  late final $SuppliersTblTable suppliersTbl = $SuppliersTblTable(this);
  late final $PurchaseOrdersTblTable purchaseOrdersTbl =
      $PurchaseOrdersTblTable(this);
  late final $PoItemsTblTable poItemsTbl = $PoItemsTblTable(this);
  late final $TimeEntriesTblTable timeEntriesTbl = $TimeEntriesTblTable(this);
  late final $RecurringProfilesTblTable recurringProfilesTbl =
      $RecurringProfilesTblTable(this);
  late final $StockMovementsTblTable stockMovementsTbl =
      $StockMovementsTblTable(this);
  late final $AppSettingsTblTable appSettingsTbl = $AppSettingsTblTable(this);
  late final $SupplierPaymentsTblTable supplierPaymentsTbl =
      $SupplierPaymentsTblTable(this);
  late final Index invoicesClient = Index(
    'invoices_client',
    'CREATE INDEX invoices_client ON invoices_tbl (client_id)',
  );
  late final Index invoiceItemsInvoice = Index(
    'invoice_items_invoice',
    'CREATE INDEX invoice_items_invoice ON invoice_items_tbl (invoice_id)',
  );
  late final Index estimatesClient = Index(
    'estimates_client',
    'CREATE INDEX estimates_client ON estimates_tbl (client_id)',
  );
  late final Index estimateItemsEstimate = Index(
    'estimate_items_estimate',
    'CREATE INDEX estimate_items_estimate ON estimate_items_tbl (estimate_id)',
  );
  late final Index expensesClient = Index(
    'expenses_client',
    'CREATE INDEX expenses_client ON expenses_tbl (client_id)',
  );
  late final Index paymentsInvoice = Index(
    'payments_invoice',
    'CREATE INDEX payments_invoice ON payments_tbl (invoice_id)',
  );
  late final Index paymentsClient = Index(
    'payments_client',
    'CREATE INDEX payments_client ON payments_tbl (client_id)',
  );
  late final Index poSupplier = Index(
    'po_supplier',
    'CREATE INDEX po_supplier ON purchase_orders_tbl (supplier_id)',
  );
  late final Index poItemsPo = Index(
    'po_items_po',
    'CREATE INDEX po_items_po ON po_items_tbl (purchase_order_id)',
  );
  late final Index timeEntriesClient = Index(
    'time_entries_client',
    'CREATE INDEX time_entries_client ON time_entries_tbl (client_id)',
  );
  late final Index recurringClient = Index(
    'recurring_client',
    'CREATE INDEX recurring_client ON recurring_profiles_tbl (client_id)',
  );
  late final Index stockProduct = Index(
    'stock_product',
    'CREATE INDEX stock_product ON stock_movements_tbl (product_id)',
  );
  late final Index supplierPaymentsPo = Index(
    'supplier_payments_po',
    'CREATE INDEX supplier_payments_po ON supplier_payments_tbl (purchase_order_id)',
  );
  late final Index supplierPaymentsSupplier = Index(
    'supplier_payments_supplier',
    'CREATE INDEX supplier_payments_supplier ON supplier_payments_tbl (supplier_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clientsTbl,
    invoicesTbl,
    invoiceItemsTbl,
    estimatesTbl,
    estimateItemsTbl,
    expensesTbl,
    paymentsTbl,
    productsTbl,
    suppliersTbl,
    purchaseOrdersTbl,
    poItemsTbl,
    timeEntriesTbl,
    recurringProfilesTbl,
    stockMovementsTbl,
    appSettingsTbl,
    supplierPaymentsTbl,
    invoicesClient,
    invoiceItemsInvoice,
    estimatesClient,
    estimateItemsEstimate,
    expensesClient,
    paymentsInvoice,
    paymentsClient,
    poSupplier,
    poItemsPo,
    timeEntriesClient,
    recurringClient,
    stockProduct,
    supplierPaymentsPo,
    supplierPaymentsSupplier,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clients_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoices_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'invoices_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoice_items_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clients_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('estimates_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'estimates_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('estimate_items_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clients_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('expenses_tbl', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'invoices_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('expenses_tbl', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'invoices_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('payments_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clients_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('payments_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'suppliers_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('purchase_orders_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'purchase_orders_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('po_items_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clients_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('time_entries_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clients_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_profiles_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('stock_movements_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'purchase_orders_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('supplier_payments_tbl', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'suppliers_tbl',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('supplier_payments_tbl', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ClientsTblTableCreateCompanionBuilder =
    ClientsTblCompanion Function({
      required String id,
      required String name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      required DateTime createdAt,
      Value<String?> contactPerson,
      Value<String?> taxNumber,
      Value<int> paymentTermsDays,
      Value<double> creditLimit,
      Value<int> rowid,
    });
typedef $$ClientsTblTableUpdateCompanionBuilder =
    ClientsTblCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<DateTime> createdAt,
      Value<String?> contactPerson,
      Value<String?> taxNumber,
      Value<int> paymentTermsDays,
      Value<double> creditLimit,
      Value<int> rowid,
    });

final class $$ClientsTblTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTblTable, ClientsTblData> {
  $$ClientsTblTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InvoicesTblTable, List<InvoicesTblData>>
  _invoicesTblRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoicesTbl,
    aliasName: $_aliasNameGenerator(db.clientsTbl.id, db.invoicesTbl.clientId),
  );

  $$InvoicesTblTableProcessedTableManager get invoicesTblRefs {
    final manager = $$InvoicesTblTableTableManager(
      $_db,
      $_db.invoicesTbl,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesTblRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EstimatesTblTable, List<EstimatesTblData>>
  _estimatesTblRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.estimatesTbl,
    aliasName: $_aliasNameGenerator(db.clientsTbl.id, db.estimatesTbl.clientId),
  );

  $$EstimatesTblTableProcessedTableManager get estimatesTblRefs {
    final manager = $$EstimatesTblTableTableManager(
      $_db,
      $_db.estimatesTbl,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_estimatesTblRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTblTable, List<ExpensesTblData>>
  _expensesTblRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesTbl,
    aliasName: $_aliasNameGenerator(db.clientsTbl.id, db.expensesTbl.clientId),
  );

  $$ExpensesTblTableProcessedTableManager get expensesTblRefs {
    final manager = $$ExpensesTblTableTableManager(
      $_db,
      $_db.expensesTbl,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesTblRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTblTable, List<PaymentsTblData>>
  _paymentsTblRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentsTbl,
    aliasName: $_aliasNameGenerator(db.clientsTbl.id, db.paymentsTbl.clientId),
  );

  $$PaymentsTblTableProcessedTableManager get paymentsTblRefs {
    final manager = $$PaymentsTblTableTableManager(
      $_db,
      $_db.paymentsTbl,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsTblRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TimeEntriesTblTable, List<TimeEntriesTblData>>
  _timeEntriesTblRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timeEntriesTbl,
    aliasName: $_aliasNameGenerator(
      db.clientsTbl.id,
      db.timeEntriesTbl.clientId,
    ),
  );

  $$TimeEntriesTblTableProcessedTableManager get timeEntriesTblRefs {
    final manager = $$TimeEntriesTblTableTableManager(
      $_db,
      $_db.timeEntriesTbl,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_timeEntriesTblRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RecurringProfilesTblTable,
    List<RecurringProfilesTblData>
  >
  _recurringProfilesTblRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringProfilesTbl,
        aliasName: $_aliasNameGenerator(
          db.clientsTbl.id,
          db.recurringProfilesTbl.clientId,
        ),
      );

  $$RecurringProfilesTblTableProcessedTableManager
  get recurringProfilesTblRefs {
    final manager = $$RecurringProfilesTblTableTableManager(
      $_db,
      $_db.recurringProfilesTbl,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringProfilesTblRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientsTblTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTblTable> {
  $$ClientsTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxNumber => $composableBuilder(
    column: $table.taxNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentTermsDays => $composableBuilder(
    column: $table.paymentTermsDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> invoicesTblRefs(
    Expression<bool> Function($$InvoicesTblTableFilterComposer f) f,
  ) {
    final $$InvoicesTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableFilterComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> estimatesTblRefs(
    Expression<bool> Function($$EstimatesTblTableFilterComposer f) f,
  ) {
    final $$EstimatesTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.estimatesTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EstimatesTblTableFilterComposer(
            $db: $db,
            $table: $db.estimatesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesTblRefs(
    Expression<bool> Function($$ExpensesTblTableFilterComposer f) f,
  ) {
    final $$ExpensesTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTblTableFilterComposer(
            $db: $db,
            $table: $db.expensesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsTblRefs(
    Expression<bool> Function($$PaymentsTblTableFilterComposer f) f,
  ) {
    final $$PaymentsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentsTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTblTableFilterComposer(
            $db: $db,
            $table: $db.paymentsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> timeEntriesTblRefs(
    Expression<bool> Function($$TimeEntriesTblTableFilterComposer f) f,
  ) {
    final $$TimeEntriesTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntriesTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTblTableFilterComposer(
            $db: $db,
            $table: $db.timeEntriesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurringProfilesTblRefs(
    Expression<bool> Function($$RecurringProfilesTblTableFilterComposer f) f,
  ) {
    final $$RecurringProfilesTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringProfilesTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringProfilesTblTableFilterComposer(
            $db: $db,
            $table: $db.recurringProfilesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTblTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTblTable> {
  $$ClientsTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxNumber => $composableBuilder(
    column: $table.taxNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentTermsDays => $composableBuilder(
    column: $table.paymentTermsDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientsTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTblTable> {
  $$ClientsTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taxNumber =>
      $composableBuilder(column: $table.taxNumber, builder: (column) => column);

  GeneratedColumn<int> get paymentTermsDays => $composableBuilder(
    column: $table.paymentTermsDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => column,
  );

  Expression<T> invoicesTblRefs<T extends Object>(
    Expression<T> Function($$InvoicesTblTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableAnnotationComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> estimatesTblRefs<T extends Object>(
    Expression<T> Function($$EstimatesTblTableAnnotationComposer a) f,
  ) {
    final $$EstimatesTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.estimatesTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EstimatesTblTableAnnotationComposer(
            $db: $db,
            $table: $db.estimatesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesTblRefs<T extends Object>(
    Expression<T> Function($$ExpensesTblTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTblTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsTblRefs<T extends Object>(
    Expression<T> Function($$PaymentsTblTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentsTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> timeEntriesTblRefs<T extends Object>(
    Expression<T> Function($$TimeEntriesTblTableAnnotationComposer a) f,
  ) {
    final $$TimeEntriesTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntriesTbl,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTblTableAnnotationComposer(
            $db: $db,
            $table: $db.timeEntriesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recurringProfilesTblRefs<T extends Object>(
    Expression<T> Function($$RecurringProfilesTblTableAnnotationComposer a) f,
  ) {
    final $$RecurringProfilesTblTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringProfilesTbl,
          getReferencedColumn: (t) => t.clientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringProfilesTblTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringProfilesTbl,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ClientsTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTblTable,
          ClientsTblData,
          $$ClientsTblTableFilterComposer,
          $$ClientsTblTableOrderingComposer,
          $$ClientsTblTableAnnotationComposer,
          $$ClientsTblTableCreateCompanionBuilder,
          $$ClientsTblTableUpdateCompanionBuilder,
          (ClientsTblData, $$ClientsTblTableReferences),
          ClientsTblData,
          PrefetchHooks Function({
            bool invoicesTblRefs,
            bool estimatesTblRefs,
            bool expensesTblRefs,
            bool paymentsTblRefs,
            bool timeEntriesTblRefs,
            bool recurringProfilesTblRefs,
          })
        > {
  $$ClientsTblTableTableManager(_$AppDatabase db, $ClientsTblTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> taxNumber = const Value.absent(),
                Value<int> paymentTermsDays = const Value.absent(),
                Value<double> creditLimit = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsTblCompanion(
                id: id,
                name: name,
                email: email,
                phone: phone,
                address: address,
                createdAt: createdAt,
                contactPerson: contactPerson,
                taxNumber: taxNumber,
                paymentTermsDays: paymentTermsDays,
                creditLimit: creditLimit,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                required DateTime createdAt,
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> taxNumber = const Value.absent(),
                Value<int> paymentTermsDays = const Value.absent(),
                Value<double> creditLimit = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsTblCompanion.insert(
                id: id,
                name: name,
                email: email,
                phone: phone,
                address: address,
                createdAt: createdAt,
                contactPerson: contactPerson,
                taxNumber: taxNumber,
                paymentTermsDays: paymentTermsDays,
                creditLimit: creditLimit,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientsTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                invoicesTblRefs = false,
                estimatesTblRefs = false,
                expensesTblRefs = false,
                paymentsTblRefs = false,
                timeEntriesTblRefs = false,
                recurringProfilesTblRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoicesTblRefs) db.invoicesTbl,
                    if (estimatesTblRefs) db.estimatesTbl,
                    if (expensesTblRefs) db.expensesTbl,
                    if (paymentsTblRefs) db.paymentsTbl,
                    if (timeEntriesTblRefs) db.timeEntriesTbl,
                    if (recurringProfilesTblRefs) db.recurringProfilesTbl,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoicesTblRefs)
                        await $_getPrefetchedData<
                          ClientsTblData,
                          $ClientsTblTable,
                          InvoicesTblData
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTblTableReferences
                              ._invoicesTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTblTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (estimatesTblRefs)
                        await $_getPrefetchedData<
                          ClientsTblData,
                          $ClientsTblTable,
                          EstimatesTblData
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTblTableReferences
                              ._estimatesTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTblTableReferences(
                                db,
                                table,
                                p0,
                              ).estimatesTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesTblRefs)
                        await $_getPrefetchedData<
                          ClientsTblData,
                          $ClientsTblTable,
                          ExpensesTblData
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTblTableReferences
                              ._expensesTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTblTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsTblRefs)
                        await $_getPrefetchedData<
                          ClientsTblData,
                          $ClientsTblTable,
                          PaymentsTblData
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTblTableReferences
                              ._paymentsTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTblTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (timeEntriesTblRefs)
                        await $_getPrefetchedData<
                          ClientsTblData,
                          $ClientsTblTable,
                          TimeEntriesTblData
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTblTableReferences
                              ._timeEntriesTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTblTableReferences(
                                db,
                                table,
                                p0,
                              ).timeEntriesTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurringProfilesTblRefs)
                        await $_getPrefetchedData<
                          ClientsTblData,
                          $ClientsTblTable,
                          RecurringProfilesTblData
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTblTableReferences
                              ._recurringProfilesTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTblTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringProfilesTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ClientsTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTblTable,
      ClientsTblData,
      $$ClientsTblTableFilterComposer,
      $$ClientsTblTableOrderingComposer,
      $$ClientsTblTableAnnotationComposer,
      $$ClientsTblTableCreateCompanionBuilder,
      $$ClientsTblTableUpdateCompanionBuilder,
      (ClientsTblData, $$ClientsTblTableReferences),
      ClientsTblData,
      PrefetchHooks Function({
        bool invoicesTblRefs,
        bool estimatesTblRefs,
        bool expensesTblRefs,
        bool paymentsTblRefs,
        bool timeEntriesTblRefs,
        bool recurringProfilesTblRefs,
      })
    >;
typedef $$InvoicesTblTableCreateCompanionBuilder =
    InvoicesTblCompanion Function({
      required String id,
      required String clientId,
      required String invoiceNumber,
      required DateTime issueDate,
      required DateTime dueDate,
      required double subTotal,
      required double taxTotal,
      required double totalAmount,
      required String status,
      Value<String?> notes,
      required DateTime createdAt,
      Value<double> discountPercent,
      Value<double> discountAmount,
      Value<double> withholdingTaxPercent,
      Value<double> withholdingTaxAmount,
      Value<double> tax2Percent,
      Value<int> rowid,
    });
typedef $$InvoicesTblTableUpdateCompanionBuilder =
    InvoicesTblCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String> invoiceNumber,
      Value<DateTime> issueDate,
      Value<DateTime> dueDate,
      Value<double> subTotal,
      Value<double> taxTotal,
      Value<double> totalAmount,
      Value<String> status,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<double> discountPercent,
      Value<double> discountAmount,
      Value<double> withholdingTaxPercent,
      Value<double> withholdingTaxAmount,
      Value<double> tax2Percent,
      Value<int> rowid,
    });

final class $$InvoicesTblTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTblTable, InvoicesTblData> {
  $$InvoicesTblTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTblTable _clientIdTable(_$AppDatabase db) =>
      db.clientsTbl.createAlias(
        $_aliasNameGenerator(db.invoicesTbl.clientId, db.clientsTbl.id),
      );

  $$ClientsTblTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTblTableTableManager(
      $_db,
      $_db.clientsTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoiceItemsTblTable, List<InvoiceItemsTblData>>
  _invoiceItemsTblRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceItemsTbl,
    aliasName: $_aliasNameGenerator(
      db.invoicesTbl.id,
      db.invoiceItemsTbl.invoiceId,
    ),
  );

  $$InvoiceItemsTblTableProcessedTableManager get invoiceItemsTblRefs {
    final manager = $$InvoiceItemsTblTableTableManager(
      $_db,
      $_db.invoiceItemsTbl,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _invoiceItemsTblRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTblTable, List<ExpensesTblData>>
  _expensesTblRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesTbl,
    aliasName: $_aliasNameGenerator(
      db.invoicesTbl.id,
      db.expensesTbl.invoiceId,
    ),
  );

  $$ExpensesTblTableProcessedTableManager get expensesTblRefs {
    final manager = $$ExpensesTblTableTableManager(
      $_db,
      $_db.expensesTbl,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesTblRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTblTable, List<PaymentsTblData>>
  _paymentsTblRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentsTbl,
    aliasName: $_aliasNameGenerator(
      db.invoicesTbl.id,
      db.paymentsTbl.invoiceId,
    ),
  );

  $$PaymentsTblTableProcessedTableManager get paymentsTblRefs {
    final manager = $$PaymentsTblTableTableManager(
      $_db,
      $_db.paymentsTbl,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsTblRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTblTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTblTable> {
  $$InvoicesTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subTotal => $composableBuilder(
    column: $table.subTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxTotal => $composableBuilder(
    column: $table.taxTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get withholdingTaxPercent => $composableBuilder(
    column: $table.withholdingTaxPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get withholdingTaxAmount => $composableBuilder(
    column: $table.withholdingTaxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax2Percent => $composableBuilder(
    column: $table.tax2Percent,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTblTableFilterComposer get clientId {
    final $$ClientsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableFilterComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoiceItemsTblRefs(
    Expression<bool> Function($$InvoiceItemsTblTableFilterComposer f) f,
  ) {
    final $$InvoiceItemsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItemsTbl,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTblTableFilterComposer(
            $db: $db,
            $table: $db.invoiceItemsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesTblRefs(
    Expression<bool> Function($$ExpensesTblTableFilterComposer f) f,
  ) {
    final $$ExpensesTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTbl,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTblTableFilterComposer(
            $db: $db,
            $table: $db.expensesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsTblRefs(
    Expression<bool> Function($$PaymentsTblTableFilterComposer f) f,
  ) {
    final $$PaymentsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentsTbl,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTblTableFilterComposer(
            $db: $db,
            $table: $db.paymentsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTblTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTblTable> {
  $$InvoicesTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subTotal => $composableBuilder(
    column: $table.subTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxTotal => $composableBuilder(
    column: $table.taxTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get withholdingTaxPercent => $composableBuilder(
    column: $table.withholdingTaxPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get withholdingTaxAmount => $composableBuilder(
    column: $table.withholdingTaxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax2Percent => $composableBuilder(
    column: $table.tax2Percent,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTblTableOrderingComposer get clientId {
    final $$ClientsTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableOrderingComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTblTable> {
  $$InvoicesTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<double> get subTotal =>
      $composableBuilder(column: $table.subTotal, builder: (column) => column);

  GeneratedColumn<double> get taxTotal =>
      $composableBuilder(column: $table.taxTotal, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get withholdingTaxPercent => $composableBuilder(
    column: $table.withholdingTaxPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get withholdingTaxAmount => $composableBuilder(
    column: $table.withholdingTaxAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tax2Percent => $composableBuilder(
    column: $table.tax2Percent,
    builder: (column) => column,
  );

  $$ClientsTblTableAnnotationComposer get clientId {
    final $$ClientsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoiceItemsTblRefs<T extends Object>(
    Expression<T> Function($$InvoiceItemsTblTableAnnotationComposer a) f,
  ) {
    final $$InvoiceItemsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItemsTbl,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItemsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesTblRefs<T extends Object>(
    Expression<T> Function($$ExpensesTblTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTbl,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTblTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsTblRefs<T extends Object>(
    Expression<T> Function($$PaymentsTblTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentsTbl,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTblTable,
          InvoicesTblData,
          $$InvoicesTblTableFilterComposer,
          $$InvoicesTblTableOrderingComposer,
          $$InvoicesTblTableAnnotationComposer,
          $$InvoicesTblTableCreateCompanionBuilder,
          $$InvoicesTblTableUpdateCompanionBuilder,
          (InvoicesTblData, $$InvoicesTblTableReferences),
          InvoicesTblData,
          PrefetchHooks Function({
            bool clientId,
            bool invoiceItemsTblRefs,
            bool expensesTblRefs,
            bool paymentsTblRefs,
          })
        > {
  $$InvoicesTblTableTableManager(_$AppDatabase db, $InvoicesTblTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<DateTime> issueDate = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<double> subTotal = const Value.absent(),
                Value<double> taxTotal = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> discountPercent = const Value.absent(),
                Value<double> discountAmount = const Value.absent(),
                Value<double> withholdingTaxPercent = const Value.absent(),
                Value<double> withholdingTaxAmount = const Value.absent(),
                Value<double> tax2Percent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesTblCompanion(
                id: id,
                clientId: clientId,
                invoiceNumber: invoiceNumber,
                issueDate: issueDate,
                dueDate: dueDate,
                subTotal: subTotal,
                taxTotal: taxTotal,
                totalAmount: totalAmount,
                status: status,
                notes: notes,
                createdAt: createdAt,
                discountPercent: discountPercent,
                discountAmount: discountAmount,
                withholdingTaxPercent: withholdingTaxPercent,
                withholdingTaxAmount: withholdingTaxAmount,
                tax2Percent: tax2Percent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                required String invoiceNumber,
                required DateTime issueDate,
                required DateTime dueDate,
                required double subTotal,
                required double taxTotal,
                required double totalAmount,
                required String status,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<double> discountPercent = const Value.absent(),
                Value<double> discountAmount = const Value.absent(),
                Value<double> withholdingTaxPercent = const Value.absent(),
                Value<double> withholdingTaxAmount = const Value.absent(),
                Value<double> tax2Percent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesTblCompanion.insert(
                id: id,
                clientId: clientId,
                invoiceNumber: invoiceNumber,
                issueDate: issueDate,
                dueDate: dueDate,
                subTotal: subTotal,
                taxTotal: taxTotal,
                totalAmount: totalAmount,
                status: status,
                notes: notes,
                createdAt: createdAt,
                discountPercent: discountPercent,
                discountAmount: discountAmount,
                withholdingTaxPercent: withholdingTaxPercent,
                withholdingTaxAmount: withholdingTaxAmount,
                tax2Percent: tax2Percent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoicesTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clientId = false,
                invoiceItemsTblRefs = false,
                expensesTblRefs = false,
                paymentsTblRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceItemsTblRefs) db.invoiceItemsTbl,
                    if (expensesTblRefs) db.expensesTbl,
                    if (paymentsTblRefs) db.paymentsTbl,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable:
                                        $$InvoicesTblTableReferences
                                            ._clientIdTable(db),
                                    referencedColumn:
                                        $$InvoicesTblTableReferences
                                            ._clientIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceItemsTblRefs)
                        await $_getPrefetchedData<
                          InvoicesTblData,
                          $InvoicesTblTable,
                          InvoiceItemsTblData
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTblTableReferences
                              ._invoiceItemsTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTblTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceItemsTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesTblRefs)
                        await $_getPrefetchedData<
                          InvoicesTblData,
                          $InvoicesTblTable,
                          ExpensesTblData
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTblTableReferences
                              ._expensesTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTblTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsTblRefs)
                        await $_getPrefetchedData<
                          InvoicesTblData,
                          $InvoicesTblTable,
                          PaymentsTblData
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTblTableReferences
                              ._paymentsTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTblTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoicesTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTblTable,
      InvoicesTblData,
      $$InvoicesTblTableFilterComposer,
      $$InvoicesTblTableOrderingComposer,
      $$InvoicesTblTableAnnotationComposer,
      $$InvoicesTblTableCreateCompanionBuilder,
      $$InvoicesTblTableUpdateCompanionBuilder,
      (InvoicesTblData, $$InvoicesTblTableReferences),
      InvoicesTblData,
      PrefetchHooks Function({
        bool clientId,
        bool invoiceItemsTblRefs,
        bool expensesTblRefs,
        bool paymentsTblRefs,
      })
    >;
typedef $$InvoiceItemsTblTableCreateCompanionBuilder =
    InvoiceItemsTblCompanion Function({
      required String id,
      required String invoiceId,
      Value<String?> productId,
      required String description,
      required int quantity,
      required double rate,
      required double taxPercent,
      required double taxAmount,
      Value<double> discountPercent,
      required double total,
      Value<int> rowid,
    });
typedef $$InvoiceItemsTblTableUpdateCompanionBuilder =
    InvoiceItemsTblCompanion Function({
      Value<String> id,
      Value<String> invoiceId,
      Value<String?> productId,
      Value<String> description,
      Value<int> quantity,
      Value<double> rate,
      Value<double> taxPercent,
      Value<double> taxAmount,
      Value<double> discountPercent,
      Value<double> total,
      Value<int> rowid,
    });

final class $$InvoiceItemsTblTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InvoiceItemsTblTable,
          InvoiceItemsTblData
        > {
  $$InvoiceItemsTblTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InvoicesTblTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoicesTbl.createAlias(
        $_aliasNameGenerator(db.invoiceItemsTbl.invoiceId, db.invoicesTbl.id),
      );

  $$InvoicesTblTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$InvoicesTblTableTableManager(
      $_db,
      $_db.invoicesTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvoiceItemsTblTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTblTable> {
  $$InvoiceItemsTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTblTableFilterComposer get invoiceId {
    final $$InvoicesTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableFilterComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTblTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTblTable> {
  $$InvoiceItemsTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTblTableOrderingComposer get invoiceId {
    final $$InvoicesTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableOrderingComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTblTable> {
  $$InvoiceItemsTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  $$InvoicesTblTableAnnotationComposer get invoiceId {
    final $$InvoicesTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableAnnotationComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceItemsTblTable,
          InvoiceItemsTblData,
          $$InvoiceItemsTblTableFilterComposer,
          $$InvoiceItemsTblTableOrderingComposer,
          $$InvoiceItemsTblTableAnnotationComposer,
          $$InvoiceItemsTblTableCreateCompanionBuilder,
          $$InvoiceItemsTblTableUpdateCompanionBuilder,
          (InvoiceItemsTblData, $$InvoiceItemsTblTableReferences),
          InvoiceItemsTblData,
          PrefetchHooks Function({bool invoiceId})
        > {
  $$InvoiceItemsTblTableTableManager(
    _$AppDatabase db,
    $InvoiceItemsTblTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceItemsTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceItemsTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceItemsTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<double> taxPercent = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> discountPercent = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoiceItemsTblCompanion(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                description: description,
                quantity: quantity,
                rate: rate,
                taxPercent: taxPercent,
                taxAmount: taxAmount,
                discountPercent: discountPercent,
                total: total,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String invoiceId,
                Value<String?> productId = const Value.absent(),
                required String description,
                required int quantity,
                required double rate,
                required double taxPercent,
                required double taxAmount,
                Value<double> discountPercent = const Value.absent(),
                required double total,
                Value<int> rowid = const Value.absent(),
              }) => InvoiceItemsTblCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                description: description,
                quantity: quantity,
                rate: rate,
                taxPercent: taxPercent,
                taxAmount: taxAmount,
                discountPercent: discountPercent,
                total: total,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoiceItemsTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable:
                                    $$InvoiceItemsTblTableReferences
                                        ._invoiceIdTable(db),
                                referencedColumn:
                                    $$InvoiceItemsTblTableReferences
                                        ._invoiceIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InvoiceItemsTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceItemsTblTable,
      InvoiceItemsTblData,
      $$InvoiceItemsTblTableFilterComposer,
      $$InvoiceItemsTblTableOrderingComposer,
      $$InvoiceItemsTblTableAnnotationComposer,
      $$InvoiceItemsTblTableCreateCompanionBuilder,
      $$InvoiceItemsTblTableUpdateCompanionBuilder,
      (InvoiceItemsTblData, $$InvoiceItemsTblTableReferences),
      InvoiceItemsTblData,
      PrefetchHooks Function({bool invoiceId})
    >;
typedef $$EstimatesTblTableCreateCompanionBuilder =
    EstimatesTblCompanion Function({
      required String id,
      required String clientId,
      required String estimateNumber,
      required DateTime issueDate,
      required DateTime expiryDate,
      required double subTotal,
      required double taxTotal,
      required double totalAmount,
      required String status,
      Value<String?> notes,
      required DateTime createdAt,
      Value<double> discountPercent,
      Value<double> discountAmount,
      Value<double> withholdingTaxPercent,
      Value<double> withholdingTaxAmount,
      Value<double> tax2Percent,
      Value<int> rowid,
    });
typedef $$EstimatesTblTableUpdateCompanionBuilder =
    EstimatesTblCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String> estimateNumber,
      Value<DateTime> issueDate,
      Value<DateTime> expiryDate,
      Value<double> subTotal,
      Value<double> taxTotal,
      Value<double> totalAmount,
      Value<String> status,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<double> discountPercent,
      Value<double> discountAmount,
      Value<double> withholdingTaxPercent,
      Value<double> withholdingTaxAmount,
      Value<double> tax2Percent,
      Value<int> rowid,
    });

final class $$EstimatesTblTableReferences
    extends
        BaseReferences<_$AppDatabase, $EstimatesTblTable, EstimatesTblData> {
  $$EstimatesTblTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTblTable _clientIdTable(_$AppDatabase db) =>
      db.clientsTbl.createAlias(
        $_aliasNameGenerator(db.estimatesTbl.clientId, db.clientsTbl.id),
      );

  $$ClientsTblTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTblTableTableManager(
      $_db,
      $_db.clientsTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EstimateItemsTblTable, List<EstimateItemsTblData>>
  _estimateItemsTblRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.estimateItemsTbl,
    aliasName: $_aliasNameGenerator(
      db.estimatesTbl.id,
      db.estimateItemsTbl.estimateId,
    ),
  );

  $$EstimateItemsTblTableProcessedTableManager get estimateItemsTblRefs {
    final manager = $$EstimateItemsTblTableTableManager(
      $_db,
      $_db.estimateItemsTbl,
    ).filter((f) => f.estimateId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _estimateItemsTblRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EstimatesTblTableFilterComposer
    extends Composer<_$AppDatabase, $EstimatesTblTable> {
  $$EstimatesTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estimateNumber => $composableBuilder(
    column: $table.estimateNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subTotal => $composableBuilder(
    column: $table.subTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxTotal => $composableBuilder(
    column: $table.taxTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get withholdingTaxPercent => $composableBuilder(
    column: $table.withholdingTaxPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get withholdingTaxAmount => $composableBuilder(
    column: $table.withholdingTaxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax2Percent => $composableBuilder(
    column: $table.tax2Percent,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTblTableFilterComposer get clientId {
    final $$ClientsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableFilterComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> estimateItemsTblRefs(
    Expression<bool> Function($$EstimateItemsTblTableFilterComposer f) f,
  ) {
    final $$EstimateItemsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.estimateItemsTbl,
      getReferencedColumn: (t) => t.estimateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EstimateItemsTblTableFilterComposer(
            $db: $db,
            $table: $db.estimateItemsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EstimatesTblTableOrderingComposer
    extends Composer<_$AppDatabase, $EstimatesTblTable> {
  $$EstimatesTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estimateNumber => $composableBuilder(
    column: $table.estimateNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subTotal => $composableBuilder(
    column: $table.subTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxTotal => $composableBuilder(
    column: $table.taxTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get withholdingTaxPercent => $composableBuilder(
    column: $table.withholdingTaxPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get withholdingTaxAmount => $composableBuilder(
    column: $table.withholdingTaxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax2Percent => $composableBuilder(
    column: $table.tax2Percent,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTblTableOrderingComposer get clientId {
    final $$ClientsTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableOrderingComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EstimatesTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $EstimatesTblTable> {
  $$EstimatesTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get estimateNumber => $composableBuilder(
    column: $table.estimateNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subTotal =>
      $composableBuilder(column: $table.subTotal, builder: (column) => column);

  GeneratedColumn<double> get taxTotal =>
      $composableBuilder(column: $table.taxTotal, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get withholdingTaxPercent => $composableBuilder(
    column: $table.withholdingTaxPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get withholdingTaxAmount => $composableBuilder(
    column: $table.withholdingTaxAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tax2Percent => $composableBuilder(
    column: $table.tax2Percent,
    builder: (column) => column,
  );

  $$ClientsTblTableAnnotationComposer get clientId {
    final $$ClientsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> estimateItemsTblRefs<T extends Object>(
    Expression<T> Function($$EstimateItemsTblTableAnnotationComposer a) f,
  ) {
    final $$EstimateItemsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.estimateItemsTbl,
      getReferencedColumn: (t) => t.estimateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EstimateItemsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.estimateItemsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EstimatesTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EstimatesTblTable,
          EstimatesTblData,
          $$EstimatesTblTableFilterComposer,
          $$EstimatesTblTableOrderingComposer,
          $$EstimatesTblTableAnnotationComposer,
          $$EstimatesTblTableCreateCompanionBuilder,
          $$EstimatesTblTableUpdateCompanionBuilder,
          (EstimatesTblData, $$EstimatesTblTableReferences),
          EstimatesTblData,
          PrefetchHooks Function({bool clientId, bool estimateItemsTblRefs})
        > {
  $$EstimatesTblTableTableManager(_$AppDatabase db, $EstimatesTblTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EstimatesTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EstimatesTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EstimatesTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> estimateNumber = const Value.absent(),
                Value<DateTime> issueDate = const Value.absent(),
                Value<DateTime> expiryDate = const Value.absent(),
                Value<double> subTotal = const Value.absent(),
                Value<double> taxTotal = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> discountPercent = const Value.absent(),
                Value<double> discountAmount = const Value.absent(),
                Value<double> withholdingTaxPercent = const Value.absent(),
                Value<double> withholdingTaxAmount = const Value.absent(),
                Value<double> tax2Percent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EstimatesTblCompanion(
                id: id,
                clientId: clientId,
                estimateNumber: estimateNumber,
                issueDate: issueDate,
                expiryDate: expiryDate,
                subTotal: subTotal,
                taxTotal: taxTotal,
                totalAmount: totalAmount,
                status: status,
                notes: notes,
                createdAt: createdAt,
                discountPercent: discountPercent,
                discountAmount: discountAmount,
                withholdingTaxPercent: withholdingTaxPercent,
                withholdingTaxAmount: withholdingTaxAmount,
                tax2Percent: tax2Percent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                required String estimateNumber,
                required DateTime issueDate,
                required DateTime expiryDate,
                required double subTotal,
                required double taxTotal,
                required double totalAmount,
                required String status,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<double> discountPercent = const Value.absent(),
                Value<double> discountAmount = const Value.absent(),
                Value<double> withholdingTaxPercent = const Value.absent(),
                Value<double> withholdingTaxAmount = const Value.absent(),
                Value<double> tax2Percent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EstimatesTblCompanion.insert(
                id: id,
                clientId: clientId,
                estimateNumber: estimateNumber,
                issueDate: issueDate,
                expiryDate: expiryDate,
                subTotal: subTotal,
                taxTotal: taxTotal,
                totalAmount: totalAmount,
                status: status,
                notes: notes,
                createdAt: createdAt,
                discountPercent: discountPercent,
                discountAmount: discountAmount,
                withholdingTaxPercent: withholdingTaxPercent,
                withholdingTaxAmount: withholdingTaxAmount,
                tax2Percent: tax2Percent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EstimatesTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({clientId = false, estimateItemsTblRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (estimateItemsTblRefs) db.estimateItemsTbl,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable:
                                        $$EstimatesTblTableReferences
                                            ._clientIdTable(db),
                                    referencedColumn:
                                        $$EstimatesTblTableReferences
                                            ._clientIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (estimateItemsTblRefs)
                        await $_getPrefetchedData<
                          EstimatesTblData,
                          $EstimatesTblTable,
                          EstimateItemsTblData
                        >(
                          currentTable: table,
                          referencedTable: $$EstimatesTblTableReferences
                              ._estimateItemsTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EstimatesTblTableReferences(
                                db,
                                table,
                                p0,
                              ).estimateItemsTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.estimateId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EstimatesTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EstimatesTblTable,
      EstimatesTblData,
      $$EstimatesTblTableFilterComposer,
      $$EstimatesTblTableOrderingComposer,
      $$EstimatesTblTableAnnotationComposer,
      $$EstimatesTblTableCreateCompanionBuilder,
      $$EstimatesTblTableUpdateCompanionBuilder,
      (EstimatesTblData, $$EstimatesTblTableReferences),
      EstimatesTblData,
      PrefetchHooks Function({bool clientId, bool estimateItemsTblRefs})
    >;
typedef $$EstimateItemsTblTableCreateCompanionBuilder =
    EstimateItemsTblCompanion Function({
      required String id,
      required String estimateId,
      Value<String?> productId,
      required String description,
      required int quantity,
      required double rate,
      required double taxPercent,
      required double taxAmount,
      Value<double> discountPercent,
      required double total,
      Value<int> rowid,
    });
typedef $$EstimateItemsTblTableUpdateCompanionBuilder =
    EstimateItemsTblCompanion Function({
      Value<String> id,
      Value<String> estimateId,
      Value<String?> productId,
      Value<String> description,
      Value<int> quantity,
      Value<double> rate,
      Value<double> taxPercent,
      Value<double> taxAmount,
      Value<double> discountPercent,
      Value<double> total,
      Value<int> rowid,
    });

final class $$EstimateItemsTblTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EstimateItemsTblTable,
          EstimateItemsTblData
        > {
  $$EstimateItemsTblTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EstimatesTblTable _estimateIdTable(_$AppDatabase db) =>
      db.estimatesTbl.createAlias(
        $_aliasNameGenerator(
          db.estimateItemsTbl.estimateId,
          db.estimatesTbl.id,
        ),
      );

  $$EstimatesTblTableProcessedTableManager get estimateId {
    final $_column = $_itemColumn<String>('estimate_id')!;

    final manager = $$EstimatesTblTableTableManager(
      $_db,
      $_db.estimatesTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_estimateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EstimateItemsTblTableFilterComposer
    extends Composer<_$AppDatabase, $EstimateItemsTblTable> {
  $$EstimateItemsTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  $$EstimatesTblTableFilterComposer get estimateId {
    final $$EstimatesTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.estimateId,
      referencedTable: $db.estimatesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EstimatesTblTableFilterComposer(
            $db: $db,
            $table: $db.estimatesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EstimateItemsTblTableOrderingComposer
    extends Composer<_$AppDatabase, $EstimateItemsTblTable> {
  $$EstimateItemsTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  $$EstimatesTblTableOrderingComposer get estimateId {
    final $$EstimatesTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.estimateId,
      referencedTable: $db.estimatesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EstimatesTblTableOrderingComposer(
            $db: $db,
            $table: $db.estimatesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EstimateItemsTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $EstimateItemsTblTable> {
  $$EstimateItemsTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  $$EstimatesTblTableAnnotationComposer get estimateId {
    final $$EstimatesTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.estimateId,
      referencedTable: $db.estimatesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EstimatesTblTableAnnotationComposer(
            $db: $db,
            $table: $db.estimatesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EstimateItemsTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EstimateItemsTblTable,
          EstimateItemsTblData,
          $$EstimateItemsTblTableFilterComposer,
          $$EstimateItemsTblTableOrderingComposer,
          $$EstimateItemsTblTableAnnotationComposer,
          $$EstimateItemsTblTableCreateCompanionBuilder,
          $$EstimateItemsTblTableUpdateCompanionBuilder,
          (EstimateItemsTblData, $$EstimateItemsTblTableReferences),
          EstimateItemsTblData,
          PrefetchHooks Function({bool estimateId})
        > {
  $$EstimateItemsTblTableTableManager(
    _$AppDatabase db,
    $EstimateItemsTblTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EstimateItemsTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EstimateItemsTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EstimateItemsTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> estimateId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<double> taxPercent = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> discountPercent = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EstimateItemsTblCompanion(
                id: id,
                estimateId: estimateId,
                productId: productId,
                description: description,
                quantity: quantity,
                rate: rate,
                taxPercent: taxPercent,
                taxAmount: taxAmount,
                discountPercent: discountPercent,
                total: total,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String estimateId,
                Value<String?> productId = const Value.absent(),
                required String description,
                required int quantity,
                required double rate,
                required double taxPercent,
                required double taxAmount,
                Value<double> discountPercent = const Value.absent(),
                required double total,
                Value<int> rowid = const Value.absent(),
              }) => EstimateItemsTblCompanion.insert(
                id: id,
                estimateId: estimateId,
                productId: productId,
                description: description,
                quantity: quantity,
                rate: rate,
                taxPercent: taxPercent,
                taxAmount: taxAmount,
                discountPercent: discountPercent,
                total: total,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EstimateItemsTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({estimateId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (estimateId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.estimateId,
                                referencedTable:
                                    $$EstimateItemsTblTableReferences
                                        ._estimateIdTable(db),
                                referencedColumn:
                                    $$EstimateItemsTblTableReferences
                                        ._estimateIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EstimateItemsTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EstimateItemsTblTable,
      EstimateItemsTblData,
      $$EstimateItemsTblTableFilterComposer,
      $$EstimateItemsTblTableOrderingComposer,
      $$EstimateItemsTblTableAnnotationComposer,
      $$EstimateItemsTblTableCreateCompanionBuilder,
      $$EstimateItemsTblTableUpdateCompanionBuilder,
      (EstimateItemsTblData, $$EstimateItemsTblTableReferences),
      EstimateItemsTblData,
      PrefetchHooks Function({bool estimateId})
    >;
typedef $$ExpensesTblTableCreateCompanionBuilder =
    ExpensesTblCompanion Function({
      required String id,
      required String description,
      required double amount,
      required String category,
      required DateTime date,
      Value<String?> clientId,
      required bool isBillable,
      Value<String?> receiptPath,
      Value<String?> notes,
      required DateTime createdAt,
      Value<double> markupPercent,
      Value<String?> invoiceId,
      Value<int> rowid,
    });
typedef $$ExpensesTblTableUpdateCompanionBuilder =
    ExpensesTblCompanion Function({
      Value<String> id,
      Value<String> description,
      Value<double> amount,
      Value<String> category,
      Value<DateTime> date,
      Value<String?> clientId,
      Value<bool> isBillable,
      Value<String?> receiptPath,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<double> markupPercent,
      Value<String?> invoiceId,
      Value<int> rowid,
    });

final class $$ExpensesTblTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTblTable, ExpensesTblData> {
  $$ExpensesTblTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTblTable _clientIdTable(_$AppDatabase db) =>
      db.clientsTbl.createAlias(
        $_aliasNameGenerator(db.expensesTbl.clientId, db.clientsTbl.id),
      );

  $$ClientsTblTableProcessedTableManager? get clientId {
    final $_column = $_itemColumn<String>('client_id');
    if ($_column == null) return null;
    final manager = $$ClientsTblTableTableManager(
      $_db,
      $_db.clientsTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvoicesTblTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoicesTbl.createAlias(
        $_aliasNameGenerator(db.expensesTbl.invoiceId, db.invoicesTbl.id),
      );

  $$InvoicesTblTableProcessedTableManager? get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id');
    if ($_column == null) return null;
    final manager = $$InvoicesTblTableTableManager(
      $_db,
      $_db.invoicesTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpensesTblTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTblTable> {
  $$ExpensesTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBillable => $composableBuilder(
    column: $table.isBillable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get markupPercent => $composableBuilder(
    column: $table.markupPercent,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTblTableFilterComposer get clientId {
    final $$ClientsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableFilterComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTblTableFilterComposer get invoiceId {
    final $$InvoicesTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableFilterComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTblTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTblTable> {
  $$ExpensesTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBillable => $composableBuilder(
    column: $table.isBillable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get markupPercent => $composableBuilder(
    column: $table.markupPercent,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTblTableOrderingComposer get clientId {
    final $$ClientsTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableOrderingComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTblTableOrderingComposer get invoiceId {
    final $$InvoicesTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableOrderingComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTblTable> {
  $$ExpensesTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get isBillable => $composableBuilder(
    column: $table.isBillable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get markupPercent => $composableBuilder(
    column: $table.markupPercent,
    builder: (column) => column,
  );

  $$ClientsTblTableAnnotationComposer get clientId {
    final $$ClientsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTblTableAnnotationComposer get invoiceId {
    final $$InvoicesTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableAnnotationComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTblTable,
          ExpensesTblData,
          $$ExpensesTblTableFilterComposer,
          $$ExpensesTblTableOrderingComposer,
          $$ExpensesTblTableAnnotationComposer,
          $$ExpensesTblTableCreateCompanionBuilder,
          $$ExpensesTblTableUpdateCompanionBuilder,
          (ExpensesTblData, $$ExpensesTblTableReferences),
          ExpensesTblData,
          PrefetchHooks Function({bool clientId, bool invoiceId})
        > {
  $$ExpensesTblTableTableManager(_$AppDatabase db, $ExpensesTblTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> clientId = const Value.absent(),
                Value<bool> isBillable = const Value.absent(),
                Value<String?> receiptPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> markupPercent = const Value.absent(),
                Value<String?> invoiceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesTblCompanion(
                id: id,
                description: description,
                amount: amount,
                category: category,
                date: date,
                clientId: clientId,
                isBillable: isBillable,
                receiptPath: receiptPath,
                notes: notes,
                createdAt: createdAt,
                markupPercent: markupPercent,
                invoiceId: invoiceId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String description,
                required double amount,
                required String category,
                required DateTime date,
                Value<String?> clientId = const Value.absent(),
                required bool isBillable,
                Value<String?> receiptPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<double> markupPercent = const Value.absent(),
                Value<String?> invoiceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesTblCompanion.insert(
                id: id,
                description: description,
                amount: amount,
                category: category,
                date: date,
                clientId: clientId,
                isBillable: isBillable,
                receiptPath: receiptPath,
                notes: notes,
                createdAt: createdAt,
                markupPercent: markupPercent,
                invoiceId: invoiceId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false, invoiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable: $$ExpensesTblTableReferences
                                    ._clientIdTable(db),
                                referencedColumn: $$ExpensesTblTableReferences
                                    ._clientIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $$ExpensesTblTableReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $$ExpensesTblTableReferences
                                    ._invoiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpensesTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTblTable,
      ExpensesTblData,
      $$ExpensesTblTableFilterComposer,
      $$ExpensesTblTableOrderingComposer,
      $$ExpensesTblTableAnnotationComposer,
      $$ExpensesTblTableCreateCompanionBuilder,
      $$ExpensesTblTableUpdateCompanionBuilder,
      (ExpensesTblData, $$ExpensesTblTableReferences),
      ExpensesTblData,
      PrefetchHooks Function({bool clientId, bool invoiceId})
    >;
typedef $$PaymentsTblTableCreateCompanionBuilder =
    PaymentsTblCompanion Function({
      required String id,
      required String invoiceId,
      required String clientId,
      required double amount,
      required DateTime date,
      required String paymentMethod,
      Value<String?> referenceNumber,
      Value<String?> notes,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$PaymentsTblTableUpdateCompanionBuilder =
    PaymentsTblCompanion Function({
      Value<String> id,
      Value<String> invoiceId,
      Value<String> clientId,
      Value<double> amount,
      Value<DateTime> date,
      Value<String> paymentMethod,
      Value<String?> referenceNumber,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PaymentsTblTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTblTable, PaymentsTblData> {
  $$PaymentsTblTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTblTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoicesTbl.createAlias(
        $_aliasNameGenerator(db.paymentsTbl.invoiceId, db.invoicesTbl.id),
      );

  $$InvoicesTblTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$InvoicesTblTableTableManager(
      $_db,
      $_db.invoicesTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ClientsTblTable _clientIdTable(_$AppDatabase db) =>
      db.clientsTbl.createAlias(
        $_aliasNameGenerator(db.paymentsTbl.clientId, db.clientsTbl.id),
      );

  $$ClientsTblTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTblTableTableManager(
      $_db,
      $_db.clientsTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentsTblTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTblTable> {
  $$PaymentsTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTblTableFilterComposer get invoiceId {
    final $$InvoicesTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableFilterComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTblTableFilterComposer get clientId {
    final $$ClientsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableFilterComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTblTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTblTable> {
  $$PaymentsTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTblTableOrderingComposer get invoiceId {
    final $$InvoicesTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableOrderingComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTblTableOrderingComposer get clientId {
    final $$ClientsTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableOrderingComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTblTable> {
  $$PaymentsTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InvoicesTblTableAnnotationComposer get invoiceId {
    final $$InvoicesTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoicesTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTblTableAnnotationComposer(
            $db: $db,
            $table: $db.invoicesTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTblTableAnnotationComposer get clientId {
    final $$ClientsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTblTable,
          PaymentsTblData,
          $$PaymentsTblTableFilterComposer,
          $$PaymentsTblTableOrderingComposer,
          $$PaymentsTblTableAnnotationComposer,
          $$PaymentsTblTableCreateCompanionBuilder,
          $$PaymentsTblTableUpdateCompanionBuilder,
          (PaymentsTblData, $$PaymentsTblTableReferences),
          PaymentsTblData,
          PrefetchHooks Function({bool invoiceId, bool clientId})
        > {
  $$PaymentsTblTableTableManager(_$AppDatabase db, $PaymentsTblTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> referenceNumber = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsTblCompanion(
                id: id,
                invoiceId: invoiceId,
                clientId: clientId,
                amount: amount,
                date: date,
                paymentMethod: paymentMethod,
                referenceNumber: referenceNumber,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String invoiceId,
                required String clientId,
                required double amount,
                required DateTime date,
                required String paymentMethod,
                Value<String?> referenceNumber = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PaymentsTblCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                clientId: clientId,
                amount: amount,
                date: date,
                paymentMethod: paymentMethod,
                referenceNumber: referenceNumber,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false, clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $$PaymentsTblTableReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $$PaymentsTblTableReferences
                                    ._invoiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable: $$PaymentsTblTableReferences
                                    ._clientIdTable(db),
                                referencedColumn: $$PaymentsTblTableReferences
                                    ._clientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PaymentsTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTblTable,
      PaymentsTblData,
      $$PaymentsTblTableFilterComposer,
      $$PaymentsTblTableOrderingComposer,
      $$PaymentsTblTableAnnotationComposer,
      $$PaymentsTblTableCreateCompanionBuilder,
      $$PaymentsTblTableUpdateCompanionBuilder,
      (PaymentsTblData, $$PaymentsTblTableReferences),
      PaymentsTblData,
      PrefetchHooks Function({bool invoiceId, bool clientId})
    >;
typedef $$ProductsTblTableCreateCompanionBuilder =
    ProductsTblCompanion Function({
      required String id,
      required String name,
      Value<String?> sku,
      Value<String?> barcode,
      Value<String?> description,
      required String category,
      required double costPrice,
      required double sellingPrice,
      required int quantity,
      required int reorderLevel,
      required String unit,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProductsTblTableUpdateCompanionBuilder =
    ProductsTblCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> sku,
      Value<String?> barcode,
      Value<String?> description,
      Value<String> category,
      Value<double> costPrice,
      Value<double> sellingPrice,
      Value<int> quantity,
      Value<int> reorderLevel,
      Value<String> unit,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ProductsTblTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTblTable, ProductsTblData> {
  $$ProductsTblTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $StockMovementsTblTable,
    List<StockMovementsTblData>
  >
  _stockMovementsTblRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.stockMovementsTbl,
        aliasName: $_aliasNameGenerator(
          db.productsTbl.id,
          db.stockMovementsTbl.productId,
        ),
      );

  $$StockMovementsTblTableProcessedTableManager get stockMovementsTblRefs {
    final manager = $$StockMovementsTblTableTableManager(
      $_db,
      $_db.stockMovementsTbl,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _stockMovementsTblRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTblTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTblTable> {
  $$ProductsTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> stockMovementsTblRefs(
    Expression<bool> Function($$StockMovementsTblTableFilterComposer f) f,
  ) {
    final $$StockMovementsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovementsTbl,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTblTableFilterComposer(
            $db: $db,
            $table: $db.stockMovementsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTblTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTblTable> {
  $$ProductsTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTblTable> {
  $$ProductsTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get costPrice =>
      $composableBuilder(column: $table.costPrice, builder: (column) => column);

  GeneratedColumn<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> stockMovementsTblRefs<T extends Object>(
    Expression<T> Function($$StockMovementsTblTableAnnotationComposer a) f,
  ) {
    final $$StockMovementsTblTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.stockMovementsTbl,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StockMovementsTblTableAnnotationComposer(
                $db: $db,
                $table: $db.stockMovementsTbl,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductsTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTblTable,
          ProductsTblData,
          $$ProductsTblTableFilterComposer,
          $$ProductsTblTableOrderingComposer,
          $$ProductsTblTableAnnotationComposer,
          $$ProductsTblTableCreateCompanionBuilder,
          $$ProductsTblTableUpdateCompanionBuilder,
          (ProductsTblData, $$ProductsTblTableReferences),
          ProductsTblData,
          PrefetchHooks Function({bool stockMovementsTblRefs})
        > {
  $$ProductsTblTableTableManager(_$AppDatabase db, $ProductsTblTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> costPrice = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> reorderLevel = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsTblCompanion(
                id: id,
                name: name,
                sku: sku,
                barcode: barcode,
                description: description,
                category: category,
                costPrice: costPrice,
                sellingPrice: sellingPrice,
                quantity: quantity,
                reorderLevel: reorderLevel,
                unit: unit,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> sku = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required String category,
                required double costPrice,
                required double sellingPrice,
                required int quantity,
                required int reorderLevel,
                required String unit,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProductsTblCompanion.insert(
                id: id,
                name: name,
                sku: sku,
                barcode: barcode,
                description: description,
                category: category,
                costPrice: costPrice,
                sellingPrice: sellingPrice,
                quantity: quantity,
                reorderLevel: reorderLevel,
                unit: unit,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stockMovementsTblRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (stockMovementsTblRefs) db.stockMovementsTbl,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (stockMovementsTblRefs)
                    await $_getPrefetchedData<
                      ProductsTblData,
                      $ProductsTblTable,
                      StockMovementsTblData
                    >(
                      currentTable: table,
                      referencedTable: $$ProductsTblTableReferences
                          ._stockMovementsTblRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProductsTblTableReferences(
                            db,
                            table,
                            p0,
                          ).stockMovementsTblRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.productId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductsTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTblTable,
      ProductsTblData,
      $$ProductsTblTableFilterComposer,
      $$ProductsTblTableOrderingComposer,
      $$ProductsTblTableAnnotationComposer,
      $$ProductsTblTableCreateCompanionBuilder,
      $$ProductsTblTableUpdateCompanionBuilder,
      (ProductsTblData, $$ProductsTblTableReferences),
      ProductsTblData,
      PrefetchHooks Function({bool stockMovementsTblRefs})
    >;
typedef $$SuppliersTblTableCreateCompanionBuilder =
    SuppliersTblCompanion Function({
      required String id,
      required String name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> contactPerson,
      Value<String?> taxId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SuppliersTblTableUpdateCompanionBuilder =
    SuppliersTblCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> contactPerson,
      Value<String?> taxId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$SuppliersTblTableReferences
    extends
        BaseReferences<_$AppDatabase, $SuppliersTblTable, SuppliersTblData> {
  $$SuppliersTblTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $PurchaseOrdersTblTable,
    List<PurchaseOrdersTblData>
  >
  _purchaseOrdersTblRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseOrdersTbl,
        aliasName: $_aliasNameGenerator(
          db.suppliersTbl.id,
          db.purchaseOrdersTbl.supplierId,
        ),
      );

  $$PurchaseOrdersTblTableProcessedTableManager get purchaseOrdersTblRefs {
    final manager = $$PurchaseOrdersTblTableTableManager(
      $_db,
      $_db.purchaseOrdersTbl,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseOrdersTblRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SupplierPaymentsTblTable,
    List<SupplierPaymentsTblData>
  >
  _supplierPaymentsTblRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.supplierPaymentsTbl,
        aliasName: $_aliasNameGenerator(
          db.suppliersTbl.id,
          db.supplierPaymentsTbl.supplierId,
        ),
      );

  $$SupplierPaymentsTblTableProcessedTableManager get supplierPaymentsTblRefs {
    final manager = $$SupplierPaymentsTblTableTableManager(
      $_db,
      $_db.supplierPaymentsTbl,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _supplierPaymentsTblRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SuppliersTblTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTblTable> {
  $$SuppliersTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxId => $composableBuilder(
    column: $table.taxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> purchaseOrdersTblRefs(
    Expression<bool> Function($$PurchaseOrdersTblTableFilterComposer f) f,
  ) {
    final $$PurchaseOrdersTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrdersTbl,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTblTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrdersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> supplierPaymentsTblRefs(
    Expression<bool> Function($$SupplierPaymentsTblTableFilterComposer f) f,
  ) {
    final $$SupplierPaymentsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierPaymentsTbl,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SupplierPaymentsTblTableFilterComposer(
            $db: $db,
            $table: $db.supplierPaymentsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTblTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTblTable> {
  $$SuppliersTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxId => $composableBuilder(
    column: $table.taxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTblTable> {
  $$SuppliersTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taxId =>
      $composableBuilder(column: $table.taxId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> purchaseOrdersTblRefs<T extends Object>(
    Expression<T> Function($$PurchaseOrdersTblTableAnnotationComposer a) f,
  ) {
    final $$PurchaseOrdersTblTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseOrdersTbl,
          getReferencedColumn: (t) => t.supplierId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseOrdersTblTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseOrdersTbl,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> supplierPaymentsTblRefs<T extends Object>(
    Expression<T> Function($$SupplierPaymentsTblTableAnnotationComposer a) f,
  ) {
    final $$SupplierPaymentsTblTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.supplierPaymentsTbl,
          getReferencedColumn: (t) => t.supplierId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SupplierPaymentsTblTableAnnotationComposer(
                $db: $db,
                $table: $db.supplierPaymentsTbl,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SuppliersTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTblTable,
          SuppliersTblData,
          $$SuppliersTblTableFilterComposer,
          $$SuppliersTblTableOrderingComposer,
          $$SuppliersTblTableAnnotationComposer,
          $$SuppliersTblTableCreateCompanionBuilder,
          $$SuppliersTblTableUpdateCompanionBuilder,
          (SuppliersTblData, $$SuppliersTblTableReferences),
          SuppliersTblData,
          PrefetchHooks Function({
            bool purchaseOrdersTblRefs,
            bool supplierPaymentsTblRefs,
          })
        > {
  $$SuppliersTblTableTableManager(_$AppDatabase db, $SuppliersTblTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> taxId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersTblCompanion(
                id: id,
                name: name,
                email: email,
                phone: phone,
                address: address,
                contactPerson: contactPerson,
                taxId: taxId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> taxId = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SuppliersTblCompanion.insert(
                id: id,
                name: name,
                email: email,
                phone: phone,
                address: address,
                contactPerson: contactPerson,
                taxId: taxId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SuppliersTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                purchaseOrdersTblRefs = false,
                supplierPaymentsTblRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseOrdersTblRefs) db.purchaseOrdersTbl,
                    if (supplierPaymentsTblRefs) db.supplierPaymentsTbl,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseOrdersTblRefs)
                        await $_getPrefetchedData<
                          SuppliersTblData,
                          $SuppliersTblTable,
                          PurchaseOrdersTblData
                        >(
                          currentTable: table,
                          referencedTable: $$SuppliersTblTableReferences
                              ._purchaseOrdersTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SuppliersTblTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseOrdersTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.supplierId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (supplierPaymentsTblRefs)
                        await $_getPrefetchedData<
                          SuppliersTblData,
                          $SuppliersTblTable,
                          SupplierPaymentsTblData
                        >(
                          currentTable: table,
                          referencedTable: $$SuppliersTblTableReferences
                              ._supplierPaymentsTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SuppliersTblTableReferences(
                                db,
                                table,
                                p0,
                              ).supplierPaymentsTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.supplierId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SuppliersTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTblTable,
      SuppliersTblData,
      $$SuppliersTblTableFilterComposer,
      $$SuppliersTblTableOrderingComposer,
      $$SuppliersTblTableAnnotationComposer,
      $$SuppliersTblTableCreateCompanionBuilder,
      $$SuppliersTblTableUpdateCompanionBuilder,
      (SuppliersTblData, $$SuppliersTblTableReferences),
      SuppliersTblData,
      PrefetchHooks Function({
        bool purchaseOrdersTblRefs,
        bool supplierPaymentsTblRefs,
      })
    >;
typedef $$PurchaseOrdersTblTableCreateCompanionBuilder =
    PurchaseOrdersTblCompanion Function({
      required String id,
      required String supplierId,
      required String poNumber,
      required DateTime issueDate,
      required DateTime expectedDate,
      required double subTotal,
      required double taxTotal,
      required double totalAmount,
      required String status,
      Value<String?> notes,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$PurchaseOrdersTblTableUpdateCompanionBuilder =
    PurchaseOrdersTblCompanion Function({
      Value<String> id,
      Value<String> supplierId,
      Value<String> poNumber,
      Value<DateTime> issueDate,
      Value<DateTime> expectedDate,
      Value<double> subTotal,
      Value<double> taxTotal,
      Value<double> totalAmount,
      Value<String> status,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PurchaseOrdersTblTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PurchaseOrdersTblTable,
          PurchaseOrdersTblData
        > {
  $$PurchaseOrdersTblTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SuppliersTblTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliersTbl.createAlias(
        $_aliasNameGenerator(
          db.purchaseOrdersTbl.supplierId,
          db.suppliersTbl.id,
        ),
      );

  $$SuppliersTblTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<String>('supplier_id')!;

    final manager = $$SuppliersTblTableTableManager(
      $_db,
      $_db.suppliersTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PoItemsTblTable, List<PoItemsTblData>>
  _poItemsTblRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.poItemsTbl,
    aliasName: $_aliasNameGenerator(
      db.purchaseOrdersTbl.id,
      db.poItemsTbl.purchaseOrderId,
    ),
  );

  $$PoItemsTblTableProcessedTableManager get poItemsTblRefs {
    final manager = $$PoItemsTblTableTableManager($_db, $_db.poItemsTbl).filter(
      (f) => f.purchaseOrderId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_poItemsTblRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SupplierPaymentsTblTable,
    List<SupplierPaymentsTblData>
  >
  _supplierPaymentsTblRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.supplierPaymentsTbl,
        aliasName: $_aliasNameGenerator(
          db.purchaseOrdersTbl.id,
          db.supplierPaymentsTbl.purchaseOrderId,
        ),
      );

  $$SupplierPaymentsTblTableProcessedTableManager get supplierPaymentsTblRefs {
    final manager =
        $$SupplierPaymentsTblTableTableManager(
          $_db,
          $_db.supplierPaymentsTbl,
        ).filter(
          (f) => f.purchaseOrderId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _supplierPaymentsTblRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchaseOrdersTblTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTblTable> {
  $$PurchaseOrdersTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get poNumber => $composableBuilder(
    column: $table.poNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedDate => $composableBuilder(
    column: $table.expectedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subTotal => $composableBuilder(
    column: $table.subTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxTotal => $composableBuilder(
    column: $table.taxTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SuppliersTblTableFilterComposer get supplierId {
    final $$SuppliersTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliersTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTblTableFilterComposer(
            $db: $db,
            $table: $db.suppliersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> poItemsTblRefs(
    Expression<bool> Function($$PoItemsTblTableFilterComposer f) f,
  ) {
    final $$PoItemsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.poItemsTbl,
      getReferencedColumn: (t) => t.purchaseOrderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoItemsTblTableFilterComposer(
            $db: $db,
            $table: $db.poItemsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> supplierPaymentsTblRefs(
    Expression<bool> Function($$SupplierPaymentsTblTableFilterComposer f) f,
  ) {
    final $$SupplierPaymentsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierPaymentsTbl,
      getReferencedColumn: (t) => t.purchaseOrderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SupplierPaymentsTblTableFilterComposer(
            $db: $db,
            $table: $db.supplierPaymentsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseOrdersTblTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTblTable> {
  $$PurchaseOrdersTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get poNumber => $composableBuilder(
    column: $table.poNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedDate => $composableBuilder(
    column: $table.expectedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subTotal => $composableBuilder(
    column: $table.subTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxTotal => $composableBuilder(
    column: $table.taxTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SuppliersTblTableOrderingComposer get supplierId {
    final $$SuppliersTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliersTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTblTableOrderingComposer(
            $db: $db,
            $table: $db.suppliersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseOrdersTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTblTable> {
  $$PurchaseOrdersTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get poNumber =>
      $composableBuilder(column: $table.poNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expectedDate => $composableBuilder(
    column: $table.expectedDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subTotal =>
      $composableBuilder(column: $table.subTotal, builder: (column) => column);

  GeneratedColumn<double> get taxTotal =>
      $composableBuilder(column: $table.taxTotal, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SuppliersTblTableAnnotationComposer get supplierId {
    final $$SuppliersTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliersTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTblTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> poItemsTblRefs<T extends Object>(
    Expression<T> Function($$PoItemsTblTableAnnotationComposer a) f,
  ) {
    final $$PoItemsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.poItemsTbl,
      getReferencedColumn: (t) => t.purchaseOrderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoItemsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.poItemsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> supplierPaymentsTblRefs<T extends Object>(
    Expression<T> Function($$SupplierPaymentsTblTableAnnotationComposer a) f,
  ) {
    final $$SupplierPaymentsTblTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.supplierPaymentsTbl,
          getReferencedColumn: (t) => t.purchaseOrderId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SupplierPaymentsTblTableAnnotationComposer(
                $db: $db,
                $table: $db.supplierPaymentsTbl,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PurchaseOrdersTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrdersTblTable,
          PurchaseOrdersTblData,
          $$PurchaseOrdersTblTableFilterComposer,
          $$PurchaseOrdersTblTableOrderingComposer,
          $$PurchaseOrdersTblTableAnnotationComposer,
          $$PurchaseOrdersTblTableCreateCompanionBuilder,
          $$PurchaseOrdersTblTableUpdateCompanionBuilder,
          (PurchaseOrdersTblData, $$PurchaseOrdersTblTableReferences),
          PurchaseOrdersTblData,
          PrefetchHooks Function({
            bool supplierId,
            bool poItemsTblRefs,
            bool supplierPaymentsTblRefs,
          })
        > {
  $$PurchaseOrdersTblTableTableManager(
    _$AppDatabase db,
    $PurchaseOrdersTblTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrdersTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseOrdersTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseOrdersTblTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<String> poNumber = const Value.absent(),
                Value<DateTime> issueDate = const Value.absent(),
                Value<DateTime> expectedDate = const Value.absent(),
                Value<double> subTotal = const Value.absent(),
                Value<double> taxTotal = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrdersTblCompanion(
                id: id,
                supplierId: supplierId,
                poNumber: poNumber,
                issueDate: issueDate,
                expectedDate: expectedDate,
                subTotal: subTotal,
                taxTotal: taxTotal,
                totalAmount: totalAmount,
                status: status,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String supplierId,
                required String poNumber,
                required DateTime issueDate,
                required DateTime expectedDate,
                required double subTotal,
                required double taxTotal,
                required double totalAmount,
                required String status,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrdersTblCompanion.insert(
                id: id,
                supplierId: supplierId,
                poNumber: poNumber,
                issueDate: issueDate,
                expectedDate: expectedDate,
                subTotal: subTotal,
                taxTotal: taxTotal,
                totalAmount: totalAmount,
                status: status,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseOrdersTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                supplierId = false,
                poItemsTblRefs = false,
                supplierPaymentsTblRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (poItemsTblRefs) db.poItemsTbl,
                    if (supplierPaymentsTblRefs) db.supplierPaymentsTbl,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (supplierId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.supplierId,
                                    referencedTable:
                                        $$PurchaseOrdersTblTableReferences
                                            ._supplierIdTable(db),
                                    referencedColumn:
                                        $$PurchaseOrdersTblTableReferences
                                            ._supplierIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (poItemsTblRefs)
                        await $_getPrefetchedData<
                          PurchaseOrdersTblData,
                          $PurchaseOrdersTblTable,
                          PoItemsTblData
                        >(
                          currentTable: table,
                          referencedTable: $$PurchaseOrdersTblTableReferences
                              ._poItemsTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchaseOrdersTblTableReferences(
                                db,
                                table,
                                p0,
                              ).poItemsTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseOrderId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (supplierPaymentsTblRefs)
                        await $_getPrefetchedData<
                          PurchaseOrdersTblData,
                          $PurchaseOrdersTblTable,
                          SupplierPaymentsTblData
                        >(
                          currentTable: table,
                          referencedTable: $$PurchaseOrdersTblTableReferences
                              ._supplierPaymentsTblRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchaseOrdersTblTableReferences(
                                db,
                                table,
                                p0,
                              ).supplierPaymentsTblRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseOrderId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PurchaseOrdersTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrdersTblTable,
      PurchaseOrdersTblData,
      $$PurchaseOrdersTblTableFilterComposer,
      $$PurchaseOrdersTblTableOrderingComposer,
      $$PurchaseOrdersTblTableAnnotationComposer,
      $$PurchaseOrdersTblTableCreateCompanionBuilder,
      $$PurchaseOrdersTblTableUpdateCompanionBuilder,
      (PurchaseOrdersTblData, $$PurchaseOrdersTblTableReferences),
      PurchaseOrdersTblData,
      PrefetchHooks Function({
        bool supplierId,
        bool poItemsTblRefs,
        bool supplierPaymentsTblRefs,
      })
    >;
typedef $$PoItemsTblTableCreateCompanionBuilder =
    PoItemsTblCompanion Function({
      required String id,
      required String purchaseOrderId,
      Value<String?> productId,
      required String description,
      required int quantity,
      required int receivedQty,
      required double unitPrice,
      required double taxPercent,
      required double taxAmount,
      required double total,
      Value<int> rowid,
    });
typedef $$PoItemsTblTableUpdateCompanionBuilder =
    PoItemsTblCompanion Function({
      Value<String> id,
      Value<String> purchaseOrderId,
      Value<String?> productId,
      Value<String> description,
      Value<int> quantity,
      Value<int> receivedQty,
      Value<double> unitPrice,
      Value<double> taxPercent,
      Value<double> taxAmount,
      Value<double> total,
      Value<int> rowid,
    });

final class $$PoItemsTblTableReferences
    extends BaseReferences<_$AppDatabase, $PoItemsTblTable, PoItemsTblData> {
  $$PoItemsTblTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PurchaseOrdersTblTable _purchaseOrderIdTable(_$AppDatabase db) =>
      db.purchaseOrdersTbl.createAlias(
        $_aliasNameGenerator(
          db.poItemsTbl.purchaseOrderId,
          db.purchaseOrdersTbl.id,
        ),
      );

  $$PurchaseOrdersTblTableProcessedTableManager get purchaseOrderId {
    final $_column = $_itemColumn<String>('purchase_order_id')!;

    final manager = $$PurchaseOrdersTblTableTableManager(
      $_db,
      $_db.purchaseOrdersTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseOrderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PoItemsTblTableFilterComposer
    extends Composer<_$AppDatabase, $PoItemsTblTable> {
  $$PoItemsTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get receivedQty => $composableBuilder(
    column: $table.receivedQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchaseOrdersTblTableFilterComposer get purchaseOrderId {
    final $$PurchaseOrdersTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseOrderId,
      referencedTable: $db.purchaseOrdersTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTblTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrdersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PoItemsTblTableOrderingComposer
    extends Composer<_$AppDatabase, $PoItemsTblTable> {
  $$PoItemsTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get receivedQty => $composableBuilder(
    column: $table.receivedQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchaseOrdersTblTableOrderingComposer get purchaseOrderId {
    final $$PurchaseOrdersTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseOrderId,
      referencedTable: $db.purchaseOrdersTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTblTableOrderingComposer(
            $db: $db,
            $table: $db.purchaseOrdersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PoItemsTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $PoItemsTblTable> {
  $$PoItemsTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get receivedQty => $composableBuilder(
    column: $table.receivedQty,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get taxPercent => $composableBuilder(
    column: $table.taxPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  $$PurchaseOrdersTblTableAnnotationComposer get purchaseOrderId {
    final $$PurchaseOrdersTblTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.purchaseOrderId,
          referencedTable: $db.purchaseOrdersTbl,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseOrdersTblTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseOrdersTbl,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$PoItemsTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PoItemsTblTable,
          PoItemsTblData,
          $$PoItemsTblTableFilterComposer,
          $$PoItemsTblTableOrderingComposer,
          $$PoItemsTblTableAnnotationComposer,
          $$PoItemsTblTableCreateCompanionBuilder,
          $$PoItemsTblTableUpdateCompanionBuilder,
          (PoItemsTblData, $$PoItemsTblTableReferences),
          PoItemsTblData,
          PrefetchHooks Function({bool purchaseOrderId})
        > {
  $$PoItemsTblTableTableManager(_$AppDatabase db, $PoItemsTblTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PoItemsTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PoItemsTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PoItemsTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> purchaseOrderId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> receivedQty = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> taxPercent = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PoItemsTblCompanion(
                id: id,
                purchaseOrderId: purchaseOrderId,
                productId: productId,
                description: description,
                quantity: quantity,
                receivedQty: receivedQty,
                unitPrice: unitPrice,
                taxPercent: taxPercent,
                taxAmount: taxAmount,
                total: total,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String purchaseOrderId,
                Value<String?> productId = const Value.absent(),
                required String description,
                required int quantity,
                required int receivedQty,
                required double unitPrice,
                required double taxPercent,
                required double taxAmount,
                required double total,
                Value<int> rowid = const Value.absent(),
              }) => PoItemsTblCompanion.insert(
                id: id,
                purchaseOrderId: purchaseOrderId,
                productId: productId,
                description: description,
                quantity: quantity,
                receivedQty: receivedQty,
                unitPrice: unitPrice,
                taxPercent: taxPercent,
                taxAmount: taxAmount,
                total: total,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PoItemsTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseOrderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (purchaseOrderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.purchaseOrderId,
                                referencedTable: $$PoItemsTblTableReferences
                                    ._purchaseOrderIdTable(db),
                                referencedColumn: $$PoItemsTblTableReferences
                                    ._purchaseOrderIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PoItemsTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PoItemsTblTable,
      PoItemsTblData,
      $$PoItemsTblTableFilterComposer,
      $$PoItemsTblTableOrderingComposer,
      $$PoItemsTblTableAnnotationComposer,
      $$PoItemsTblTableCreateCompanionBuilder,
      $$PoItemsTblTableUpdateCompanionBuilder,
      (PoItemsTblData, $$PoItemsTblTableReferences),
      PoItemsTblData,
      PrefetchHooks Function({bool purchaseOrderId})
    >;
typedef $$TimeEntriesTblTableCreateCompanionBuilder =
    TimeEntriesTblCompanion Function({
      required String id,
      required String clientId,
      required String taskName,
      required String description,
      required DateTime date,
      required double hours,
      required double rate,
      required bool isBillable,
      required bool isInvoiced,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$TimeEntriesTblTableUpdateCompanionBuilder =
    TimeEntriesTblCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String> taskName,
      Value<String> description,
      Value<DateTime> date,
      Value<double> hours,
      Value<double> rate,
      Value<bool> isBillable,
      Value<bool> isInvoiced,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$TimeEntriesTblTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TimeEntriesTblTable,
          TimeEntriesTblData
        > {
  $$TimeEntriesTblTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClientsTblTable _clientIdTable(_$AppDatabase db) =>
      db.clientsTbl.createAlias(
        $_aliasNameGenerator(db.timeEntriesTbl.clientId, db.clientsTbl.id),
      );

  $$ClientsTblTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTblTableTableManager(
      $_db,
      $_db.clientsTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TimeEntriesTblTableFilterComposer
    extends Composer<_$AppDatabase, $TimeEntriesTblTable> {
  $$TimeEntriesTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskName => $composableBuilder(
    column: $table.taskName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hours => $composableBuilder(
    column: $table.hours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBillable => $composableBuilder(
    column: $table.isBillable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isInvoiced => $composableBuilder(
    column: $table.isInvoiced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTblTableFilterComposer get clientId {
    final $$ClientsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableFilterComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeEntriesTblTableOrderingComposer
    extends Composer<_$AppDatabase, $TimeEntriesTblTable> {
  $$TimeEntriesTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskName => $composableBuilder(
    column: $table.taskName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hours => $composableBuilder(
    column: $table.hours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBillable => $composableBuilder(
    column: $table.isBillable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isInvoiced => $composableBuilder(
    column: $table.isInvoiced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTblTableOrderingComposer get clientId {
    final $$ClientsTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableOrderingComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeEntriesTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimeEntriesTblTable> {
  $$TimeEntriesTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskName =>
      $composableBuilder(column: $table.taskName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get hours =>
      $composableBuilder(column: $table.hours, builder: (column) => column);

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<bool> get isBillable => $composableBuilder(
    column: $table.isBillable,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isInvoiced => $composableBuilder(
    column: $table.isInvoiced,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ClientsTblTableAnnotationComposer get clientId {
    final $$ClientsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeEntriesTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimeEntriesTblTable,
          TimeEntriesTblData,
          $$TimeEntriesTblTableFilterComposer,
          $$TimeEntriesTblTableOrderingComposer,
          $$TimeEntriesTblTableAnnotationComposer,
          $$TimeEntriesTblTableCreateCompanionBuilder,
          $$TimeEntriesTblTableUpdateCompanionBuilder,
          (TimeEntriesTblData, $$TimeEntriesTblTableReferences),
          TimeEntriesTblData,
          PrefetchHooks Function({bool clientId})
        > {
  $$TimeEntriesTblTableTableManager(
    _$AppDatabase db,
    $TimeEntriesTblTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeEntriesTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimeEntriesTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimeEntriesTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> taskName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> hours = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<bool> isBillable = const Value.absent(),
                Value<bool> isInvoiced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimeEntriesTblCompanion(
                id: id,
                clientId: clientId,
                taskName: taskName,
                description: description,
                date: date,
                hours: hours,
                rate: rate,
                isBillable: isBillable,
                isInvoiced: isInvoiced,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                required String taskName,
                required String description,
                required DateTime date,
                required double hours,
                required double rate,
                required bool isBillable,
                required bool isInvoiced,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TimeEntriesTblCompanion.insert(
                id: id,
                clientId: clientId,
                taskName: taskName,
                description: description,
                date: date,
                hours: hours,
                rate: rate,
                isBillable: isBillable,
                isInvoiced: isInvoiced,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimeEntriesTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable: $$TimeEntriesTblTableReferences
                                    ._clientIdTable(db),
                                referencedColumn:
                                    $$TimeEntriesTblTableReferences
                                        ._clientIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TimeEntriesTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimeEntriesTblTable,
      TimeEntriesTblData,
      $$TimeEntriesTblTableFilterComposer,
      $$TimeEntriesTblTableOrderingComposer,
      $$TimeEntriesTblTableAnnotationComposer,
      $$TimeEntriesTblTableCreateCompanionBuilder,
      $$TimeEntriesTblTableUpdateCompanionBuilder,
      (TimeEntriesTblData, $$TimeEntriesTblTableReferences),
      TimeEntriesTblData,
      PrefetchHooks Function({bool clientId})
    >;
typedef $$RecurringProfilesTblTableCreateCompanionBuilder =
    RecurringProfilesTblCompanion Function({
      required String id,
      required String clientId,
      required String frequency,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      required DateTime nextIssueDate,
      required double amount,
      required String description,
      required bool isActive,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$RecurringProfilesTblTableUpdateCompanionBuilder =
    RecurringProfilesTblCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String> frequency,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<DateTime> nextIssueDate,
      Value<double> amount,
      Value<String> description,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$RecurringProfilesTblTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecurringProfilesTblTable,
          RecurringProfilesTblData
        > {
  $$RecurringProfilesTblTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClientsTblTable _clientIdTable(_$AppDatabase db) =>
      db.clientsTbl.createAlias(
        $_aliasNameGenerator(
          db.recurringProfilesTbl.clientId,
          db.clientsTbl.id,
        ),
      );

  $$ClientsTblTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTblTableTableManager(
      $_db,
      $_db.clientsTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecurringProfilesTblTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringProfilesTblTable> {
  $$RecurringProfilesTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextIssueDate => $composableBuilder(
    column: $table.nextIssueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTblTableFilterComposer get clientId {
    final $$ClientsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableFilterComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringProfilesTblTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringProfilesTblTable> {
  $$RecurringProfilesTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextIssueDate => $composableBuilder(
    column: $table.nextIssueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTblTableOrderingComposer get clientId {
    final $$ClientsTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableOrderingComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringProfilesTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringProfilesTblTable> {
  $$RecurringProfilesTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<DateTime> get nextIssueDate => $composableBuilder(
    column: $table.nextIssueDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ClientsTblTableAnnotationComposer get clientId {
    final $$ClientsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.clientsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringProfilesTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringProfilesTblTable,
          RecurringProfilesTblData,
          $$RecurringProfilesTblTableFilterComposer,
          $$RecurringProfilesTblTableOrderingComposer,
          $$RecurringProfilesTblTableAnnotationComposer,
          $$RecurringProfilesTblTableCreateCompanionBuilder,
          $$RecurringProfilesTblTableUpdateCompanionBuilder,
          (RecurringProfilesTblData, $$RecurringProfilesTblTableReferences),
          RecurringProfilesTblData,
          PrefetchHooks Function({bool clientId})
        > {
  $$RecurringProfilesTblTableTableManager(
    _$AppDatabase db,
    $RecurringProfilesTblTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringProfilesTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringProfilesTblTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecurringProfilesTblTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<DateTime> nextIssueDate = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurringProfilesTblCompanion(
                id: id,
                clientId: clientId,
                frequency: frequency,
                startDate: startDate,
                endDate: endDate,
                nextIssueDate: nextIssueDate,
                amount: amount,
                description: description,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                required String frequency,
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                required DateTime nextIssueDate,
                required double amount,
                required String description,
                required bool isActive,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RecurringProfilesTblCompanion.insert(
                id: id,
                clientId: clientId,
                frequency: frequency,
                startDate: startDate,
                endDate: endDate,
                nextIssueDate: nextIssueDate,
                amount: amount,
                description: description,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecurringProfilesTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable:
                                    $$RecurringProfilesTblTableReferences
                                        ._clientIdTable(db),
                                referencedColumn:
                                    $$RecurringProfilesTblTableReferences
                                        ._clientIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecurringProfilesTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringProfilesTblTable,
      RecurringProfilesTblData,
      $$RecurringProfilesTblTableFilterComposer,
      $$RecurringProfilesTblTableOrderingComposer,
      $$RecurringProfilesTblTableAnnotationComposer,
      $$RecurringProfilesTblTableCreateCompanionBuilder,
      $$RecurringProfilesTblTableUpdateCompanionBuilder,
      (RecurringProfilesTblData, $$RecurringProfilesTblTableReferences),
      RecurringProfilesTblData,
      PrefetchHooks Function({bool clientId})
    >;
typedef $$StockMovementsTblTableCreateCompanionBuilder =
    StockMovementsTblCompanion Function({
      required String id,
      required String productId,
      required String productName,
      required int quantityChange,
      required int balanceAfter,
      required String type,
      required String referenceNumber,
      Value<String?> referenceId,
      required String description,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$StockMovementsTblTableUpdateCompanionBuilder =
    StockMovementsTblCompanion Function({
      Value<String> id,
      Value<String> productId,
      Value<String> productName,
      Value<int> quantityChange,
      Value<int> balanceAfter,
      Value<String> type,
      Value<String> referenceNumber,
      Value<String?> referenceId,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$StockMovementsTblTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StockMovementsTblTable,
          StockMovementsTblData
        > {
  $$StockMovementsTblTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTblTable _productIdTable(_$AppDatabase db) =>
      db.productsTbl.createAlias(
        $_aliasNameGenerator(db.stockMovementsTbl.productId, db.productsTbl.id),
      );

  $$ProductsTblTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTblTableTableManager(
      $_db,
      $_db.productsTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StockMovementsTblTableFilterComposer
    extends Composer<_$AppDatabase, $StockMovementsTblTable> {
  $$StockMovementsTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantityChange => $composableBuilder(
    column: $table.quantityChange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balanceAfter => $composableBuilder(
    column: $table.balanceAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTblTableFilterComposer get productId {
    final $$ProductsTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTblTableFilterComposer(
            $db: $db,
            $table: $db.productsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTblTableOrderingComposer
    extends Composer<_$AppDatabase, $StockMovementsTblTable> {
  $$StockMovementsTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantityChange => $composableBuilder(
    column: $table.quantityChange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balanceAfter => $composableBuilder(
    column: $table.balanceAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTblTableOrderingComposer get productId {
    final $$ProductsTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTblTableOrderingComposer(
            $db: $db,
            $table: $db.productsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockMovementsTblTable> {
  $$StockMovementsTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantityChange => $composableBuilder(
    column: $table.quantityChange,
    builder: (column) => column,
  );

  GeneratedColumn<int> get balanceAfter => $composableBuilder(
    column: $table.balanceAfter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProductsTblTableAnnotationComposer get productId {
    final $$ProductsTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTblTableAnnotationComposer(
            $db: $db,
            $table: $db.productsTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockMovementsTblTable,
          StockMovementsTblData,
          $$StockMovementsTblTableFilterComposer,
          $$StockMovementsTblTableOrderingComposer,
          $$StockMovementsTblTableAnnotationComposer,
          $$StockMovementsTblTableCreateCompanionBuilder,
          $$StockMovementsTblTableUpdateCompanionBuilder,
          (StockMovementsTblData, $$StockMovementsTblTableReferences),
          StockMovementsTblData,
          PrefetchHooks Function({bool productId})
        > {
  $$StockMovementsTblTableTableManager(
    _$AppDatabase db,
    $StockMovementsTblTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockMovementsTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockMovementsTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockMovementsTblTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<int> quantityChange = const Value.absent(),
                Value<int> balanceAfter = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> referenceNumber = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockMovementsTblCompanion(
                id: id,
                productId: productId,
                productName: productName,
                quantityChange: quantityChange,
                balanceAfter: balanceAfter,
                type: type,
                referenceNumber: referenceNumber,
                referenceId: referenceId,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String productId,
                required String productName,
                required int quantityChange,
                required int balanceAfter,
                required String type,
                required String referenceNumber,
                Value<String?> referenceId = const Value.absent(),
                required String description,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => StockMovementsTblCompanion.insert(
                id: id,
                productId: productId,
                productName: productName,
                quantityChange: quantityChange,
                balanceAfter: balanceAfter,
                type: type,
                referenceNumber: referenceNumber,
                referenceId: referenceId,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StockMovementsTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable:
                                    $$StockMovementsTblTableReferences
                                        ._productIdTable(db),
                                referencedColumn:
                                    $$StockMovementsTblTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StockMovementsTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockMovementsTblTable,
      StockMovementsTblData,
      $$StockMovementsTblTableFilterComposer,
      $$StockMovementsTblTableOrderingComposer,
      $$StockMovementsTblTableAnnotationComposer,
      $$StockMovementsTblTableCreateCompanionBuilder,
      $$StockMovementsTblTableUpdateCompanionBuilder,
      (StockMovementsTblData, $$StockMovementsTblTableReferences),
      StockMovementsTblData,
      PrefetchHooks Function({bool productId})
    >;
typedef $$AppSettingsTblTableCreateCompanionBuilder =
    AppSettingsTblCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTblTableUpdateCompanionBuilder =
    AppSettingsTblCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTblTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTblTable> {
  $$AppSettingsTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTblTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTblTable> {
  $$AppSettingsTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTblTable> {
  $$AppSettingsTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTblTable,
          AppSettingsTblData,
          $$AppSettingsTblTableFilterComposer,
          $$AppSettingsTblTableOrderingComposer,
          $$AppSettingsTblTableAnnotationComposer,
          $$AppSettingsTblTableCreateCompanionBuilder,
          $$AppSettingsTblTableUpdateCompanionBuilder,
          (
            AppSettingsTblData,
            BaseReferences<
              _$AppDatabase,
              $AppSettingsTblTable,
              AppSettingsTblData
            >,
          ),
          AppSettingsTblData,
          PrefetchHooks Function()
        > {
  $$AppSettingsTblTableTableManager(
    _$AppDatabase db,
    $AppSettingsTblTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTblTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTblTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  AppSettingsTblCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTblCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTblTable,
      AppSettingsTblData,
      $$AppSettingsTblTableFilterComposer,
      $$AppSettingsTblTableOrderingComposer,
      $$AppSettingsTblTableAnnotationComposer,
      $$AppSettingsTblTableCreateCompanionBuilder,
      $$AppSettingsTblTableUpdateCompanionBuilder,
      (
        AppSettingsTblData,
        BaseReferences<_$AppDatabase, $AppSettingsTblTable, AppSettingsTblData>,
      ),
      AppSettingsTblData,
      PrefetchHooks Function()
    >;
typedef $$SupplierPaymentsTblTableCreateCompanionBuilder =
    SupplierPaymentsTblCompanion Function({
      required String id,
      required String purchaseOrderId,
      required String supplierId,
      required double amount,
      required DateTime date,
      required String paymentMethod,
      Value<String?> referenceNumber,
      Value<String?> notes,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SupplierPaymentsTblTableUpdateCompanionBuilder =
    SupplierPaymentsTblCompanion Function({
      Value<String> id,
      Value<String> purchaseOrderId,
      Value<String> supplierId,
      Value<double> amount,
      Value<DateTime> date,
      Value<String> paymentMethod,
      Value<String?> referenceNumber,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$SupplierPaymentsTblTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SupplierPaymentsTblTable,
          SupplierPaymentsTblData
        > {
  $$SupplierPaymentsTblTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchaseOrdersTblTable _purchaseOrderIdTable(_$AppDatabase db) =>
      db.purchaseOrdersTbl.createAlias(
        $_aliasNameGenerator(
          db.supplierPaymentsTbl.purchaseOrderId,
          db.purchaseOrdersTbl.id,
        ),
      );

  $$PurchaseOrdersTblTableProcessedTableManager get purchaseOrderId {
    final $_column = $_itemColumn<String>('purchase_order_id')!;

    final manager = $$PurchaseOrdersTblTableTableManager(
      $_db,
      $_db.purchaseOrdersTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseOrderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SuppliersTblTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliersTbl.createAlias(
        $_aliasNameGenerator(
          db.supplierPaymentsTbl.supplierId,
          db.suppliersTbl.id,
        ),
      );

  $$SuppliersTblTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<String>('supplier_id')!;

    final manager = $$SuppliersTblTableTableManager(
      $_db,
      $_db.suppliersTbl,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SupplierPaymentsTblTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierPaymentsTblTable> {
  $$SupplierPaymentsTblTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchaseOrdersTblTableFilterComposer get purchaseOrderId {
    final $$PurchaseOrdersTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseOrderId,
      referencedTable: $db.purchaseOrdersTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTblTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrdersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SuppliersTblTableFilterComposer get supplierId {
    final $$SuppliersTblTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliersTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTblTableFilterComposer(
            $db: $db,
            $table: $db.suppliersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierPaymentsTblTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierPaymentsTblTable> {
  $$SupplierPaymentsTblTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchaseOrdersTblTableOrderingComposer get purchaseOrderId {
    final $$PurchaseOrdersTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseOrderId,
      referencedTable: $db.purchaseOrdersTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTblTableOrderingComposer(
            $db: $db,
            $table: $db.purchaseOrdersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SuppliersTblTableOrderingComposer get supplierId {
    final $$SuppliersTblTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliersTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTblTableOrderingComposer(
            $db: $db,
            $table: $db.suppliersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierPaymentsTblTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierPaymentsTblTable> {
  $$SupplierPaymentsTblTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PurchaseOrdersTblTableAnnotationComposer get purchaseOrderId {
    final $$PurchaseOrdersTblTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.purchaseOrderId,
          referencedTable: $db.purchaseOrdersTbl,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseOrdersTblTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseOrdersTbl,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$SuppliersTblTableAnnotationComposer get supplierId {
    final $$SuppliersTblTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliersTbl,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTblTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliersTbl,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierPaymentsTblTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierPaymentsTblTable,
          SupplierPaymentsTblData,
          $$SupplierPaymentsTblTableFilterComposer,
          $$SupplierPaymentsTblTableOrderingComposer,
          $$SupplierPaymentsTblTableAnnotationComposer,
          $$SupplierPaymentsTblTableCreateCompanionBuilder,
          $$SupplierPaymentsTblTableUpdateCompanionBuilder,
          (SupplierPaymentsTblData, $$SupplierPaymentsTblTableReferences),
          SupplierPaymentsTblData,
          PrefetchHooks Function({bool purchaseOrderId, bool supplierId})
        > {
  $$SupplierPaymentsTblTableTableManager(
    _$AppDatabase db,
    $SupplierPaymentsTblTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierPaymentsTblTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SupplierPaymentsTblTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SupplierPaymentsTblTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> purchaseOrderId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> referenceNumber = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SupplierPaymentsTblCompanion(
                id: id,
                purchaseOrderId: purchaseOrderId,
                supplierId: supplierId,
                amount: amount,
                date: date,
                paymentMethod: paymentMethod,
                referenceNumber: referenceNumber,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String purchaseOrderId,
                required String supplierId,
                required double amount,
                required DateTime date,
                required String paymentMethod,
                Value<String?> referenceNumber = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SupplierPaymentsTblCompanion.insert(
                id: id,
                purchaseOrderId: purchaseOrderId,
                supplierId: supplierId,
                amount: amount,
                date: date,
                paymentMethod: paymentMethod,
                referenceNumber: referenceNumber,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SupplierPaymentsTblTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({purchaseOrderId = false, supplierId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (purchaseOrderId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.purchaseOrderId,
                                    referencedTable:
                                        $$SupplierPaymentsTblTableReferences
                                            ._purchaseOrderIdTable(db),
                                    referencedColumn:
                                        $$SupplierPaymentsTblTableReferences
                                            ._purchaseOrderIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (supplierId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.supplierId,
                                    referencedTable:
                                        $$SupplierPaymentsTblTableReferences
                                            ._supplierIdTable(db),
                                    referencedColumn:
                                        $$SupplierPaymentsTblTableReferences
                                            ._supplierIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$SupplierPaymentsTblTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierPaymentsTblTable,
      SupplierPaymentsTblData,
      $$SupplierPaymentsTblTableFilterComposer,
      $$SupplierPaymentsTblTableOrderingComposer,
      $$SupplierPaymentsTblTableAnnotationComposer,
      $$SupplierPaymentsTblTableCreateCompanionBuilder,
      $$SupplierPaymentsTblTableUpdateCompanionBuilder,
      (SupplierPaymentsTblData, $$SupplierPaymentsTblTableReferences),
      SupplierPaymentsTblData,
      PrefetchHooks Function({bool purchaseOrderId, bool supplierId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTblTableTableManager get clientsTbl =>
      $$ClientsTblTableTableManager(_db, _db.clientsTbl);
  $$InvoicesTblTableTableManager get invoicesTbl =>
      $$InvoicesTblTableTableManager(_db, _db.invoicesTbl);
  $$InvoiceItemsTblTableTableManager get invoiceItemsTbl =>
      $$InvoiceItemsTblTableTableManager(_db, _db.invoiceItemsTbl);
  $$EstimatesTblTableTableManager get estimatesTbl =>
      $$EstimatesTblTableTableManager(_db, _db.estimatesTbl);
  $$EstimateItemsTblTableTableManager get estimateItemsTbl =>
      $$EstimateItemsTblTableTableManager(_db, _db.estimateItemsTbl);
  $$ExpensesTblTableTableManager get expensesTbl =>
      $$ExpensesTblTableTableManager(_db, _db.expensesTbl);
  $$PaymentsTblTableTableManager get paymentsTbl =>
      $$PaymentsTblTableTableManager(_db, _db.paymentsTbl);
  $$ProductsTblTableTableManager get productsTbl =>
      $$ProductsTblTableTableManager(_db, _db.productsTbl);
  $$SuppliersTblTableTableManager get suppliersTbl =>
      $$SuppliersTblTableTableManager(_db, _db.suppliersTbl);
  $$PurchaseOrdersTblTableTableManager get purchaseOrdersTbl =>
      $$PurchaseOrdersTblTableTableManager(_db, _db.purchaseOrdersTbl);
  $$PoItemsTblTableTableManager get poItemsTbl =>
      $$PoItemsTblTableTableManager(_db, _db.poItemsTbl);
  $$TimeEntriesTblTableTableManager get timeEntriesTbl =>
      $$TimeEntriesTblTableTableManager(_db, _db.timeEntriesTbl);
  $$RecurringProfilesTblTableTableManager get recurringProfilesTbl =>
      $$RecurringProfilesTblTableTableManager(_db, _db.recurringProfilesTbl);
  $$StockMovementsTblTableTableManager get stockMovementsTbl =>
      $$StockMovementsTblTableTableManager(_db, _db.stockMovementsTbl);
  $$AppSettingsTblTableTableManager get appSettingsTbl =>
      $$AppSettingsTblTableTableManager(_db, _db.appSettingsTbl);
  $$SupplierPaymentsTblTableTableManager get supplierPaymentsTbl =>
      $$SupplierPaymentsTblTableTableManager(_db, _db.supplierPaymentsTbl);
}
