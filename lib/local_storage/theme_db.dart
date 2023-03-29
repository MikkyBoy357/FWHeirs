import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fwheirs/base/enums/my_theme_mode.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// import '../enums/delivery_status.dart';
// import '../model/food_model.dart';

class ThemeDataBaseService {
  bool _isInitialized = false;
  static const String dbName = 'myThemeBox';
  static Future<void> startService() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    Hive.registerAdapter(MyThemeModeAdapter());
    // Hive.registerAdapter(DeliveryStatusAdapter());
    await Hive.openBox<MyThemeMode>(dbName);
  }

  Future<void> init() async {
    try {
      // await Hive.openBox<MyMyThemeMode>(dbName);
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
    }
  }

  MyThemeMode? getMyThemeMode() {
    return Hive.box<MyThemeMode>(dbName).get("theme");
  }

  void saveTheme(ThemeMode newThemeMode) {
    final Box<MyThemeMode> themeBox = Hive.box<MyThemeMode>(dbName);

    final theme = (newThemeMode == ThemeMode.light
        ? MyThemeMode.light
        : MyThemeMode.dark);
    themeBox.put("theme", theme);
  }

  List<MyThemeMode> getMikeList() {
    return Hive.box<MyThemeMode>(dbName).values.toList();
  }

  Future<void> ensureInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }

  Future<void> closeDB() async {
    await Hive.close();
  }

  Future<void> clearDB() async {
    await Hive.box(dbName).clear();
  }

  Future<void> deleteToken() async {
    await Hive.box(dbName).clear();
  }

// static Future<void> clearDB() async {
//   await Hive.box(dbName).clear();
// }
}
