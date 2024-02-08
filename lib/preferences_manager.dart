import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();

  factory PreferencesManager() {
    return _instance;
  }

  PreferencesManager._internal();

  static const String _themeKey = 'theme';
  static const String _languageKey = 'language';

  late bool _isDarkMode;
  late bool _isTamilMode;

  bool get isDarkMode => _isDarkMode;
  bool get isTamilMode => _isTamilMode;

  Future<void> init() async {
    _isDarkMode = await getTheme();
    _isTamilMode = await getLanguage();
  }

  static Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false; // Default to light theme
  }

  static void setTheme(bool isDark) {
    SharedPreferences.getInstance().then((prefs) {
      return prefs.setBool(_themeKey, isDark);
    });
  }

  static Future<bool> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_languageKey) ?? false; // Default to English
  }

  static void setLanguage(bool isTamil) {
    SharedPreferences.getInstance().then((prefs) {
      return prefs.setBool(_languageKey, isTamil);
    });
  }
}