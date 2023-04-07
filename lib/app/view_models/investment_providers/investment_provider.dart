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
  int totalWorth = 0;

  int minVest = 0;
  int maxVest = 0;

  List<InvestmentModel> investments = [];
  List<BrokerModel> brokers = [];
  BrokerModel selectedBroker = BrokerModel();
  List<String> brokersNames = [];
  PackageModel selectedPackage = PackageModel();
  List<String> packagesNames = [];
  List<PackageModel> packages = [];

  // Create Investment Package
  GlobalKey<FormState> createPlanFormKey = GlobalKey<FormState>();

  TextEditingController brokerController = TextEditingController();
  TextEditingController packageController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void setMinMaxVest() {
    minVest = int.parse(selectedPackage.minVest ?? "0");
    maxVest = int.parse(selectedPackage.maxVest ?? "0");
    print("MinVest => $minVest");
    print("MaxVest => $maxVest");
    notifyListeners();
  }

  void calculateTotalWorth() {
    int _total = 0;
    for (InvestmentModel investment in investments) {
      _total += int.parse(investment.vestedAmount ?? "0");
    }
    totalWorth = _total;
    notifyListeners();
  }

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
      calculateTotalWorth();
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

  Future<void> terminateInvestment(
    BuildContext context, {
    required String? investmentId,
  }) async {
    try {
      print('Terminating Investment...');
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
      var response = await dio.patch(
        "${Constant.liveUrl}/terminate/$investmentId",
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
      print("Investment Terminated Gotten Successfully");
      print("GetBrokers Response => ${response.data}");
      notifyListeners();
      Navigator.of(context, rootNavigator: true).pop(context);

      showDialog(
        context: context,
        builder: (context) {
          return SuccessDialog(
            text: "Investment plan terminated successfully",
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
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
      setMinMaxVest();
      print("Amount =>  ${amountController.text}");
      if (int.parse(amountController.text) < minVest ||
          int.parse(amountController.text) > maxVest) {
        return showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              text: "Error: Invalid Amount\n\n"
                  "Minimum: $minVest\n"
                  "Maximum: $maxVest",
            );
          },
        );
      } else {
        print("Investment Amount Validated");
      }
      print('Creating Investment...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var body = {
        "plan_id": int.parse(selectedPackage.id ?? "0"),
        "broker_id": int.parse(selectedBroker.id ?? "0"),
        "duration": int.parse(durationController.text),
        "amount": int.parse(amountController.text)
      };
      print(body);
      dio.options.headers["Authorization"] =
          "Bearer ${locator<AppDataBaseService>().getTokenString()}";
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
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop(context);
            },
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

  void setBrokersNames() {
    brokersNames.clear();
    for (BrokerModel broker in brokers) {
      brokersNames.add(broker.name.toString());
    }
    notifyListeners();
  }

  void setPackagesNames() {
    packagesNames.clear();
    for (PackageModel package in packages) {
      packagesNames.add(package.name.toString());
    }
    notifyListeners();
  }

  void setSelectedBroker(String newValue) {
    selectedBroker =
        brokers.where((BrokerModel element) => element.name == newValue).first;
    notifyListeners();
  }

  void setSelectedPackage(String newValue) {
    selectedPackage = packages
        .where((PackageModel element) => element.name == newValue)
        .first;
    setMinMaxVest();
    notifyListeners();
  }

  void initDropdowns() {
    selectedBroker = brokers[0];
    selectedPackage = packages[0];
    print("CREATE PLAN: Dropdowns Initialized");
    setMinMaxVest();
  }

  String? getBrokerLogo(String brokerName) {
    String? logo = "";
    BrokerModel currentBroker =
        brokers.where((BrokerModel broker) => broker.name == brokerName).first;
    logo = currentBroker.logo;
    return logo;
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
      packages.clear();
      for (var package in tempPackages) {
        packages.add(PackageModel.fromJson(package));
      }
      print("Packages List => $packages");
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
