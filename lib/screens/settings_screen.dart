import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../models/settings.dart';
import '../providers/settings_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/invoice_provider.dart';
import '../providers/expense_provider.dart';
import '../providers/payment_provider.dart';
import '../providers/product_provider.dart';
import '../providers/estimate_provider.dart';
import '../providers/client_provider.dart';
import '../providers/supplier_provider.dart';
import '../providers/purchase_order_provider.dart';
import '../providers/time_entry_provider.dart';
import '../providers/recurring_profile_provider.dart';
import '../database/database_provider.dart';
import '../utils/error_handler.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _currencyController;
  late TextEditingController _markupController;
  late TextEditingController _taxPercentController;
  late TextEditingController _taxRegController;
  late TextEditingController _prefixController;
  late TextEditingController _bankDetailsController;
  late TextEditingController _paymentTermsController;
  String? _logoBase64;
  String _numberFormat = 'millions';
  String _appVersion = '1.0.0';

  @override
  void initState() {
    super.initState();
    final currentSettings = ref.read(settingsProvider);
    _nameController = TextEditingController(text: currentSettings.companyName);
    _addressController = TextEditingController(text: currentSettings.companyAddress);
    _emailController = TextEditingController(text: currentSettings.companyEmail);
    _phoneController = TextEditingController(text: currentSettings.companyPhone ?? '');
    _currencyController = TextEditingController(text: currentSettings.currencySymbol);
    _markupController = TextEditingController(text: currentSettings.productMarkupPercent.toStringAsFixed(0));
    _taxPercentController = TextEditingController(text: currentSettings.defaultTaxPercent.toString());
    _taxRegController = TextEditingController(text: currentSettings.taxRegistrationNumber ?? '');
    _prefixController = TextEditingController(text: currentSettings.invoicePrefix);
    _bankDetailsController = TextEditingController(text: currentSettings.bankDetails ?? '');
    _paymentTermsController = TextEditingController(text: currentSettings.defaultPaymentTermsDays.toString());
    _logoBase64 = currentSettings.companyLogoBase64;
    _numberFormat = currentSettings.numberFormat;
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
      });
    } catch (e) {
      debugPrint('Error loading version: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currencyController.dispose();
    _markupController.dispose();
    _taxPercentController.dispose();
    _taxRegController.dispose();
    _prefixController.dispose();
    _bankDetailsController.dispose();
    _paymentTermsController.dispose();
    super.dispose();
  }

  Future<void> _confirmReset(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset All Data?'),
        content: const Text('This will permanently delete all invoices, expenses, clients, products, and other data. This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFEF4444)),
            child: const Text('Reset Everything', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      final settingsDao = ref.read(settingsDaoProvider);
      final hasSeenOnboarding = await settingsDao.getBool('has_seen_onboarding', defaultValue: false);
      final appPin = await settingsDao.get('app_pin');

      await ref.read(databaseProvider).clearAll();

      await settingsDao.setBool('has_seen_onboarding', hasSeenOnboarding);
      if (appPin != null) await settingsDao.set('app_pin', appPin);

      ref.invalidate(invoicesProvider);
      ref.invalidate(expensesProvider);
      ref.invalidate(paymentsProvider);
      ref.invalidate(productsProvider);
      ref.invalidate(estimatesProvider);
      ref.invalidate(clientsProvider);
      ref.invalidate(suppliersProvider);
      ref.invalidate(purchaseOrdersProvider);
      ref.invalidate(timeEntriesProvider);
      ref.invalidate(recurringProfilesProvider);
      ref.invalidate(settingsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All data cleared successfully!'), backgroundColor: Color(0xFF10B981)),
        );
      }
    }
  }

  Future<void> _exportBackup(BuildContext context) async {
    try {
      final db = ref.read(databaseProvider);
      final jsonString = await db.exportBackup();
      
      final tempDir = await getTemporaryDirectory();
      final backupFile = File('${tempDir.path}/primeledger_backup_${DateTime.now().millisecondsSinceEpoch}.json');
      await backupFile.writeAsString(jsonString);

      final result = await Share.shareXFiles(
        [XFile(backupFile.path)],
        text: 'PrimeLedger Database Backup',
      );
      if (context.mounted && result.status == ShareResultStatus.success) {
        AppErrorHandler.showSuccessSnackBar(context, 'Backup exported successfully!');
      }
    } catch (e) {
      if (context.mounted) {
        AppErrorHandler.showErrorSnackBar(context, e, prefix: 'Export failed');
      }
    }
  }

  Future<void> _importBackup(BuildContext context) async {
    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Import Backup?'),
          content: const Text('This will overwrite all existing data in the app. This action cannot be undone.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: TextButton.styleFrom(foregroundColor: const Color(0xFF6366F1)),
              child: const Text('Import & Overwrite', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      final pickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (pickerResult == null || pickerResult.files.single.path == null) {
        return;
      }

      final file = File(pickerResult.files.single.path!);
      final jsonString = await file.readAsString();

      final db = ref.read(databaseProvider);
      await db.importBackup(jsonString);

      ref.invalidate(invoicesProvider);
      ref.invalidate(expensesProvider);
      ref.invalidate(paymentsProvider);
      ref.invalidate(productsProvider);
      ref.invalidate(estimatesProvider);
      ref.invalidate(clientsProvider);
      ref.invalidate(suppliersProvider);
      ref.invalidate(purchaseOrdersProvider);
      ref.invalidate(timeEntriesProvider);
      ref.invalidate(recurringProfilesProvider);
      ref.invalidate(settingsProvider);

      if (context.mounted) {
        AppErrorHandler.showSuccessSnackBar(context, 'Backup imported successfully!');
      }
    } catch (e) {
      if (context.mounted) {
        AppErrorHandler.showErrorSnackBar(context, e, prefix: 'Import failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appearance Section
              Text('Appearance', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Builder(
                        builder: (ctx) {
                          final isDark = Theme.of(ctx).brightness == Brightness.dark || themeMode == ThemeMode.dark;
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: const Color(0xFF6366F1)),
                            title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text(isDark ? 'Dark theme active' : 'Light theme active'),
                            trailing: Switch(
                              value: isDark,
                              activeThumbColor: const Color(0xFF6366F1),
                              onChanged: (val) {
                                ref.read(themeModeProvider.notifier).setThemeMode(val ? ThemeMode.dark : ThemeMode.light);
                              },
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.lock_outline, color: Color(0xFF6366F1)),
                        title: const Text('App Security', style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: const Text('Require PIN on startup'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.go('/settings/pin'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Advanced Features Section
              Text('Advanced Features', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.timer, color: Color(0xFF6366F1)),
                        title: const Text('Time Tracker', style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: const Text('Log billable hours for clients'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.go('/time-tracker'),
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.autorenew, color: Color(0xFF6366F1)),
                        title: const Text('Recurring Invoices', style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: const Text('Manage automated billing cycles'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.go('/recurring'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Business Profile Section
              Text('Business Profile', style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('This information appears on your PDF invoices.', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              final picker = ImagePicker();
                              final image = await picker.pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                final bytes = await image.readAsBytes();
                                final appDir = await getApplicationDocumentsDirectory();
                                final logoFile = File('${appDir.path}/company_logo_${DateTime.now().millisecondsSinceEpoch}.png');
                                await logoFile.writeAsBytes(bytes);
                                setState(() {
                                  _logoBase64 = logoFile.path;
                                });
                              }
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                              backgroundImage: _logoBase64 != null
                                  ? (File(_logoBase64!).existsSync()
                                      ? FileImage(File(_logoBase64!))
                                      : MemoryImage(base64Decode(_logoBase64!))) as ImageProvider
                                  : null,
                              child: _logoBase64 == null ? const Icon(Icons.add_a_photo, size: 32) : null,
                            ),
                          ),
                        ),
                        if (_logoBase64 != null)
                          TextButton(
                            onPressed: () => setState(() => _logoBase64 = null),
                            child: const Text('Remove Logo', style: TextStyle(color: Colors.red)),
                          ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Company Name', prefixIcon: Icon(Icons.business)),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email Address', prefixIcon: Icon(Icons.email)),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(labelText: 'Mobile Number', prefixIcon: Icon(Icons.phone)),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _addressController,
                          maxLines: 3,
                          decoration: const InputDecoration(labelText: 'Billing Address', prefixIcon: Icon(Icons.location_on)),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _currencyController,
                          decoration: const InputDecoration(labelText: 'Currency Symbol', prefixIcon: Icon(Icons.attach_money)),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: _numberFormat,
                          items: const [
                            DropdownMenuItem(value: 'millions', child: Text('Millions / Billions (e.g. 1,234,567.89)', overflow: TextOverflow.ellipsis)),
                            DropdownMenuItem(value: 'lakhs', child: Text('Lakhs / Crores (e.g. 12,34,567.89)', overflow: TextOverflow.ellipsis)),
                          ],
                          onChanged: (v) => setState(() => _numberFormat = v ?? 'millions'),
                          decoration: const InputDecoration(
                            labelText: 'Number Formatting',
                            prefixIcon: Icon(Icons.pin),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _markupController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Default Purchase Markup',
                            prefixIcon: Icon(Icons.trending_up),
                            suffixText: '%',
                            helperText: 'Default markup added to cost price when creating products from received POs',
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Required';
                            final parsed = double.tryParse(v);
                            if (parsed == null || parsed < 0) return 'Must be a valid positive percentage';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _taxPercentController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Default Tax Rate',
                            prefixIcon: Icon(Icons.receipt_long_outlined),
                            suffixText: '%',
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Required';
                            final parsed = double.tryParse(v);
                            if (parsed == null || parsed < 0) return 'Must be a valid positive percentage';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _taxRegController,
                          decoration: const InputDecoration(
                            labelText: 'Tax Registration Number',
                            prefixIcon: Icon(Icons.receipt_long),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _prefixController,
                          decoration: const InputDecoration(
                            labelText: 'Invoice Number Prefix',
                            prefixIcon: Icon(Icons.tag),
                          ),
                          validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _paymentTermsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Default Payment Terms (Days)',
                            prefixIcon: Icon(Icons.calendar_month),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Required';
                            final parsed = int.tryParse(v);
                            if (parsed == null || parsed < 0) return 'Must be a positive integer';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _bankDetailsController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Bank Account / Payment Details',
                            prefixIcon: Icon(Icons.account_balance),
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final newSettings = AppSettings(
                                  companyName: _nameController.text,
                                  companyAddress: _addressController.text,
                                  companyEmail: _emailController.text,
                                  companyPhone: _phoneController.text.isEmpty ? null : _phoneController.text,
                                  currencySymbol: _currencyController.text,
                                  companyLogoBase64: _logoBase64,
                                  numberFormat: _numberFormat,
                                  productMarkupPercent: double.tryParse(_markupController.text) ?? 30.0,
                                  defaultTaxPercent: double.tryParse(_taxPercentController.text) ?? 0.0,
                                  taxRegistrationNumber: _taxRegController.text.isEmpty ? null : _taxRegController.text,
                                  invoicePrefix: _prefixController.text.isEmpty ? 'INV' : _prefixController.text,
                                  bankDetails: _bankDetailsController.text.isEmpty ? null : _bankDetailsController.text,
                                  defaultPaymentTermsDays: int.tryParse(_paymentTermsController.text) ?? 14,
                                );
                                await ref.read(settingsProvider.notifier).updateSettings(newSettings);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Settings saved successfully!'), backgroundColor: Color(0xFF10B981)),
                                  );
                                }
                              }
                            },
                            child: const Text('Save Settings'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Data Management Section
              Text('Data Management', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.upload, color: Color(0xFF10B981), size: 24),
                        ),
                        title: const Text('Export Backup', style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('Save a copy of all your financial data to local file', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
                        onTap: () => _exportBackup(context),
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.download, color: Color(0xFF6366F1), size: 24),
                        ),
                        title: const Text('Import Backup', style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('Restore database from a previously saved backup file', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
                        onTap: () => _importBackup(context),
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.delete_sweep, color: Color(0xFFEF4444), size: 24),
                        ),
                        title: const Text('Reset All Data', style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('Clear all invoices, expenses, clients and other data', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
                        onTap: () => _confirmReset(context),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // About Section
              Text('About', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/prime_ledger_logo.png',
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: const Text('PrimeLedger', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        subtitle: Text('v$_appVersion • Invoicing, Stock & Ledger SaaS'),
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.info_outline, color: Color(0xFF6366F1)),
                        title: const Text('Features'),
                        subtitle: const Text('Invoices, Estimates, Expenses, Inventory, PDF Export'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
