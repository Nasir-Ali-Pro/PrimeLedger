import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_provider.dart';

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _load();
    return ThemeMode.system;
  }

  Future<void> _load() async {
    try {
      final dao = ref.read(settingsDaoProvider);
      final stored = await dao.get('themeMode');
      switch (stored) {
        case 'light':
          state = ThemeMode.light;
        case 'dark':
          state = ThemeMode.dark;
        default:
          state = ThemeMode.system;
      }
    } catch (e) {
      debugPrint('Error loading theme: $e');
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      String modeStr;
      switch (mode) {
        case ThemeMode.light:
          modeStr = 'light';
        case ThemeMode.dark:
          modeStr = 'dark';
        default:
          modeStr = 'system';
      }
      final dao = ref.read(settingsDaoProvider);
      await dao.set('themeMode', modeStr);
      state = mode;
    } catch (e) {
      debugPrint('Error setting theme mode: $e');
    }
  }

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      setThemeMode(ThemeMode.light);
    } else {
      setThemeMode(ThemeMode.dark);
    }
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
