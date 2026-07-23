class AppSettings {
  final String companyName;
  final String companyAddress;
  final String companyEmail;
  final String? companyPhone;
  final String currencySymbol;
  final String? companyLogoBase64;
  final String numberFormat; // 'millions' or 'lakhs'
  final double productMarkupPercent;
  final double defaultTaxPercent;
  final String? taxRegistrationNumber;
  final String invoicePrefix;
  final String? bankDetails;
  final int defaultPaymentTermsDays;

  const AppSettings({
    required this.companyName,
    required this.companyAddress,
    required this.companyEmail,
    this.companyPhone,
    required this.currencySymbol,
    this.companyLogoBase64,
    this.numberFormat = 'millions',
    this.productMarkupPercent = 30.0,
    this.defaultTaxPercent = 0.0,
    this.taxRegistrationNumber,
    this.invoicePrefix = 'INV',
    this.bankDetails,
    this.defaultPaymentTermsDays = 14,
  });

  AppSettings copyWith({
    String? companyName,
    String? companyAddress,
    String? companyEmail,
    String? companyPhone,
    String? currencySymbol,
    String? companyLogoBase64,
    String? numberFormat,
    double? productMarkupPercent,
    double? defaultTaxPercent,
    String? taxRegistrationNumber,
    String? invoicePrefix,
    String? bankDetails,
    int? defaultPaymentTermsDays,
  }) {
    return AppSettings(
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      companyEmail: companyEmail ?? this.companyEmail,
      companyPhone: companyPhone ?? this.companyPhone,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      companyLogoBase64: companyLogoBase64 ?? this.companyLogoBase64,
      numberFormat: numberFormat ?? this.numberFormat,
      productMarkupPercent: productMarkupPercent ?? this.productMarkupPercent,
      defaultTaxPercent: defaultTaxPercent ?? this.defaultTaxPercent,
      taxRegistrationNumber: taxRegistrationNumber ?? this.taxRegistrationNumber,
      invoicePrefix: invoicePrefix ?? this.invoicePrefix,
      bankDetails: bankDetails ?? this.bankDetails,
      defaultPaymentTermsDays: defaultPaymentTermsDays ?? this.defaultPaymentTermsDays,
    );
  }

  factory AppSettings.fromMap(Map<dynamic, dynamic> map) {
    return AppSettings(
      companyName: map['companyName'] ?? 'My Company',
      companyAddress: map['companyAddress'] ?? '123 Business St',
      companyEmail: map['companyEmail'] ?? 'hello@mycompany.com',
      companyPhone: map['companyPhone'],
      currencySymbol: map['currencySymbol'] ?? '\$',
      companyLogoBase64: map['companyLogoBase64'],
      numberFormat: map['numberFormat'] ?? 'millions',
      productMarkupPercent: (map['productMarkupPercent'] as num?)?.toDouble() ?? 30.0,
      defaultTaxPercent: (map['defaultTaxPercent'] as num?)?.toDouble() ?? 0.0,
      taxRegistrationNumber: map['taxRegistrationNumber'],
      invoicePrefix: map['invoicePrefix'] ?? 'INV',
      bankDetails: map['bankDetails'],
      defaultPaymentTermsDays: (map['defaultPaymentTermsDays'] as num?)?.toInt() ?? 14,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'companyAddress': companyAddress,
      'companyEmail': companyEmail,
      'companyPhone': companyPhone,
      'currencySymbol': currencySymbol,
      'companyLogoBase64': companyLogoBase64,
      'numberFormat': numberFormat,
      'productMarkupPercent': productMarkupPercent,
      'defaultTaxPercent': defaultTaxPercent,
      'taxRegistrationNumber': taxRegistrationNumber,
      'invoicePrefix': invoicePrefix,
      'bankDetails': bankDetails,
      'defaultPaymentTermsDays': defaultPaymentTermsDays,
    };
  }

  String formatNumber(double value) {
    if (numberFormat == 'lakhs') {
      return _formatLakhs(value);
    } else {
      return _formatMillions(value);
    }
  }

  String formatCurrency(double value) {
    return '$currencySymbol${formatNumber(value)}';
  }

  static String _formatLakhs(double value) {
    List<String> parts = value.toStringAsFixed(2).split('.');
    String integerPart = parts[0];
    String decimalPart = parts[1];
    
    bool isNegative = integerPart.startsWith('-');
    if (isNegative) {
      integerPart = integerPart.substring(1);
    }

    if (integerPart.length <= 3) {
      return '${isNegative ? '-' : ''}$integerPart.$decimalPart';
    }

    String lastThree = integerPart.substring(integerPart.length - 3);
    String remaining = integerPart.substring(0, integerPart.length - 3);

    String result = '';
    while (remaining.length > 2) {
      result = ',${remaining.substring(remaining.length - 2)}$result';
      remaining = remaining.substring(0, remaining.length - 2);
    }
    if (remaining.isNotEmpty) {
      result = '$remaining$result';
    } else {
      if (result.startsWith(',')) result = result.substring(1);
    }

    return '${isNegative ? '-' : ''}$result,$lastThree.$decimalPart';
  }

  static String _formatMillions(double value) {
    List<String> parts = value.toStringAsFixed(2).split('.');
    String integerPart = parts[0];
    String decimalPart = parts[1];
    
    bool isNegative = integerPart.startsWith('-');
    if (isNegative) {
      integerPart = integerPart.substring(1);
    }

    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String result = integerPart.replaceAllMapped(reg, (Match m) => '${m[1]},');
    return '${isNegative ? '-' : ''}$result.$decimalPart';
  }
}
