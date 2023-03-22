import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../dependency_injection/locator.dart';
import '../../../local_storage/local_db.dart';
import '../../../widgets/error_dialog.dart';
import '../../../widgets/loading_dialog.dart';
import '../../routes/app_routes.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Login
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // SignUp
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController2 = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      print('Login...');
      print(passwordController.text);
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      var body = {
        'email': emailController.text,
        "password": passwordController.text,
      };
      print(body);

      Dio dio = Dio();
      var response = await dio.post(
        "${Constant.liveUrl}/login",
        data: body,
      );
      print("Response");
      print("Response => $response");
      print(response.data['data']);
      final String accessToken = response.data['access_token'];
      locator<AppDataBaseService>().saveToken(accessToken);
      print("Token => ${locator<AppDataBaseService>().getTokenString()}");

      Navigator.of(context, rootNavigator: true).pop(context);

      PrefData.setLogIn(true);
      Constant.sendToNext(context, Routes.homeScreenRoute);

      print("Login Successful!\n");
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Error => $e");
        print(e.message);
        Navigator.of(context, rootNavigator: true).pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              text: 'Incorrect password',
            );
          },
        );
      } else {
        print(e.response?.statusCode);
      }
    }
  }

  Future<void> signUp(BuildContext context) async {
    try {
      print('SignUp...');
      print(passwordController.text);
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      var body = {
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
        "phone": phoneNumberController.text,
        "email": emailController2.text,
        "password": passwordController2.text
      };
      print(body);

      Dio dio = Dio();
      var response = await dio.post(
        "${Constant.liveUrl}/register",
        data: body,
      );
      print("Response");
      print("Response => $response");
      print(response.data['data']);
      final bool status = response.data['status'];
      final String message = response.data['message'];
      if (status == false) {
        Navigator.of(context, rootNavigator: true).pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              text: message.toString(),
            );
          },
        );
        return;
      }
      final String accessToken = response.data['access_token'];
      locator<AppDataBaseService>().saveToken(accessToken);
      print("Token => ${locator<AppDataBaseService>().getTokenString()}");

      Navigator.of(context, rootNavigator: true).pop(context);

      PrefData.setLogIn(true);
      Constant.sendToNext(context, Routes.homeScreenRoute);

      print("Login Successful!\n");
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        print("Error => $e");
        print(e.message);
        Navigator.of(context, rootNavigator: true).pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              text: 'Incorrect password',
            );
          },
        );
      } else {
        print(e.response?.statusCode);
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              text: 'Error Code: ${e.response?.statusCode.toString()}',
            );
          },
        );
      }
    }
  }
}
