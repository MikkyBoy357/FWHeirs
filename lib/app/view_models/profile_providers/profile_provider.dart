import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fwheirs/app/models/banner_model.dart';
import 'package:fwheirs/app/models/my_profile_model.dart';
import 'package:fwheirs/app/models/wallet_model.dart';

import '../../../base/constant.dart';
import '../../../dependency_injection/locator.dart';
import '../../../local_storage/local_db.dart';
import '../../../widgets/error_dialog.dart';
import '../../../widgets/loading_dialog.dart';

class ProfileProvider extends ChangeNotifier {
  MyProfileModel myProfileInfo = MyProfileModel();
  WalletModel myWallet = WalletModel();

  int selectedBanner = 0;

  List<BannerModel> banners = [];

  // Edit Profile Info
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  void changeNotifiers() {
    notifyListeners();
  }

  Future<void> getProfileInfo(BuildContext context) async {
    try {
      print('Getting Profile...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var response = await dio.get(
        "${Constant.liveUrl}/profile",
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
          },
        ),
      );
      print("Profile Gotten Successfully");
      print("Profile Response => ${response.data}");
      var profile = response.data['data']["profile"];
      var wallet = response.data['data']["wallet"];
      myProfileInfo = MyProfileModel.fromJson(profile);
      myWallet = WalletModel.fromJson(wallet);
      print("myProfileInfo => $myProfileInfo");
      // investments = response.data['data'];
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

  Future<void> editProfileInfo(BuildContext context) async {
    try {
      print('Edit Profile...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      var response = await dio.post(
        "${Constant.liveUrl}/profile",
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${locator<AppDataBaseService>().getTokenString()}',
          },
        ),
      );
      print("Profile Gotten Successfully");
      print("Profile Response => ${response.data}");
      var profile = response.data['data']["profile"];
      myProfileInfo = MyProfileModel.fromJson(profile);
      print("myProfileInfo => $myProfileInfo");
      // investments = response.data['data'];
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

  Future<void> getBanners(BuildContext context) async {
    try {
      print('Getting Banners...');
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          "Bearer ${locator<AppDataBaseService>().getTokenString()}";
      var response = await dio.get(
        "${Constant.liveUrl}/banner",
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
      print("Banners Gotten Successfully");
      print("GetBanners Response => ${response.data}");
      List tempBanners = response.data['data'];
      banners.clear();
      for (var banner in tempBanners) {
        banners.add(BannerModel.fromJson(banner));
      }
      print("Banners List => $banners");
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
