import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/settings.dart';
import '../database/database_provider.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(() {
  return SettingsNotifier();
});

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    _load();
    return const AppSettings(
      companyName: 'My Company',
      companyAddress: '123 Business St',
      companyEmail: 'hello@mycompany.com',
      currencySymbol: '\$',
    );
  }

  Future<void> _load() async {
    try {
      final dao = ref.read(settingsDaoProvider);
      final settings = await dao.getSettings();
      state = settings;
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  Future<void> updateSettings(AppSettings newSettings) async {
    try {
      await ref.read(settingsDaoProvider).saveSettings(newSettings);
      state = newSettings;
    } catch (e) {
      debugPrint('Error updating settings: $e');
      rethrow;
    }
  }
}

class IsUnlockedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setUnlocked(bool val) {
    state = val;
  }
}

final isUnlockedProvider = NotifierProvider<IsUnlockedNotifier, bool>(IsUnlockedNotifier.new);

