// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'theme_state.dart';
//
// class ThemeCubit extends Cubit<ThemeState> {
//   static const String _themeKey = 'is_dark_mode';
//
//   ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.light)) {
//     _loadTheme();
//   }
//
//   Future<void> _loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isDark = prefs.getBool(_themeKey) ?? false;
//
//     emit(ThemeState(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
//   }
//
//   Future<void> toggleTheme(bool isDark) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_themeKey, isDark);
//
//     emit(ThemeState(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
//   }
// }
