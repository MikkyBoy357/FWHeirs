import 'package:flutter/material.dart';
import 'package:fwheirs/app/view/login/change_password.dart';
import 'package:fwheirs/app/view_models/auth_providers/auth_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:fwheirs/widgets/email_text_field.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  void finish() {
    Constant.backToPrev(context);
  }

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
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
                  getCustomFont("Forgot Password", 24, Colors.black, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  getMultilineCustomFont(
                      "Please enter email for forgot your password.",
                      15,
                      Colors.black,
                      fontWeight: FontWeight.w400,
                      txtHeight: FetchPixels.getPixelHeight(1.3),
                      textAlign: TextAlign.center),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  EmailTextField(controller: TextEditingController()),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getButton(context, redColor, "Submit", Colors.white, () {
                    Constant.navigatePush(context, ChangePassword());
                  }, 16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                      buttonHeight: FetchPixels.getPixelHeight(60)),
                ],
              ),
            ),
          ),
        );
      },
    ), onWillPop: () async {
      finish();
      return false;
    });
  }
}
