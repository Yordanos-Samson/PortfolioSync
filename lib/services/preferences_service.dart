import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _themeKey = 'isDarkMode';
  SharedPreferences? _prefs;

  // Initialize SharedPreferences asynchronously
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Check if initialized before accessing
  bool getThemePreference() {
    if (_prefs == null) {
      // Return a default value instead of throwing an error
      return false; // Default to light mode
    }
    return _prefs!.getBool(_themeKey) ?? false;
  }

  Future<void> setThemePreference(bool isDarkMode) async {
    if (_prefs == null) {
      await init(); // Initialize if not already done
    }
    await _prefs!.setBool(_themeKey, isDarkMode);
  }
}
