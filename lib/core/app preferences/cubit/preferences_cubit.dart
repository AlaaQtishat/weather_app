import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/app%20preferences/app_preferences_service.dart';
import 'package:weather_app/core/app%20preferences/cubit/preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  final AppPreferences _prefs = AppPreferences();

  PreferencesCubit()
    : super(
        const PreferencesState(
          tempUnit: 'metric',
          timeFormat: '24h',
          isDarkMode: false,
        ),
      ) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final tempUnit = await _prefs.getTempUnit();
    final timeFormat = await _prefs.getTimeFormat();
    final isDarkMode = await _prefs.getThemeMode();

    emit(
      PreferencesState(
        tempUnit: tempUnit,
        timeFormat: timeFormat,
        isDarkMode: isDarkMode,
      ),
    );
  }

  Future<void> changeTempUnit(String unit) async {
    await _prefs.saveTempUnit(unit);

    emit(state.copyWith(tempUnit: unit));
  }

  Future<void> changeTimeFormat(String format) async {
    await _prefs.saveTimeFormat(format);

    emit(state.copyWith(timeFormat: format));
  }

  Future<void> toggleTheme(bool isDark) async {
    await _prefs.saveThemeMode(isDark);

    emit(state.copyWith(isDarkMode: isDark));
  }
}
