import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  gettoolbarMenu(
                    context,
                    "back.svg",
                    () {
                      backToPrev();
                    },
                    istext: true,
                    title: "Help & Support",
                    fontsize: 24,
                    weight: FontWeight.w700,
                    textColor: Colors.black,
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(39)),
                  Expanded(
                      flex: 1,
                      child: ListView(
                        primary: true,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          getMultilineCustomFont(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vitae metus posuere mauris luctus maximus. Curabitur at enim turpis. Nulla quis posuere lacus, eget euismod orci. Nulla facilisi. Integer cursus, eros eu dictum vestibulum, dolor diam sodales ex, rhoncus laoreet elit sem at risus. Nunc tincidunt quam in feugiat faucibus. Ut rhoncus efficitur elit.Nam ut ultrices massa. Vestibulum at semper ante. Ut lorem felis, fermentum nec nunc ac, tempor aliquam elit. Etiam eu interdum eros. Nulla fringilla tellus eget magna suscipit, a congue libero dignissim. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse condimentum faucibus nisl fermentum bibendum. Quisque bibendum felis tortor, sit amet eleifend dolor maximus at.",
                              15,
                              textColor,
                              fontWeight: FontWeight.w400,
                              txtHeight: FetchPixels.getPixelHeight(1.3),
                              textAlign: TextAlign.start)
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          backToPrev();
          return false;
        });
  }
}
