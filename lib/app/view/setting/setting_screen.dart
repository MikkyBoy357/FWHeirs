import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fwheirs/app/view/home/home_screen.dart';
import 'package:fwheirs/app/view/setting/help_screen.dart';
import 'package:fwheirs/app/view/setting/privacy_screen.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/theme/theme_manager.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:provider/provider.dart';

import '../../../base/color_data.dart';
import '../price_alert/price_alert_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void backToPrev() {
    // Constant.backToPrev(context);
    Constant.navigatePush(context, HomeScreen());
  }

  var horSpace = FetchPixels.getPixelHeight(20);
  bool isSwitch = true;
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
      child: Consumer<ThemeManager>(
        builder: (context, themeProvider, _) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            // backgroundColor: ,
            // backgroundColor: Colors.white,
            body: SafeArea(
              bottom: false,
              child: getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horSpace),
                Column(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(14)),
                    appBar(context),
                    getVerSpace(FetchPixels.getPixelHeight(39)),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: AnimationLimiter(
                          child: Column(
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 200),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                horizontalOffset: 44.0,
                                child: FadeInAnimation(child: widget),
                              ),
                              children: [
                                priceAlertButton(context),
                                getVerSpace(horSpace),
                                portfolioPriceAlertButton(),
                                getVerSpace(horSpace),
                                referAndEarnButton(),
                                getVerSpace(horSpace),
                                notificationButton(),
                                getVerSpace(horSpace),
                                themeButton(
                                  switchWidget: CupertinoSwitch(
                                    value: themeProvider.themeMode ==
                                        ThemeMode.dark,
                                    onChanged: (value) {
                                      setState(() {
                                        isDark = value;
                                        themeProvider.toggleTheme(isDark);
                                      });
                                    },
                                    activeColor: blueColor,
                                  ),
                                ),
                                getVerSpace(horSpace),
                                helpButton(context),
                                getVerSpace(horSpace),
                                privacyButton(context),
                                getVerSpace(horSpace),
                                rateUsButton()
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      onWillPop: () async {
        backToPrev();
        return false;
      },
    );
  }

  GestureDetector rateUsButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelHeight(16),
            vertical: FetchPixels.getPixelHeight(16)),
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 23,
                  offset: const Offset(0, 7))
            ],
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getSvgImage("shield_check.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                getMediumCustomFont(context, "Rate us")
              ],
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

  GestureDetector privacyButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constant.navigatePush(context, PrivacyScreen());
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelHeight(16),
            vertical: FetchPixels.getPixelHeight(16)),
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 23,
                  offset: const Offset(0, 7))
            ],
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getSvgImage("shield_check.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                getMediumCustomFont(context, "Terms & Privacy")
              ],
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

  GestureDetector helpButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constant.navigatePush(context, HelpScreen());
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelHeight(16),
            vertical: FetchPixels.getPixelHeight(16)),
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 23,
                  offset: const Offset(0, 7))
            ],
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getSvgImage("info.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                getMediumCustomFont(context, "Help & Support")
              ],
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

  Container notificationButton() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getPixelHeight(16),
          vertical: FetchPixels.getPixelHeight(16)),
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              getSvgImage("notification.svg"),
              getHorSpace(FetchPixels.getPixelHeight(16)),
              getMediumCustomFont(context, "Notifications")
            ],
          ),
          getSvgImage("arrow_right.svg")
        ],
      ),
    );
  }

  Container referAndEarnButton() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
      padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getPixelHeight(16),
          vertical: FetchPixels.getPixelHeight(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSvgImage("refer_earn.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getMediumCustomFont(context, "Refer & Earn"),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getMultilineCustomFont(
                          "Get up to \$162 per referral", 15, textColor,
                          fontWeight: FontWeight.w400,
                          txtHeight: FetchPixels.getPixelHeight(1.3))
                    ],
                  ),
                )
              ],
            ),
          ),
          getSvgImage("arrow_right.svg")
        ],
      ),
    );
  }

  Container portfolioPriceAlertButton() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
      padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getPixelHeight(16),
          vertical: FetchPixels.getPixelHeight(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSvgImage("price_alert.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getMediumCustomFont(context, "Portfolio price alert"),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getMultilineCustomFont(
                          "Get price alerts for all coins on your portfolio",
                          15,
                          textColor,
                          fontWeight: FontWeight.w400,
                          txtHeight: FetchPixels.getPixelHeight(1.3))
                    ],
                  ),
                )
              ],
            ),
          ),
          CupertinoSwitch(
            value: isSwitch,
            onChanged: (value) {
              setState(() {
                isSwitch = value;
              });
            },
            activeColor: blueColor,
          )
        ],
      ),
    );
  }

  Container themeButton({required Widget switchWidget}) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
      padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getPixelHeight(16),
          vertical: FetchPixels.getPixelHeight(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSvgImage("price_alert.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getMediumCustomFont(context, "Dark Theme"),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getMultilineCustomFont(
                          "Use app in Dark mode", 15, textColor,
                          fontWeight: FontWeight.w400,
                          txtHeight: FetchPixels.getPixelHeight(1.3))
                    ],
                  ),
                )
              ],
            ),
          ),
          switchWidget,
        ],
      ),
    );
  }

  GestureDetector priceAlertButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constant.navigatePush(context, PriceAlertScreen());
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 23,
                  offset: const Offset(0, 7))
            ],
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelHeight(16),
            vertical: FetchPixels.getPixelHeight(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSvgImage("price_alert.svg"),
                  getHorSpace(FetchPixels.getPixelHeight(16)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getMediumCustomFont(context, "Price Alerts"),
                        getVerSpace(FetchPixels.getPixelHeight(5)),
                        getMultilineCustomFont(
                            "Create customised price alerts", 15, textColor,
                            fontWeight: FontWeight.w400,
                            txtHeight: FetchPixels.getPixelHeight(1.3))
                      ],
                    ),
                  )
                ],
              ),
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return gettoolbarMenu(
      context,
      "back.svg",
      () {
        backToPrev();
      },
      istext: true,
      title: "Settings",
      fontsize: 24,
      weight: FontWeight.w700,
      textColor: Colors.black,
    );
  }
}
