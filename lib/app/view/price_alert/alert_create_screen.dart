import 'package:flutter/material.dart';
import 'package:fwheirs/app/view/price_alert/price_alert_screen.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';

class AlertCreateScreen extends StatefulWidget {
  const AlertCreateScreen({Key? key}) : super(key: key);

  @override
  State<AlertCreateScreen> createState() => _AlertCreateScreenState();
}

class _AlertCreateScreenState extends State<AlertCreateScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backToPrev();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            padding:
                EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(18)),
            child: GestureDetector(
              onTap: () {
                backToPrev();
              },
              child: getSvgImage("close.svg"),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getSvgImage("price_check.svg"),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getCustomFont("Price Alert Created!", 22, Colors.black, 1,
                  fontWeight: FontWeight.w700, textAlign: TextAlign.center),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(40)),
                getMultilineCustomFont(
                    "You will receive a notification as soon as the coin reaches the price set by you.",
                    15,
                    Colors.black,
                    fontWeight: FontWeight.w400,
                    txtHeight: FetchPixels.getPixelHeight(1.5),
                    textAlign: TextAlign.center),
              ),
              getVerSpace(FetchPixels.getPixelHeight(40)),
              getPaddingWidget(
                EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(50)),
                getButton(context, redColor, "Ok", Colors.white, () {
                  Constant.navigatePush(context, PriceAlertScreen());
                }, 16,
                    weight: FontWeight.w600,
                    buttonHeight: FetchPixels.getPixelHeight(60),
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(15))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
