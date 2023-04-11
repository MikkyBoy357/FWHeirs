import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fwheirs/app/view/bankDetail/bank_detail.dart';
import 'package:fwheirs/app/view/history/history_screen.dart';
import 'package:fwheirs/app/view/profile/my_profile.dart';
import 'package:fwheirs/app/view_models/profile_providers/profile_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:provider/provider.dart';

import '../../../view_models/auth_providers/auth_provider.dart';
import '../../setting/setting_screen.dart';

class TabProfile extends StatefulWidget {
  const TabProfile({Key? key}) : super(key: key);

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {
  var horspace = FetchPixels.getPixelHeight(20);

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: Consumer2<ProfileProvider, AuthProvider>(
        builder: (context, profileProvider, authProvider, _) {
          return SingleChildScrollView(
            // ignore: prefer_const_constructors
            physics: BouncingScrollPhysics(),
            child: AnimationLimiter(
              child: getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horspace),
                Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 200),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 44.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(39)),
                      profileImageWidget(),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      getCustomFont(
                          "${profileProvider.myProfileInfo.firstname} ${profileProvider.myProfileInfo.lastname}",
                          18,
                          Theme.of(context).textTheme.bodyMedium!.color!,
                          1,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center),
                      getVerSpace(FetchPixels.getPixelHeight(6)),
                      getCustomFont("${profileProvider.myProfileInfo.email}",
                          15, Theme.of(context).textTheme.bodyMedium!.color!, 1,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      myProfileButton(context),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      Builder(
                        builder: (context) {
                          if (profileProvider.myProfileInfo.isActive == "0") {
                            return Column(
                              children: [
                                bankDetailButton(context),
                                getVerSpace(FetchPixels.getPixelHeight(20)),
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                      historyButton(context),
                      getVerSpace(FetchPixels.getPixelHeight(40)),
                      logoutButton(
                        context,
                        onTap: () => authProvider.logout(context),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget logoutButton(BuildContext context, {required VoidCallback onTap}) {
    return getButton(context, Theme.of(context).secondaryHeaderColor, "Logout",
        redColor, onTap, 16,
        weight: FontWeight.w600,
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
        buttonHeight: FetchPixels.getPixelHeight(60),
        isBorder: true,
        borderColor: redColor,
        borderWidth: FetchPixels.getPixelHeight(2));
  }

  Widget terminateAccountButton(BuildContext context) {
    return getButton(context, Theme.of(context).secondaryHeaderColor,
        "Terminate Account", Colors.red, () {}, 16,
        weight: FontWeight.w600,
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
        buttonHeight: FetchPixels.getPixelHeight(60),
        isBorder: true,
        borderColor: Colors.red,
        borderWidth: FetchPixels.getPixelHeight(2));
  }

  GestureDetector historyButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constant.navigatePush(context, HistoryScreen());
      },
      child: Container(
        padding: EdgeInsets.only(
            left: FetchPixels.getPixelHeight(16),
            right: FetchPixels.getPixelHeight(16),
            top: FetchPixels.getPixelHeight(16),
            bottom: FetchPixels.getPixelHeight(16)),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSvgImage("history.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getMediumCustomFont(context, "History"),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    SizedBox(
                      width: FetchPixels.getPixelHeight(220),
                      child: getMultilineCustomFont(
                          "All your transactions on FWHeirs", 15, textColor,
                          fontWeight: FontWeight.w400,
                          txtHeight: FetchPixels.getPixelHeight(1.3)),
                    )
                  ],
                )
              ],
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

  GestureDetector bankDetailButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constant.navigatePush(context, BankDetail());
      },
      child: Container(
        padding: EdgeInsets.only(
            left: FetchPixels.getPixelHeight(16),
            right: FetchPixels.getPixelHeight(16),
            top: FetchPixels.getPixelHeight(16),
            bottom: FetchPixels.getPixelHeight(16)),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSvgImage("card.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getMediumCustomFont(context, "Bank Details"),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    SizedBox(
                      width: FetchPixels.getPixelHeight(220),
                      child: getMultilineCustomFont(
                          "This account is used to faciliate all your deposits",
                          15,
                          textColor,
                          fontWeight: FontWeight.w400,
                          txtHeight: FetchPixels.getPixelHeight(1.3)),
                    )
                  ],
                )
              ],
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

  GestureDetector myProfileButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constant.navigatePush(context, MyProfile());
      },
      child: Container(
        padding: EdgeInsets.only(
            left: FetchPixels.getPixelHeight(16),
            right: FetchPixels.getPixelHeight(16),
            top: FetchPixels.getPixelHeight(16),
            bottom: FetchPixels.getPixelHeight(16)),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSvgImage("profile.svg"),
                getHorSpace(FetchPixels.getPixelHeight(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getMediumCustomFont(context, "My Profile"),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    SizedBox(
                      width: FetchPixels.getPixelHeight(220),
                      child: getMultilineCustomFont(
                          "Complete your profile to buy, sell and withdraw",
                          15,
                          textColor,
                          fontWeight: FontWeight.w400,
                          txtHeight: FetchPixels.getPixelHeight(1.3)),
                    )
                  ],
                )
              ],
            ),
            getSvgImage("arrow_right.svg")
          ],
        ),
      ),
    );
  }

  Widget profileImageWidget() {
    return getAssetImage("fwheirsappp.png",
        height: FetchPixels.getPixelHeight(105),
        width: FetchPixels.getPixelHeight(105));
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(context, "back.svg", () {},
          istext: true,
          title: "Profile",
          fontsize: 24,
          weight: FontWeight.w700,
          textColor: Theme.of(context).textTheme.bodyLarge?.color,
          isleftimage: false,
          isrightimage: true,
          rightimage: "setting.svg", rightFunction: () {
        Constant.navigatePush(context, SettingScreen());
      }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      // backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: FetchPixels.getPixelHeight(66),
      title: getCustomFont(
          "Profile", 22, Theme.of(context).textTheme.bodyLarge!.color!, 1,
          fontWeight: FontWeight.w700),
      centerTitle: true,
      actions: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Constant.navigatePush(context, SettingScreen());
              },
              child: getSvgImage("setting.svg"),
            ),
            getHorSpace(FetchPixels.getPixelHeight(20))
          ],
        )
      ],
    );
  }
}
