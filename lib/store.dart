import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppConfig {
  ThemeMode themeMode = ThemeMode.system;

  AppConfig copyWith({ThemeMode? themeMode}) {
    return AppConfig()..themeMode = themeMode ?? this.themeMode;
  }
}

class AppConfigNotifier extends StateNotifier<AppConfig> {
  AppConfigNotifier() : super(AppConfig());

  void changeThemeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
  }
}

final appConfigProvider = StateNotifierProvider<AppConfigNotifier, AppConfig>((ref) => AppConfigNotifier());
