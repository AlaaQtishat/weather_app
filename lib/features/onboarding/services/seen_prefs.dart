import 'package:shared_preferences/shared_preferences.dart';

class SeenPrefs {
  Future<void> saveIsSeen(bool isSeen) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSeen', isSeen);
  }

  Future<bool?> getIsSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isSeen');
  }
}
