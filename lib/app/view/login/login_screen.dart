import 'package:flutter/material.dart';
import 'package:fwheirs/app/view/signup/signup_screen.dart';
import 'package:fwheirs/app/view_models/auth_providers/auth_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:fwheirs/widgets/custom_button.dart';
import 'package:fwheirs/widgets/email_text_field.dart';
import 'package:provider/provider.dart';

import '../../../widgets/error_dialog.dart';
import '../../../widgets/password_field.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void finishView() {
    Constant.closeApp();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var ispass = false;

  @override
  Widget build(BuildContext context) {
    // FetchPixels(context);
    // locator<AppDataBaseService>().saveToken("hello");
    // print(locator<AppDataBaseService>().getTokenString());
    // print(locator<AppDataBaseService>().getMikeList());
    // locator<AppDataBaseService>().clearDB();
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.white,
          body: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(98)),
                      getCustomFont("Login", 24,
                          Theme.of(context).textTheme.bodyLarge!.color!, 1,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      getMediumCustomFont(
                        context,
                        "Hello, welcome back to FWHeirs.",
                        fontWeight: FontWeight.w400,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      Form(
                        key: loginFormKey,
                        child: Column(
                          children: [
                            EmailTextField(
                              controller: authProvider.emailController,
                              onChanged: (String? newVal) {
                                authProvider.changeNotifiers();
                              },
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(20)),
                            PasswordField(
                              controller: authProvider.passwordController,
                              onChanged: (String? newVal) {
                                authProvider.changeNotifiers();
                              },
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(19)),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Constant.navigatePush(context, ForgotPassword());
                        },
                        child: getCustomFont(
                            "Forgot Password?", 15, redColor, 1,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.end),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      CustomButton(
                        text: 'Login',
                        // onTap: () {},
                        isActive: loginFormKey.currentState != null &&
                            loginFormKey.currentState!.validate(),
                        onTap: () async {
                          if (loginFormKey.currentState!.validate()) {
                            await authProvider.login(context);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ErrorDialog(
                                  text: 'Please enter a valid password',
                                );
                              },
                            );
                          }
                        },
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(50)),
                      // getCustomFont("Or sign in with", 15, Colors.black, 1,
                      //     fontWeight: FontWeight.w400, textAlign: TextAlign.center),
                      // getVerSpace(FetchPixels.getPixelHeight(20)),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: getButton(context, Colors.white, "Google",
                      //           Colors.black, () {}, 14,
                      //           weight: FontWeight.w600,
                      //           isIcon: true,
                      //           image: "google.svg",
                      //           borderRadius: BorderRadius.circular(
                      //               FetchPixels.getPixelHeight(12)),
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 color: containerShadow,
                      //                 blurRadius: 18,
                      //                 offset: const Offset(0, 4))
                      //           ],
                      //           buttonHeight: FetchPixels.getPixelHeight(60)),
                      //     ),
                      //     getHorSpace(FetchPixels.getPixelHeight(20)),
                      //     Expanded(
                      //       child: getButton(context, Colors.white, "Facebook",
                      //           Colors.black, () {}, 14,
                      //           weight: FontWeight.w600,
                      //           isIcon: true,
                      //           image: "facebook.svg",
                      //           borderRadius: BorderRadius.circular(
                      //               FetchPixels.getPixelHeight(12)),
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 color: containerShadow,
                      //                 blurRadius: 18,
                      //                 offset: const Offset(0, 4))
                      //           ],
                      //           buttonHeight: FetchPixels.getPixelHeight(60)),
                      //     ),
                      //   ],
                      // ),
                      // getVerSpace(FetchPixels.getPixelHeight(147)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getMediumCustomFont(
                            context,
                            "Don’t have an account? ",
                          ),
                          GestureDetector(
                            onTap: () {
                              Constant.navigatePush(context, SignUpScreen());
                            },
                            child: getCustomFont("Sign Up", 15, redColor, 1,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}
