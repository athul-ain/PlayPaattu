import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { dark, light, auto }

ThemeData light = ThemeData(
  primarySwatch: Colors.deepOrange,
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ),
    elevation: 0,
    color: Colors.deepOrange[50],
  ),
  navigationRailTheme:
      const NavigationRailThemeData(backgroundColor: Colors.white),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.deepOrange[50],
  ),
);

ThemeData dark = ThemeData(
  primarySwatch: Colors.deepOrange,
  brightness: Brightness.dark,
  backgroundColor: Colors.black26,
  canvasColor: Colors.grey[900],
  primaryColor: Colors.deepOrange,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
    color: Colors.grey[900],
    iconTheme: IconThemeData(color: Colors.grey[50]),
    titleTextStyle: TextStyle(color: Colors.grey[50], fontSize: 20),
  ),
  navigationRailTheme:
      NavigationRailThemeData(backgroundColor: Colors.grey[900]),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences? _prefs;

  AppTheme _appTheme = AppTheme.auto;
  AppTheme get appTheme => _appTheme;

  ThemeNotifier() {
    _loadFromPrefs();
  }

  setAutoTheme() {
    _appTheme = AppTheme.auto;
    _saveToPrefs();
    notifyListeners();
  }

  setLightTheme() {
    _appTheme = AppTheme.light;
    _saveToPrefs();
    notifyListeners();
  }

  setDarkTheme() {
    _appTheme = AppTheme.dark;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    int t = _prefs!.getInt(key) ?? 0;
    if (t == 1) {
      _appTheme = AppTheme.light;
    } else if (t == 2) {
      _appTheme = AppTheme.dark;
    } else {
      _appTheme = AppTheme.auto;
    }
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    int t;
    if (_appTheme == AppTheme.light) {
      t = 1;
    } else if (_appTheme == AppTheme.dark) {
      t = 2;
    } else {
      t = 0;
    }
    _prefs!.setInt(key, t);
  }
}
