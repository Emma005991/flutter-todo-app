import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  static const String boxName = 'themeBox';
  static const String key = 'isDarkMode';

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    loadTheme();
  }

  void loadTheme() {
    final box = Hive.box(boxName);
    _isDarkMode = box.get(key, defaultValue: false);
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    Hive.box(boxName).put(key, _isDarkMode);
    notifyListeners();
  }
}
