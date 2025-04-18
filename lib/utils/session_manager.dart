import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _keyLogin = 'is_logged_in';
  static const _keyUsername = 'username';

  static SharedPreferences? _prefs;

  static Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> saveLogin(String username) async {
    await _init();
    await _prefs!.setBool(_keyLogin, true);
    await _prefs!.setString(_keyUsername, username);
  }

  static Future<bool> isLoggedIn() async {
    await _init();
    return _prefs!.getBool(_keyLogin) ?? false;
  }

  static Future<String?> getUsername() async {
    await _init();
    return _prefs!.getString(_keyUsername);
  }

  static Future<void> logout() async {
    await _init();
    await _prefs!.clear();
  }
}
