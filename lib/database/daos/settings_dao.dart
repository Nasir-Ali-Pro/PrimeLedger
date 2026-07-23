import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database.dart';
import '../../models/settings.dart';
import '../../services/secure_storage_service.dart';

class SettingsDao {
  final AppDatabase _db;
  final SecureStorageService? _secureStorage;

  SettingsDao(this._db, [this._secureStorage]);

  Future<AppSettings> getSettings() async {
    try {
      final rows = await _db.select(_db.appSettingsTbl).get();
      final map = {for (final row in rows) row.key: row.value};
      return AppSettings(
        companyName: map['companyName'] ?? 'My Company',
        companyAddress: map['companyAddress'] ?? '123 Business St',
        companyEmail: map['companyEmail'] ?? 'hello@mycompany.com',
        companyPhone: map['companyPhone'],
        currencySymbol: map['currencySymbol'] ?? '\$',
        companyLogoBase64: map['companyLogoBase64'],
        numberFormat: map['numberFormat'] ?? 'millions',
        productMarkupPercent: double.tryParse(map['productMarkupPercent'] ?? '') ?? 30.0,
        defaultTaxPercent: double.tryParse(map['defaultTaxPercent'] ?? '') ?? 0.0,
        taxRegistrationNumber: map['taxRegistrationNumber']?.isNotEmpty == true ? map['taxRegistrationNumber'] : null,
        invoicePrefix: map['invoicePrefix']?.isNotEmpty == true ? map['invoicePrefix']! : 'INV',
        bankDetails: map['bankDetails']?.isNotEmpty == true ? map['bankDetails'] : null,
        defaultPaymentTermsDays: int.tryParse(map['defaultPaymentTermsDays'] ?? '') ?? 14,
      );
    } catch (e) {
      debugPrint('SettingsDao.getSettings error: $e');
      rethrow;
    }
  }

  Future<void> saveSettings(AppSettings settings) async {
    try {
      await _db.transaction(() async {
        await _set('companyName', settings.companyName);
        await _set('companyAddress', settings.companyAddress);
        await _set('companyEmail', settings.companyEmail);
        await _set('companyPhone', settings.companyPhone ?? '');
        await _set('currencySymbol', settings.currencySymbol);
        await _set('companyLogoBase64', settings.companyLogoBase64 ?? '');
        await _set('numberFormat', settings.numberFormat);
        await _set('productMarkupPercent', settings.productMarkupPercent.toString());
        await _set('defaultTaxPercent', settings.defaultTaxPercent.toString());
        await _set('taxRegistrationNumber', settings.taxRegistrationNumber ?? '');
        await _set('invoicePrefix', settings.invoicePrefix);
        await _set('bankDetails', settings.bankDetails ?? '');
        await _set('defaultPaymentTermsDays', settings.defaultPaymentTermsDays.toString());
      });
    } catch (e) {
      debugPrint('SettingsDao.saveSettings error: $e');
      rethrow;
    }
  }

  Future<String?> get(String key) async {
    try {
      if (key == 'app_pin' && _secureStorage != null) {
        var pin = await _secureStorage.read(key);
        if (pin == null) {
          // Check for legacy plaintext pin in database for migration
          final row = await (_db.select(_db.appSettingsTbl)..where((t) => t.key.equals(key))).getSingleOrNull();
          if (row != null && row.value.isNotEmpty) {
            pin = row.value;
            // Migrate to secure storage
            await _secureStorage.write(key, pin);
            // Delete plaintext legacy pin from SQLite database
            await (_db.delete(_db.appSettingsTbl)..where((t) => t.key.equals(key))).go();
          }
        }
        return pin;
      }
      final row = await (_db.select(_db.appSettingsTbl)..where((t) => t.key.equals(key))).getSingleOrNull();
      return row?.value;
    } catch (e) {
      debugPrint('SettingsDao.get error: $e');
      rethrow;
    }
  }

  Future<void> set(String key, String value) async {
    try {
      if (key == 'app_pin' && _secureStorage != null) {
        await _secureStorage.write(key, value);
        return;
      }
      await _set(key, value);
    } catch (e) {
      debugPrint('SettingsDao.set error: $e');
      rethrow;
    }
  }

  Future<void> _set(String key, String value) async {
    try {
      await _db.into(_db.appSettingsTbl).insertOnConflictUpdate(
        AppSettingsTblCompanion(key: Value(key), value: Value(value)),
      );
    } catch (e) {
      debugPrint('SettingsDao._set error: $e');
      rethrow;
    }
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    try {
      final val = await get(key);
      if (val == null) return defaultValue;
      return val == 'true';
    } catch (e) {
      debugPrint('SettingsDao.getBool error: $e');
      rethrow;
    }
  }

  Future<void> setBool(String key, bool value) async {
    try {
      await set(key, value.toString());
    } catch (e) {
      debugPrint('SettingsDao.setBool error: $e');
      rethrow;
    }
  }
}
