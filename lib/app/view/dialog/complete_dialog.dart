import 'package:flutter/material.dart';
import 'package:fwheirs/app/view/home/home_screen.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';

class CompleteDialog extends StatefulWidget {
  const CompleteDialog({Key? key}) : super(key: key);

  @override
  State<CompleteDialog> createState() => _CompleteDialogState();
}

class _CompleteDialogState extends State<CompleteDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return ScaleTransition(
        scale: scaleAnimation,
        child: Dialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(16))),
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getVerSpace(FetchPixels.getPixelHeight(40)),
                getSvgImage("exchange_image.svg"),
                getVerSpace(FetchPixels.getPixelHeight(27)),
                getCustomFont("Exchange Completed", 22, Colors.black, 1,
                    fontWeight: FontWeight.w700),
                getVerSpace(FetchPixels.getPixelHeight(8)),
                getPaddingWidget(
                  EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelHeight(20)),
                  getMultilineCustomFont(
                      "Your exchange has been successfully completed!",
                      15,
                      Colors.black,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      txtHeight: FetchPixels.getPixelHeight(1.3)),
                ),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getPaddingWidget(
                  EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelHeight(30)),
                  getButton(context, redColor, "Go to home", Colors.white, () {
                    Constant.navigatePush(context, HomeScreen());
                  }, 16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                      buttonHeight: FetchPixels.getPixelHeight(60)),
                ),
                getVerSpace(FetchPixels.getPixelHeight(40)),
              ],
            )));
  }
}
