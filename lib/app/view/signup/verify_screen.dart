import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fwheirs/app/view/dialog/verify_dialog.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:pinput/pinput.dart';

import '../../../base/color_data.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  void finishView() {
    Constant.backToPrev(context);
  }

  FocusNode myFocusNode = FocusNode();
  Color color = borderColor;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: FetchPixels.getPixelHeight(60),
      height: FetchPixels.getPixelHeight(60),
      margin: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(5)),
      textStyle: TextStyle(
        fontSize: FetchPixels.getPixelHeight(24),
        color: redColor,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: color, width: FetchPixels.getPixelHeight(1)),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
    );
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                      finishView();
                    },
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(46)),
                  getCustomFont("Verify", 24, Colors.black, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  getMultilineCustomFont(
                      "Enter code sent to your phone number!", 15, Colors.black,
                      fontWeight: FontWeight.w400,
                      txtHeight: FetchPixels.getPixelHeight(1.3),
                      textAlign: TextAlign.center),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        setState(() {
                          color = redColor;
                          myFocusNode.canRequestFocus = true;
                        });
                      } else {
                        setState(() {
                          color = borderColor;
                          myFocusNode.canRequestFocus = false;
                        });
                      }
                    },
                    child: Pinput(
                      defaultPinTheme: defaultPinTheme,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      focusNode: myFocusNode,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) {},
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getButton(context, redColor, "Verify", Colors.white, () {
                    showDialog(
                        barrierDismissible: false,
                        builder: (context) {
                          return const VerifyDialog();
                        },
                        context: context);
                  }, 16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                      buttonHeight: FetchPixels.getPixelHeight(60)),
                  getVerSpace(FetchPixels.getPixelHeight(420)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getCustomFont(
                          "Didn’t recieve code? ", 15, Colors.black, 1,
                          fontWeight: FontWeight.w400),
                      GestureDetector(
                        onTap: () {},
                        child: getCustomFont("Resend", 15, redColor, 1,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}
