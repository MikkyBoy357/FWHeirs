import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fwheirs/app/models/broker_model.dart';
import 'package:fwheirs/app/models/due_revenue_model.dart';
import 'package:fwheirs/app/models/investment_model.dart';
import 'package:fwheirs/app/models/package_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';

import '../../../base/constant.dart';
import '../../../dependency_injection/locator.dart';
import '../../../local_storage/local_db.dart';
import '../../../widgets/error_dialog.dart';
import '../../../widgets/loading_dialog.dart';
import '../../models/revenue_transaction_model.dart';

class InvestmentProvider extends ChangeNotifier {
  int totalWorth = 0;

  int minVest = 0;
  int maxVest = 0;

  // File? proofImageFile;
  // Pick Image
  bool? loading;

  // File mediaUrl;
  File? croppedImage;
  File? imageFile;
  File? sampleImage;
  String? imageName;
  String? imageUrl;
  final picker = ImagePicker();

  List<InvestmentModel> investments = [];
  List<BrokerModel> brokers = [];
  BrokerModel selectedBroker = BrokerModel();
  List<String> brokersNames = [];
  PackageModel selectedPackage = PackageModel();
  List<String> packagesNames = [];
  List<PackageModel> packages = [];
  List<DueRevenueModel> dueRevenues = [];
  List<RevenueTransactionModel> revenueTransactions = [];

  // Upscale Investment
  GlobalKey<FormState> upscaleFormKey = GlobalKey<FormState>();
  TextEditingController upscaleAmountController = TextEditingController();

  TextEditingController paidAmountController = TextEditingController();

  // Create Investment Package
  GlobalKey<FormState> createPlanFormKey = GlobalKey<FormState>();

  TextEditingController brokerController = TextEditingController();
  TextEditingController packageController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void changeNotifiers() {
    notifyListeners();
  }

  void initPaidAmount() {
    paidAmountController.setText(dueRevenues[0].dueRevenue ?? "0");
    notifyListeners();
  }

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

  // Future<void> cropImage(PickedFile? image) async {
  //   try {
  //     croppedImage = (await ImageCropper().cropImage(
  //       sourcePath: image!.path,
  //       maxHeight: 120,
  //       maxWidth: 120,
  //     )) as File?;
  //     imageFile = croppedImage;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  pickImage({bool camera = false, BuildContext? context}) async {
    loading = true;
    ImageSource imageSource;
    if (camera) {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }
    notifyListeners();
    try {
      print('Picking Image');
      XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
      imageFile = File(pickedFile?.path ?? "");
      print(pickedFile?.path);
      // print('Cropping Image...');
      // await cropImage(pickedFile);
      // print('Image Cropping Done!!');
      // pickedFile = null;
      // print('=====> ${imageFile!.path}');
      // print('Uploading Image... Please Wait...');
      // imageName = basename(imageFile!.path);
      // await storage.ref().child('profilePic/$imageName').putFile(imageFile!);
      // print('Image Upload Done!');
      // imageUrl =
      //     await storage.ref().child('profilePic/$imageName').getDownloadURL();
      // print('IMAGE URL: $imageUrl');
      // usersRef.doc(Constants.uid).update(
      //   {"photoUrl": imageUrl ?? ""},
      // );
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      // showInSnackBar('Cancelled', context);
      print(e);
      print('Cancelled');
    }
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
                      "Maximum: $maxVest"
                  .valueWithComma,
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
              Constant.backToPrev(context);
              getInvestments(context);
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
            text: 'error: ${e.response?.data['message']}',
          );
        },
      );
    }
  }

  Future<void> upscaleInvestment(
    BuildContext context, {
    required InvestmentModel investment,
  }) async {
    if (upscaleAmountController.text.isEmpty) {
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
      setSelectedPackage(investment.package.toString());
      setMinMaxVest();
      String upscaleString = upscaleAmountController.text.replaceAll(",", "");
      int upscaleInt = int.parse(upscaleString);
      print("Amount =>  $upscaleString");
      // if (upscaleInt < (int.parse(investment.vestedAmount ?? "0") + 1) ||
      //     upscaleInt > maxVest) {
      if (upscaleInt <= 0) {
        return showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              // text: "Error: Invalid Amount\n\n"
              //         "Minimum: ${int.parse(investment.vestedAmount ?? "0") + 1}\n"
              //         "Maximum: $maxVest"
              //     .valueWithComma,
              text: "Amount should be greater than 0",
            );
          },
        );
      } else {
        print("Investment Amount Validated");
      }
      print('Upscaling Investment...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var body = {
        "invest_id": investment.id.toString(),
        "amount": int.parse(upscaleAmountController.text)
      };
      print(body);
      dio.options.headers["Authorization"] =
          "Bearer ${locator<AppDataBaseService>().getTokenString()}";
      var response = await dio.post(
        "${Constant.liveUrl}/topup",
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
              Constant.backToPrev(context);
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

  Future<void> submitRevenue(
    BuildContext context, {
    required InvestmentModel investment,
  }) async {
    try {
      print('Submit Revenue...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var formData = FormData.fromMap({
        'proof': await MultipartFile.fromFile(
          imageFile?.path ?? "",
          filename: "${imageFile?.path.split(Platform.pathSeparator).last}",
        ),
        'mintid': "${investment.id}",
        'amount': '${paidAmountController.text}',
      });
      print(
          "FileName => ${imageFile?.path.split(Platform.pathSeparator).last}");
      print({
        'proof': await MultipartFile.fromFile(
          imageFile?.path ?? "",
          filename: "${imageFile?.path.split(Platform.pathSeparator).last}",
        ),
        'mintid': "${investment.id}",
        'amount': '${paidAmountController.text}',
      });
      dio.options.headers["Authorization"] =
          "Bearer ${locator<AppDataBaseService>().getTokenString()}";
      var response = await dio.post(
        "${Constant.liveUrl}/revenue",
        data: formData,
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
      print("Revenue Submitted Successfully");
      print("Revenue Submission Response => ${response.data}");
      imageFile = null;
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
              Constant.backToPrev(context);
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
            text: 'error: ${e.response?.data['message']}',
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

  Future<void> getDueRevenue(BuildContext context, {required String id}) async {
    try {
      print('Getting Due Revenue...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          "Bearer ${locator<AppDataBaseService>().getTokenString()}";
      print("${Constant.liveUrl}/due-revenue/$id");
      var response = await dio.get(
        "${Constant.liveUrl}/due-revenue/$id",
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
      print("DueRevenue Gotten Successfully");
      print("GetDueRevenue Response => ${response.data}");
      List tempRevenues = response.data['data'];
      dueRevenues.clear();
      for (var rev in tempRevenues) {
        dueRevenues.add(DueRevenueModel.fromJson(rev));
      }
      print("DueRevenues List => $dueRevenues");
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

  Future<void> getRevenueTransactions(BuildContext context) async {
    try {
      print('Getting RevenueTransactions...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          "Bearer ${locator<AppDataBaseService>().getTokenString()}";
      print("${Constant.liveUrl}/revenue");
      var response = await dio.get(
        "${Constant.liveUrl}/revenue",
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
      print("RevenueTransactions Gotten Successfully");
      print("GetRevenueTransactions Response => ${response.data}");
      List tempRevenues = response.data['data'];
      revenueTransactions.clear();
      for (var rev in tempRevenues) {
        revenueTransactions.add(RevenueTransactionModel.fromJson(rev));
      }
      print("RevenueTransactions List => $revenueTransactions");
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
            text: 'error: ${e.response?.data['message']}',
          );
        },
      );
    }
  }
}
