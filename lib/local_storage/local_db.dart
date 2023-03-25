import 'dart:io';

import 'package:fwheirs/app/models/token_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// import '../enums/delivery_status.dart';
// import '../model/food_model.dart';

class AppDataBaseService {
  bool _isInitialized = false;
  static const String dbName = 'tokenBox';
  static Future<void> startService() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    Hive.registerAdapter(TokenModelAdapter());
    // Hive.registerAdapter(DeliveryStatusAdapter());
    await Hive.openBox<TokenModel>(dbName);
  }

  Future<void> init() async {
    try {
      await Hive.openBox<TokenModel>(dbName);
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
    }
  }

  String? getTokenString() {
    return Hive.box<TokenModel>(dbName).values.first.token;
  }

  void saveToken(String newToken) {
    final Box<TokenModel> tokenBox = Hive.box<TokenModel>(dbName);

    final token = TokenModel()..token = newToken;
    tokenBox.put("token", token);
    token.save();
  }

  List<TokenModel> getMikeList() {
    return Hive.box<TokenModel>(dbName).values.toList();
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
