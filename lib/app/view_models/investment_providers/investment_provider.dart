import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fwheirs/app/models/broker_model.dart';
import 'package:fwheirs/app/models/investment_model.dart';
import 'package:fwheirs/app/models/package_model.dart';

import '../../../base/constant.dart';
import '../../../dependency_injection/locator.dart';
import '../../../local_storage/local_db.dart';
import '../../../widgets/error_dialog.dart';
import '../../../widgets/loading_dialog.dart';

class InvestmentProvider extends ChangeNotifier {
  List<InvestmentModel> investments = [];
  List<BrokerModel> brokers = [];
  List<PackageModel> packages = [];

  // Create Investment Package
  GlobalKey<FormState> createPlanFormKey = GlobalKey<FormState>();

  TextEditingController brokerController = TextEditingController();
  TextEditingController packageController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Future<void> getInvestments(BuildContext context) async {
    try {
      print('Getting Investments...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var response = await dio.get(
        "${Constant.liveUrl}/invest",
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
          },
        ),
      );
      print("Investments Gotten Successfully");
      print("Investments Response => ${response.data}");
      List tempInvestments = response.data['data'];
      investments.clear();
      for (var invst in tempInvestments) {
        investments.add(InvestmentModel.fromJson(invst));
      }
      print("Investments List => $investments");
      notifyListeners();
      Navigator.of(context, rootNavigator: true).pop(context);
    } on DioError catch (e) {
      print("Error => $e");
      print(e.message);
      Navigator.of(context, rootNavigator: true).pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: 'error: ${e.message}',
          );
        },
      );
    }
  }

  Future<void> createInvestment(BuildContext context) async {
    if (!createPlanFormKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: 'Error: Invalid TextFields',
          );
        },
      );
      return;
    }
    try {
      print('Creating Investment...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var body = {
        "plan_id": int.parse(packageController.text),
        "broker_id": int.parse(brokerController.text),
        "duration": int.parse(durationController.text),
        "amount": int.parse(amountController.text)
      };
      dio.options.headers["Authorization"] =
          "Bearer ${locator<AppDataBaseService>().getTokenString()}";
      print(body);
      var response = await dio.post(
        "${Constant.liveUrl}/invest",
        data: body,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Allow-Methods": "GET, POST",
            "Access-Control-Allow-Credentials": "true",
          },
        ),
      );
      print("Investments Created Successfully");
      print("InvestmentCreation Response => ${response.data}");
      // investments = response.data['data'];
      notifyListeners();
      Navigator.of(context, rootNavigator: true).pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return SuccessDialog(
            text: "${response.data['message']}",
          );
        },
      );
    } on DioError catch (e) {
      print("Error => $e");
      print(e.message);
      Navigator.of(context, rootNavigator: true).pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: 'error: ${e.message}',
          );
        },
      );
    }
  }

  Future<void> getBrokers(BuildContext context) async {
    try {
      print('Getting Brokers...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      // var body = {
      //   "plan_id": 2,
      //   "broker_id": 2,
      //   "duration": 30,
      //   "amount": 5000000
      // };
      dio.options.headers["Authorization"] =
          "Bearer ${locator<AppDataBaseService>().getTokenString()}";
      var response = await dio.get(
        "${Constant.liveUrl}/brokers",
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Allow-Methods": "GET, POST",
            "Access-Control-Allow-Credentials": "true",
          },
        ),
      );
      print("Brokers Gotten Successfully");
      print("GetBrokers Response => ${response.data}");
      List tempBrokers = response.data['data'];
      brokers.clear();
      for (var broker in tempBrokers) {
        brokers.add(BrokerModel.fromJson(broker));
      }
      print("Brokers List => $brokers");
      notifyListeners();
      Navigator.of(context, rootNavigator: true).pop(context);
    } on DioError catch (e) {
      print("Error => $e");
      print(e.message);
      Navigator.of(context, rootNavigator: true).pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: 'error: ${e.message}',
          );
        },
      );
    }
  }

  Future<void> getPackages(BuildContext context) async {
    try {
      print('Getting Packages...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      // var body = {
      //   "plan_id": 2,
      //   "broker_id": 2,
      //   "duration": 30,
      //   "amount": 5000000
      // };
      dio.options.headers["Authorization"] =
          "Bearer ${locator<AppDataBaseService>().getTokenString()}";
      var response = await dio.get(
        "${Constant.liveUrl}/package",
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Allow-Methods": "GET, POST",
            "Access-Control-Allow-Credentials": "true",
          },
        ),
      );
      print("Packages Gotten Successfully");
      print("GetPackages Response => ${response.data}");
      List tempPackages = response.data['data'];
      brokers.clear();
      for (var package in tempPackages) {
        packages.add(PackageModel.fromJson(package));
      }
      print("Packages List => $brokers");
      notifyListeners();
      Navigator.of(context, rootNavigator: true).pop(context);
    } on DioError catch (e) {
      print("Error => $e");
      print(e.message);
      Navigator.of(context, rootNavigator: true).pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: 'error: ${e.message}',
          );
        },
      );
    }
  }
}
