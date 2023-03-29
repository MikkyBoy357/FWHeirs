import 'package:flutter/material.dart';
import 'package:fwheirs/base/enums/my_theme_mode.dart';
import 'package:fwheirs/dependency_injection/locator.dart';
import 'package:fwheirs/local_storage/theme_db.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode =>
      locator<ThemeDataBaseService>().getMyThemeMode() == MyThemeMode.light
          ? ThemeMode.light
          : ThemeMode.dark;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    locator<ThemeDataBaseService>().saveTheme(_themeMode);
    notifyListeners();
  }

  void getThemeFromDB() {}
}
