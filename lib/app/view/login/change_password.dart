import 'package:flutter/material.dart';
import 'package:fwheirs/app/view_models/auth_providers/auth_provider.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:fwheirs/widgets/custom_button.dart';
import 'package:fwheirs/widgets/name_text_field.dart';
import 'package:fwheirs/widgets/password_field.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  final String resetToken;

  const ChangePassword({
    Key? key,
    required this.resetToken,
  }) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> changeFormKey = GlobalKey<FormState>();

  void finish() {
    Constant.backToPrev(context);
  }

  var isnewpass = false;
  var isconfirmpass = false;

  @override
  void dispose() {
    super.dispose();
    changeFormKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.white,
          body: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return SafeArea(
                child: getPaddingWidget(
                  EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelHeight(20)),
                  Column(
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(26)),
                      gettoolbarMenu(
                        context,
                        "back.svg",
                        () {
                          finish();
                        },
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(46)),
                      getMediumCustomFont(context, "Change Password",
                          fontSize: 24, fontWeight: FontWeight.w700),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      getMediumCustomFont(context,
                          "Please enter the OTP that was sent to your email and new password for change your password.",
                          fontSize: 15, fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      Column(
                        children: [
                          NumberTextField(
                            hintText: "OTP",
                            controller: authProvider.changeOTPController,
                            onChanged: (val) {
                              authProvider.changeNotifiers();
                            },
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(30)),
                          PasswordField(
                            hintText: "New Password",
                            controller: authProvider.changePasswordController,
                            onChanged: (val) {
                              authProvider.changeNotifiers();
                            },
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          PasswordField(
                            hintText: "Confirm Password",
                            controller:
                                authProvider.changeConfirmPasswordController,
                            onChanged: (val) {
                              authProvider.changeNotifiers();
                            },
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(30)),
                        ],
                      ),
                      CustomButton(
                        isActive:
                            (authProvider.changeOTPController.text.isNotEmpty &&
                                (authProvider
                                        .changePasswordController.text.length >=
                                    6) &&
                                (authProvider.changePasswordController.text ==
                                    authProvider
                                        .changeConfirmPasswordController.text)),
                        text: "Submit",
                        onTap: () {
                          if (authProvider
                              .changeOTPController.text.isNotEmpty) {
                            if (authProvider
                                    .changePasswordController.text.length >=
                                6) {
                              if (authProvider.changePasswordController.text ==
                                  authProvider
                                      .changeConfirmPasswordController.text) {
                                authProvider.changePassword(context,
                                    resetToken: widget.resetToken);
                              }
                            }
                          }
                          // print("Hello");
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }
}
