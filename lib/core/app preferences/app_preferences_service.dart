import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  Future<void> saveIsSeen(bool isSeen) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSeen', isSeen);
  }

  Future<bool?> getIsSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isSeen');
  }

  Future<void> saveEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<void> savePassword(String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<String?> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  Future<void> clearCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  Future<void> saveTempUnit(String unit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('temp_unit', unit);
  }

  Future<String> getTempUnit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('temp_unit') ?? 'metric';
  }

  Future<void> saveThemeMode(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', isDark);
  }

  Future<bool> getThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('is_dark_mode') ?? false;
  }

  Future<void> saveTimeFormat(String format) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('time_format', format);
  }

  Future<String> getTimeFormat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('time_format') ?? '24h';
  }
}
