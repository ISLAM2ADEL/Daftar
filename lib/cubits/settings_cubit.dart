import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:daftra/cubits/settings_state.dart';
import 'package:daftra/data/hive_boxes.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    loadTheme();
  }

  Box get _box => Hive.box(settingsBox);

  /// Reads persisted theme from the settings box.
  void loadTheme() {
    final stored = _box.get('themeMode', defaultValue: 'dark') as String;
    final mode = stored == 'light' ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: mode));
  }

  /// Toggles between light and dark and persists the choice.
  Future<void> toggleTheme() async {
    final isDark = state.themeMode == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    await _box.put('themeMode', isDark ? 'light' : 'dark');
    emit(state.copyWith(themeMode: newMode));
  }
}
