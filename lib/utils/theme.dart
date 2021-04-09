import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { dark, light, auto }

ThemeData light = ThemeData(
    primarySwatch: Colors.deepOrange,
    accentColor: Colors.deepOrange,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        color: Colors.white,
        elevation: 1.5,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        textTheme: TextTheme(
            headline6: TextStyle(color: Colors.grey[700], fontSize: 20))),
    navigationRailTheme:
        NavigationRailThemeData(backgroundColor: Colors.white));

ThemeData dark = ThemeData(
    primarySwatch: Colors.deepOrange,
    brightness: Brightness.dark,
    backgroundColor: Colors.black26,
    canvasColor: Colors.grey[900],
    accentColor: Color.fromRGBO(156, 45, 11, 1),
    primaryColor: Colors.deepOrange,
    appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        color: Colors.grey[900],
        iconTheme: IconThemeData(color: Colors.grey[50]),
        textTheme: TextTheme(
            headline6: TextStyle(color: Colors.grey[50], fontSize: 20))),
    navigationRailTheme:
        NavigationRailThemeData(backgroundColor: Colors.grey[900]));

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
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    int t = _prefs!.getInt(key) ?? 0;
    if (t == 1)
      _appTheme = AppTheme.light;
    else if (t == 2)
      _appTheme = AppTheme.dark;
    else
      _appTheme = AppTheme.auto;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    int t;
    if (_appTheme == AppTheme.light)
      t = 1;
    else if (_appTheme == AppTheme.dark)
      t = 2;
    else
      t = 0;
    _prefs!.setInt(key, t);
  }
}
