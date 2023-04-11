import 'package:flutter/material.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';

import '../dialog/complete_dialog.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horspace = FetchPixels.getPixelHeight(20);

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horspace),
              Column(
                children: [
                  getVerSpace(horspace),
                  appBar(context),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  Expanded(
                      flex: 1,
                      child: ListView(
                        primary: true,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: shadowColor,
                                      blurRadius: 23,
                                      offset: const Offset(0, 10))
                                ],
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(14))),
                            padding: EdgeInsets.only(
                                left: horspace,
                                right: horspace,
                                top: horspace,
                                bottom: horspace),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getSvgImage("eur.svg",
                                        width: FetchPixels.getPixelHeight(50),
                                        height: FetchPixels.getPixelHeight(50)),
                                    getHorSpace(FetchPixels.getPixelHeight(12)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            getCustomFont("European Union", 15,
                                                Colors.black, 1,
                                                fontWeight: FontWeight.w600),
                                            getHorSpace(
                                                FetchPixels.getPixelHeight(3)),
                                            getSvgImage("bottom.svg")
                                          ],
                                        ),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(3)),
                                        getCustomFont(
                                            "EUR", 15, subtextColor, 1,
                                            fontWeight: FontWeight.w400),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(5)),
                                        getCustomFont(
                                            "\$56.55", 18, Colors.black, 1,
                                            fontWeight: FontWeight.w600),
                                      ],
                                    )
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFE7F9EF),
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(21))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              FetchPixels.getPixelHeight(6),
                                          vertical:
                                              FetchPixels.getPixelHeight(1)),
                                      child: Row(
                                        children: [
                                          getSvgImage("down.svg"),
                                          getHorSpace(
                                              FetchPixels.getPixelHeight(4)),
                                          getCustomFont(
                                              "2.4%", 13, successColor, 1,
                                              fontWeight: FontWeight.w400)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          getVerSpace(horspace),
                          getSvgImage("transfer.svg",
                              width: FetchPixels.getPixelHeight(50),
                              height: FetchPixels.getPixelHeight(50)),
                          getVerSpace(horspace),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: shadowColor,
                                      blurRadius: 23,
                                      offset: const Offset(0, 10))
                                ],
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(14))),
                            padding: EdgeInsets.only(
                                left: horspace,
                                right: horspace,
                                top: horspace,
                                bottom: horspace),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getSvgImage("usd.svg",
                                        width: FetchPixels.getPixelHeight(50),
                                        height: FetchPixels.getPixelHeight(50)),
                                    getHorSpace(FetchPixels.getPixelHeight(12)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            getCustomFont(
                                                "United States Dollar",
                                                15,
                                                Colors.black,
                                                1,
                                                fontWeight: FontWeight.w600),
                                            getHorSpace(
                                                FetchPixels.getPixelHeight(3)),
                                            getSvgImage("bottom.svg")
                                          ],
                                        ),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(3)),
                                        getCustomFont(
                                            "USD", 15, subtextColor, 1,
                                            fontWeight: FontWeight.w400),
                                        getHorSpace(
                                            FetchPixels.getPixelHeight(5)),
                                        getCustomFont(
                                            "\$21.42", 18, Colors.black, 1,
                                            fontWeight: FontWeight.w600),
                                      ],
                                    )
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFE7F9EF),
                                          borderRadius: BorderRadius.circular(
                                              FetchPixels.getPixelHeight(21))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              FetchPixels.getPixelHeight(6),
                                          vertical:
                                              FetchPixels.getPixelHeight(1)),
                                      child: Row(
                                        children: [
                                          getSvgImage("down.svg"),
                                          getHorSpace(
                                              FetchPixels.getPixelHeight(4)),
                                          getCustomFont(
                                              "1.3%", 13, successColor, 1,
                                              fontWeight: FontWeight.w400)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(40)),
                          getButton(context, redColor, "Exchange", Colors.white,
                              () {
                            showDialog(
                              builder: (context) {
                                return const CompleteDialog();
                              },
                              context: context,
                              barrierDismissible: true,
                            );
                          }, 16,
                              weight: FontWeight.w600,
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(15)),
                              buttonHeight: FetchPixels.getPixelHeight(60))
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

  Widget appBar(BuildContext context) {
    return gettoolbarMenu(context, "back.svg", () {
      backToPrev();
    },
        istext: true,
        title: "Exchange",
        fontsize: 24,
        weight: FontWeight.w700,
        textColor: Colors.black);
  }
}
