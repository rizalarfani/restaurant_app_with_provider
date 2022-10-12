import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeConfigProvider extends ChangeNotifier {
  static const themeKey = 'theme_key';
  bool? _isDark;

  bool get isDark => _isDark == null ? false : _isDark!;

  ThemeConfigProvider() {
    _isDark = false;
    getPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await getTheme();
    notifyListeners();
  }

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(themeKey, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(themeKey);
  }
}
