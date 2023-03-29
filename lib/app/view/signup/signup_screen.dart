import 'package:flutter/material.dart';
import 'package:fwheirs/app/view/login/login_screen.dart';
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
import '../../../widgets/name_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

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
          resizeToAvoidBottomInset: true,
          // backgroundColor: Colors.white,
          body: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: signUpFormKey,
                    child: Column(
                      children: [
                        getVerSpace(FetchPixels.getPixelHeight(80)),
                        getCustomFont("Sign Up", 24,
                            Theme.of(context).textTheme.bodyLarge!.color!, 1,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center),
                        getVerSpace(FetchPixels.getPixelHeight(10)),
                        getMediumCustomFont(
                          context,
                          "Enter your detail for sign up!",
                          fontWeight: FontWeight.w400,
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(30)),
                        NameTextField(
                          controller: authProvider.firstNameController,
                          hintText: "First Name",
                          onChanged: (String newVal) {
                            authProvider.changeNotifiers();
                          },
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        NameTextField(
                          controller: authProvider.lastNameController,
                          hintText: "Last Name",
                          onChanged: (String newVal) {
                            authProvider.changeNotifiers();
                          },
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        EmailTextField(
                          controller: authProvider.emailController2,
                          hintText: "Email",
                          onChanged: (String newVal) {
                            authProvider.changeNotifiers();
                          },
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        PhoneTextField(
                          controller: authProvider.phoneNumberController,
                          title: "Phone",
                          hintText: "Phone Number",
                          onChanged: (String newVal) {
                            authProvider.changeNotifiers();
                          },
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        NameTextField(
                          controller: authProvider.refCodeController,
                          hintText: "Referral Code",
                          title: "Referral Code",
                          onChanged: (String newVal) {
                            authProvider.changeNotifiers();
                          },
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        PasswordField(
                          controller: authProvider.passwordController2,
                          title: "Password",
                          onChanged: (String newVal) {
                            authProvider.changeNotifiers();
                          },
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
                                child: (agree) ? getSvgImage("done.svg") : null,
                              ),
                            ),
                            getHorSpace(FetchPixels.getPixelWidth(10)),
                            getMediumCustomFont(
                              context,
                              "I agree with Terms & Privacy",
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(30)),
                        CustomButton(
                          text: "Sign Up",
                          isActive: (signUpFormKey.currentState != null &&
                              signUpFormKey.currentState!.validate() &&
                              agree),
                          onTap: () async {
                            if (signUpFormKey.currentState!.validate() &&
                                agree) {
                              await authProvider.signUp(context);
                            } else {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return ErrorDialog(
                              //       text: 'Invalid Fields',
                              //     );
                              //   },
                              // );
                            }
                          },
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(50)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getMediumCustomFont(
                              context,
                              "Already have an account? ",
                              fontWeight: FontWeight.w400,
                            ),
                            GestureDetector(
                              onTap: () {
                                Constant.navigatePush(context, LoginScreen());
                              },
                              child: getCustomFont("Login", 16, blueColor, 1,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
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
