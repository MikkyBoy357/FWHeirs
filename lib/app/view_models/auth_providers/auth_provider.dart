import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fwheirs/app/view/home/home_screen.dart';
import 'package:fwheirs/app/view/splash_screen.dart';

import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../dependency_injection/locator.dart';
import '../../../local_storage/local_db.dart';
import '../../../widgets/error_dialog.dart';
import '../../../widgets/loading_dialog.dart';
import '../../view/login/change_password.dart';

class AuthProvider extends ChangeNotifier {
  // GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Forgot Password
  TextEditingController changeOTPController = TextEditingController();
  TextEditingController changePasswordController = TextEditingController();
  TextEditingController changeConfirmPasswordController =
      TextEditingController();

  // Forgot Password
  TextEditingController forgotEmailController = TextEditingController();

  // Login
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // SignUp
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController2 = TextEditingController();
  TextEditingController refCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  void changeNotifiers() async {
    notifyListeners();
  }

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
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      print("Response");
      print("Response => $response");
      print(response.data['data']);
      final String accessToken = response.data['access_token'];
      locator<AppDataBaseService>().saveToken(accessToken);
      print("Token => ${locator<AppDataBaseService>().getTokenString()}");

      Navigator.of(context, rootNavigator: true).pop(context);

      PrefData.setLogIn(true);
      Constant.navigatePush(context, HomeScreen());

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
        "referral": refCodeController.text,
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
      Navigator.of(context, rootNavigator: true).pop(context);
      if (status == false) {
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              text: message.toString(),
            );
          },
        );
        return;
      } else if (status == true) {
        print("User Created Successful!\n");
        showDialog(
          context: context,
          builder: (context) {
            return SuccessDialog(
              text: "${response.data["message"]}",
              buttonLabel: "LOGIN",
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop(context);
                Constant.backToPrev(context);
              },
            );
          },
        );
      }
      // final String accessToken = response.data['access_token'];
      // locator<AppDataBaseService>().saveToken(accessToken);
      // print("Token => ${locator<AppDataBaseService>().getTokenString()}");

      // PrefData.setLogIn(true);
      // Constant.navigatePush(context, HomeScreen());
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
        print(e);
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

  Future<void> forgotPassword(BuildContext context) async {
    try {
      print('Forgot Password...');
      print(forgotEmailController.text);
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      var body = {"email": forgotEmailController.text};
      print(body);

      Dio dio = Dio();
      var response = await dio.post(
        "${Constant.liveUrl}/forgotpassword",
        data: body,
      );
      Navigator.of(context).pop(context);
      print("Response => $response");
      String resetToken = "${response.data['reset_token']}";
      Constant.navigatePush(
        context,
        ChangePassword(
          resetToken: resetToken,
        ),
      );
      showDialog(
        context: context,
        builder: (context) {
          return SuccessDialog(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            text: "${response.data['message']}",
          );
        },
      );
    } on DioError catch (e) {
      Navigator.of(context).pop(context);
      print("Error => $e");
      print(e.message);
      print(e.response?.data);
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: "Error: ${e.response?.data['message']}",
          );
        },
      );
    }
  }

  Future<void> changePassword(BuildContext context,
      {required String resetToken}) async {
    try {
      print('Forgot Password...');
      print(forgotEmailController.text);
      showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );
      var body = {
        "otp": "759863",
        "password": "123457",
        "token": resetToken,
      };
      print(body);

      Dio dio = Dio();
      var response = await dio.post(
        "${Constant.liveUrl}/resetpassword",
        data: body,
      );
      Navigator.of(context).pop(context);
      print("Response => $response");
      showDialog(
        context: context,
        builder: (context) {
          return SuccessDialog(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            text: "${response.data['message']}",
          );
        },
      );
    } on DioError catch (e) {
      Navigator.of(context).pop(context);
      print("Error => $e");
      print(e.message);
      print(e.response?.data);
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text: "Error: ${e.response?.data['message']}",
          );
        },
      );
    }
  }

  void logout(BuildContext context) {
    print("Logging Out...");
    showDialog(
      context: context,
      builder: (context) {
        return LoadingDialog();
      },
    );
    // locator<AppDataBaseService>().deleteToken();
    print("Token => ${locator<AppDataBaseService>().getTokenString()}");
    PrefData.setLogIn(false);
    Navigator.of(context, rootNavigator: true).pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SplashScreen();
        },
      ),
    );
  }
}
