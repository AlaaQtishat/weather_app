import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RecentsService {
  static const String _recentsKey = 'recent_searches_key';
  static const int _maxRecents = 10;

  Future<void> saveRecentSearches(
    String name,
    String country,
    double lat,
    double lon,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentList = prefs.getStringList(_recentsKey) ?? [];

    Map<String, dynamic> newCityMap = {
      'name': name,
      'country': country,
      'lat': lat,
      'lon': lon,
    };
    String newCityJson = jsonEncode(newCityMap);

    currentList.removeWhere((item) {
      Map<String, dynamic> decodedItem = jsonDecode(item);
      return decodedItem['name'] == name && decodedItem['country'] == country;
    });

    currentList.insert(0, newCityJson);

    if (currentList.length > _maxRecents) {
      currentList.removeLast();
    }

    await prefs.setStringList(_recentsKey, currentList);
  }

  Future<List<Map<String, dynamic>>> getRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentList = prefs.getStringList(_recentsKey) ?? [];

    return currentList
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

  Future<void> removeRecentSearch(String name, String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentList = prefs.getStringList(_recentsKey) ?? [];

    currentList.removeWhere((item) {
      Map<String, dynamic> decodedItem = jsonDecode(item);
      return decodedItem['name'] == name && decodedItem['country'] == country;
    });

    await prefs.setStringList(_recentsKey, currentList);
  }

  Future<void> clearAllRecents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentsKey);
  }
}
