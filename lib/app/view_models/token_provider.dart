// import 'dart:io';
// import 'dart:math';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:foodtalk/enums/delivery_status.dart';
// import 'package:foodtalk/model/food_model.dart';
// import 'package:foodtalk/screens/food_list/not_found_screen.dart';
// import 'package:foodtalk/utils/boxes.dart';
// import 'package:fwheirs/app/models/token_model.dart';
// import 'package:hive/hive.dart';
//
// import '../../dependency_injection/locator.dart';
// import '../../local_storage/local_db.dart';
// import '../screens/food_details_screen.dart';
//
// class FoodProvider extends ChangeNotifier {
//   /// Hive CRUD
//   void loadFoodList() {
//     print('====> Load Food List <====');
//     foodList = Boxes.getFoods().values.toList();
//     getBatteryLevel();
//     // getIntentData();
//     // notifyListeners();
//   }
//
//   Future<List<Food>> loadFoodList2() async {
//     print('====> Load Food List <====');
//     foodList = locator<AppDataBaseService>().getMikeList().values.toList();
//     getBatteryLevel();
//     // getIntentData();
//     // notifyListeners();
//     return foodList;
//   }
//
//   void addFood(BuildContext context) {
//     if (foodName.isNotEmpty) {
//       final food = Food()
//         ..name = foodName
//         ..deliveryStatus = deliveryStatus;
//
//       final foodBox = Boxes.getFoods();
//       foodBox.add(food);
//       Navigator.pop(context);
//       food.save();
//       print('$foodName added Succesfully');
//     } else {
//       return print('Invalid Fields');
//     }
//     notifyListeners();
//   }
//
//   void editFood(BuildContext context, Food previousFood) {
//     print('====> Edit ${previousFood.name} <====');
//     if (foodName.isNotEmpty) {
//       final newFood = previousFood
//         ..name = foodName
//         ..deliveryStatus = deliveryStatus;
//
//       final foodBox = Boxes.getFoods();
//       print('KEY => ${newFood.key}');
//       newFood.save();
//       Navigator.pop(context);
//       print('$foodName added Succesfully');
//     } else {
//       return print('Invalid Fields');
//     }
//     loadFoodList();
//     notifyListeners();
//   }
//
//   void deleteToken(TokenModel token) {
//     final foodBox = Boxes.getFoods();
//
//     // foodBox.delete(food.key);
//     food.delete();
//     loadFoodList();
//     notifyListeners();
//   }
// }
