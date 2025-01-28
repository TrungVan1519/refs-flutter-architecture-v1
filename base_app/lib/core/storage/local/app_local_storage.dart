import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  AppLocalStorage._();

  static final instance = AppLocalStorage._();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void set(String key, dynamic value) async {
    await _prefs.setString(key, value);
  }

  String? get(String key) {
    return _prefs.getString(key);
  }
}
