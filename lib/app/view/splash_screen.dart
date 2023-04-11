import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fwheirs/app/view/home/home_screen.dart';
import 'package:fwheirs/app/view/intro/intro_screen.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/pref_data.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    PrefData.isLogIn().then((value) {
      Timer(
        const Duration(seconds: 3),
        () {
          (value)
              ? Constant.navigatePush(context, HomeScreen())
              : Constant.navigatePush(context, IntroScreen());
        },
      );
    });
  }

  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          body: Container(
            color: redColor,
            child: Center(
              child: Image.asset("assets/images/fwheirsappp_white.png"),
            ),
          ),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }
}
