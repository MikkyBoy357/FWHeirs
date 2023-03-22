import 'package:flutter/material.dart';
import 'package:fwheirs/app/routes/app_routes.dart';
import 'package:fwheirs/app/view_models/auth_providers/auth_provider.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/pref_data.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:fwheirs/widgets/custom_button.dart';
import 'package:fwheirs/widgets/email_text_field.dart';
import 'package:fwheirs/widgets/password_field.dart';
import 'package:fwheirs/widgets/phone_text_field.dart';
import 'package:provider/provider.dart';

import '../../../base/color_data.dart';
import '../../../widgets/error_dialog.dart';
import '../../../widgets/name_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void finishView() {
    Constant.backToPrev(context);
  }

  var ispass = false;
  bool agree = false;
  String? image;
  String? code;

  Future<void> doSomeAsyncStuff() async {
    image = await PrefData.getImage();

    code = await PrefData.getCode();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: authProvider.signUpFormKey,
                      child: Column(
                        children: [
                          getVerSpace(FetchPixels.getPixelHeight(50)),
                          getCustomFont("Sign Up", 24, Colors.black, 1,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.center),
                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          getMultilineCustomFont(
                              "Enter your detail for sign up!",
                              15,
                              Colors.black,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              txtHeight: FetchPixels.getPixelHeight(1.3)),
                          getVerSpace(FetchPixels.getPixelHeight(30)),
                          NameTextField(
                            controller: authProvider.firstNameController,
                            hintText: "First Name",
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          NameTextField(
                            controller: authProvider.lastNameController,
                            hintText: "Last Name",
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          EmailTextField(
                            controller: authProvider.emailController2,
                            hintText: "Email",
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          PhoneTextField(
                            controller: authProvider.phoneNumberController,
                            title: "Password",
                            hintText: "Phone Number",
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          PasswordField(
                            controller: authProvider.passwordController2,
                            title: "Password",
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    agree = !agree;
                                  });
                                },
                                child: Container(
                                  height: FetchPixels.getPixelHeight(24),
                                  width: FetchPixels.getPixelHeight(24),
                                  decoration: BoxDecoration(
                                      color: (agree) ? blueColor : Colors.white,
                                      border: (agree)
                                          ? null
                                          : Border.all(
                                              color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(
                                          FetchPixels.getPixelHeight(6))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: FetchPixels.getPixelHeight(6),
                                      horizontal: FetchPixels.getPixelWidth(4)),
                                  child:
                                      (agree) ? getSvgImage("done.svg") : null,
                                ),
                              ),
                              getHorSpace(FetchPixels.getPixelWidth(10)),
                              getCustomFont("I agree with Terms & Privacy", 16,
                                  Colors.black, 1,
                                  fontWeight: FontWeight.w400)
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(30)),
                          CustomButton(
                            text: "Sign Up",
                            onTap: () async {
                              if (authProvider.signUpFormKey.currentState!
                                      .validate() &&
                                  agree) {
                                await authProvider.signUp(context);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ErrorDialog(
                                      text: 'Invalid Fields',
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(50)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              getCustomFont("Already have an account? ", 15,
                                  Colors.black, 1,
                                  fontWeight: FontWeight.w400),
                              GestureDetector(
                                onTap: () {
                                  Constant.sendToNext(
                                      context, Routes.loginRoute);
                                },
                                child: getCustomFont("Login", 15, blueColor, 1,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
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
