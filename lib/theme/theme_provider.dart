import 'package:flutter/material.dart';
import 'package:freshers/theme/theme1.dart';
import 'package:freshers/theme/theme2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = theme1; // Default theme
  bool _isDarkMode = false;

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    _saveTheme();
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == theme1) {
      themeData = theme2;
      _isDarkMode = true;
    } else {
      themeData = theme1;
      _isDarkMode = false;
    }
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (_themeData == theme1) {
      await prefs.setBool('isDarkMode', false);
    } else {
      await prefs.setBool('isDarkMode', true);
    }
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode) {
      _themeData = theme2;
      _isDarkMode = true;
    } else {
      _themeData = theme1;
      _isDarkMode = false;
    }
  }
}
