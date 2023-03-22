import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fwheirs/app/data/data_file.dart';
import 'package:fwheirs/app/models/model_news.dart';
import 'package:fwheirs/app/routes/app_routes.dart';
import 'package:fwheirs/app/view/home/create_plan_screen.dart';
import 'package:fwheirs/app/view/home/tab/tab_transaction.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/pref_data.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';

import '../../../models/model_portfolio.dart';
import '../../../models/model_trend.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  var horspace = FetchPixels.getPixelHeight(20);
  ValueNotifier selectedPage = ValueNotifier(0);
  final _controller = PageController();
  List<ModelPortfolio> portfolioLists = DataFile.portfolioList;
  List<ModelTrend> trendLists = DataFile.trendList;
  List<ModelNews> newsLists = DataFile.newsList;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      backgroundColor: blueColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Constant.sendToScreen(CreatePlanScreen(), context);
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: blueColor,
              padding: EdgeInsets.only(top: FetchPixels.getPixelHeight(268)),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(20)),
                appBar(context),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 200),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 44.0,
                            child: FadeInAnimation(child: widget),
                          ),
                          children: [
                            Container(
                              height: FetchPixels.getPixelHeight(68),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      FetchPixels.getPixelHeight(14))),
                              margin:
                                  EdgeInsets.symmetric(horizontal: horspace),
                              padding:
                                  EdgeInsets.symmetric(horizontal: horspace),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getCustomFont(
                                      "Total Worth", 15, Colors.black, 1,
                                      fontWeight: FontWeight.w600),
                                  getCustomFont("\$420.26", 24, blueColor, 1,
                                      fontWeight: FontWeight.w600)
                                ],
                              ),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(19)),
                            SizedBox(
                              height: FetchPixels.getPixelHeight(160),
                              child: buildPageView(),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(17)),
                            indicator(),
                            getVerSpace(FetchPixels.getPixelHeight(24)),
                            getPaddingWidget(
                              EdgeInsets.symmetric(horizontal: horspace),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getCustomFont(
                                      "Investments", 18, Colors.black, 1,
                                      fontWeight: FontWeight.w600),
                                  GestureDetector(
                                    onTap: () {
                                      Constant.sendToNext(
                                          context, Routes.portfolioRoute);
                                    },
                                    child: getCustomFont(
                                        "View all", 15, subtextColor, 1,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(12)),
                            portfolioList(),
                            // getPaddingWidget(
                            //   EdgeInsets.symmetric(horizontal: horspace),
                            //   Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       getCustomFont("Market Trend", 18, Colors.black, 1,
                            //           fontWeight: FontWeight.w600),
                            //       GestureDetector(
                            //         onTap: () {
                            //           Constant.sendToNext(
                            //               context, Routes.marketTrendRoute);
                            //         },
                            //         child: getCustomFont(
                            //             "View all", 15, subtextColor, 1,
                            //             fontWeight: FontWeight.w400),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // getVerSpace(FetchPixels.getPixelHeight(12)),
                            // marketTrendList(),
                            // getVerSpace(FetchPixels.getPixelHeight(4)),
                            // getPaddingWidget(
                            //   EdgeInsets.symmetric(horizontal: horspace),
                            //   Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       getCustomFont("News", 18, Colors.black, 1,
                            //           fontWeight: FontWeight.w600),
                            //       GestureDetector(
                            //         onTap: () {
                            //           Constant.sendToNext(
                            //               context, Routes.marketTrendRoute);
                            //         },
                            //         child: getCustomFont(
                            //             "View all", 15, subtextColor, 1,
                            //             fontWeight: FontWeight.w400),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // getVerSpace(FetchPixels.getPixelHeight(12)),
                            // newsList()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  SizedBox newsList() {
    return SizedBox(
      height: FetchPixels.getPixelHeight(235),
      child: ListView.builder(
        itemCount: newsLists.length,
        primary: false,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          ModelNews modelNews = newsLists[index];
          return Container(
            margin: EdgeInsets.only(
                right: FetchPixels.getPixelHeight(16),
                left: index == 0 ? FetchPixels.getPixelHeight(20) : 0),
            child: Column(
              children: [
                getAssetImage(modelNews.image ?? "",
                    width: FetchPixels.getPixelHeight(295),
                    height: FetchPixels.getPixelHeight(158)),
                Container(
                  width: FetchPixels.getPixelHeight(295),
                  padding: EdgeInsets.only(
                      left: FetchPixels.getPixelHeight(14),
                      top: FetchPixels.getPixelHeight(14),
                      bottom: FetchPixels.getPixelHeight(18)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor,
                            blurRadius: 23,
                            offset: const Offset(0, 7))
                      ],
                      borderRadius: BorderRadius.vertical(
                          bottom:
                              Radius.circular(FetchPixels.getPixelHeight(14)))),
                  child: getCustomFont(
                      modelNews.name ?? "", 14, Colors.black, 1,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  ListView marketTrendList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 4,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        ModelTrend modelTrend = trendLists[index];
        return GestureDetector(
          onTap: () {
            PrefData.setTrendName(modelTrend.name ?? "");
            PrefData.setTrendImage(modelTrend.image ?? "");
            PrefData.setTrendCurrency(modelTrend.currency ?? "");
            PrefData.setTrendPrice(modelTrend.price ?? 0.00);
            PrefData.setTrendProfit(modelTrend.profit ?? "");
            Constant.sendToNext(context, Routes.detailRoute);
          },
          child: Container(
            margin: EdgeInsets.only(
                left: horspace,
                right: horspace,
                bottom: FetchPixels.getPixelHeight(20)),
            padding: EdgeInsets.only(
                left: FetchPixels.getPixelHeight(16),
                right: FetchPixels.getPixelHeight(16),
                top: FetchPixels.getPixelHeight(16),
                bottom: FetchPixels.getPixelHeight(18)),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: shadowColor,
                      blurRadius: 23,
                      offset: const Offset(0, 10))
                ],
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(14))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    getSvgImage(modelTrend.image ?? "",
                        height: FetchPixels.getPixelHeight(50),
                        width: FetchPixels.getPixelHeight(50)),
                    getHorSpace(FetchPixels.getPixelHeight(12)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getCustomFont(
                            modelTrend.name ?? "", 15, Colors.black, 1,
                            fontWeight: FontWeight.w600),
                        getVerSpace(FetchPixels.getPixelHeight(3)),
                        getCustomFont(
                            modelTrend.currency ?? "", 15, subtextColor, 1,
                            fontWeight: FontWeight.w400)
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    getCustomFont("\$${modelTrend.price}", 15, Colors.black, 1,
                        fontWeight: FontWeight.w600),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    Wrap(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: modelTrend.profit![0] == "-"
                                  ? errorbg
                                  : successBg,
                              borderRadius: BorderRadius.circular(
                                  FetchPixels.getPixelHeight(21))),
                          padding: EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelHeight(6),
                              vertical: FetchPixels.getPixelHeight(1)),
                          child: Row(
                            children: [
                              getSvgImage(modelTrend.profit![0] == "-"
                                  ? "error_icon.svg"
                                  : 'success_icon.svg'),
                              getHorSpace(FetchPixels.getPixelHeight(4)),
                              getCustomFont(
                                  modelTrend.profit ?? '',
                                  13,
                                  modelTrend.profit![0] == "-"
                                      ? errorColor
                                      : successColor,
                                  1,
                                  fontWeight: FontWeight.w400)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  SizedBox portfolioList() {
    return SizedBox(
      height: FetchPixels.getPixelHeight(138),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          ModelPortfolio modelPortfolio = portfolioLists[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Material(
                      child: SafeArea(
                        top: true,
                        bottom: false,
                        child: TabTransaction(),
                      ),
                    );
                  },
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                  bottom: FetchPixels.getPixelHeight(25),
                  right: FetchPixels.getPixelHeight(25),
                  left: index == 0 ? FetchPixels.getPixelHeight(20) : 0),
              padding: EdgeInsets.only(
                  left: FetchPixels.getPixelHeight(16),
                  top: FetchPixels.getPixelHeight(16),
                  right: FetchPixels.getPixelHeight(32)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        blurRadius: 15,
                        offset: const Offset(0, 10))
                  ],
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(14))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSvgImage(modelPortfolio.image ?? "",
                      height: FetchPixels.getPixelHeight(50),
                      width: FetchPixels.getPixelHeight(50)),
                  getHorSpace(FetchPixels.getPixelHeight(14)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                          modelPortfolio.name ?? "", 15, Colors.black, 1,
                          fontWeight: FontWeight.w600),
                      getVerSpace(FetchPixels.getPixelHeight(4)),
                      getCustomFont(
                          modelPortfolio.profit ?? "",
                          15,
                          modelPortfolio.profit![0] == "-"
                              ? errorColor
                              : successColor,
                          1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(6)),
                      getCustomFont(
                          "\$${modelPortfolio.price}", 18, Colors.black, 1,
                          fontWeight: FontWeight.w600),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (position) {
          return getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(5)),
              getSvgImage(position == selectedPage.value
                  ? "blue_selcted.svg"
                  : "dot.svg"));
        },
      ),
    );
  }

  PageView buildPageView() {
    return PageView.builder(
      controller: _controller,
      onPageChanged: (value) {
        setState(() {
          selectedPage.value = value;
        });
      },
      itemCount: 3,
      itemBuilder: (context, index) {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: FetchPixels.getPixelHeight(21)),
              margin: EdgeInsets.symmetric(horizontal: horspace),
              decoration: BoxDecoration(
                  color: const Color(0xFFECF4FF),
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(14))),
              child: SizedBox(
                width: FetchPixels.getPixelHeight(217),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(22)),
                    SizedBox(
                      width: FetchPixels.getPixelWidth(149),
                      child: getMultilineCustomFont(
                          "Safe & Secure Crypto", 18, Colors.black,
                          fontWeight: FontWeight.w700,
                          txtHeight: FetchPixels.getPixelHeight(1.3)),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(11)),
                    getMultilineCustomFont(
                        "Safe & Secure Crypto Currency", 13, Colors.black,
                        fontWeight: FontWeight.w400,
                        txtHeight: FetchPixels.getPixelHeight(1.3)),
                    getVerSpace(FetchPixels.getPixelHeight(11)),
                    Row(
                      children: [
                        getCustomFont("Refer Now", 14, blueColor, 1,
                            fontWeight: FontWeight.w600),
                        getHorSpace(FetchPixels.getPixelHeight(4)),
                        getSvgImage("right_arrow.svg"),
                      ],
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(19)),
                  ],
                ),
              ),
            ),
            Positioned(
                child: SizedBox(
                    height: FetchPixels.getPixelHeight(160),
                    width: FetchPixels.getPixelHeight(286),
                    child: getAssetImage("slider_image.png")))
          ],
        );
      },
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCustomFont("Hello, Alena", 15, Colors.white, 1,
                  fontWeight: FontWeight.w400),
              getVerSpace(FetchPixels.getPixelHeight(4)),
              getCustomFont("Manage Forex", 20, Colors.white, 1,
                  fontWeight: FontWeight.w700)
            ],
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Constant.sendToNext(context, Routes.marketTrendRoute);
                  },
                  child: getSvgImage("search.svg", color: Colors.white)),
              getHorSpace(FetchPixels.getPixelHeight(18)),
              GestureDetector(
                onTap: () {
                  Constant.sendToNext(context, Routes.myProfileRoute);
                },
                child: getAssetImage("profile_image.png",
                    width: FetchPixels.getPixelHeight(40),
                    height: FetchPixels.getPixelHeight(40)),
              )
            ],
          )
        ],
      ),
    );
  }
}
