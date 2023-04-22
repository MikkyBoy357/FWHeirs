import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fwheirs/app/data/data_file.dart';
import 'package:fwheirs/app/models/banner_model.dart';
import 'package:fwheirs/app/models/investment_model.dart';
import 'package:fwheirs/app/models/model_news.dart';
import 'package:fwheirs/app/view/home/create_plan_screen.dart';
import 'package:fwheirs/app/view/home/detail_screen.dart';
import 'package:fwheirs/app/view/home/tab/tab_transaction.dart';
import 'package:fwheirs/app/view/profile/my_profile.dart';
import 'package:fwheirs/app/view_models/investment_providers/investment_provider.dart';
import 'package:fwheirs/app/view_models/profile_providers/profile_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/pref_data.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:fwheirs/main.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: redColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Constant.sendToScreen(CreatePlanScreen(), context);
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer2<InvestmentProvider, ProfileProvider>(
          builder: (context, investmentProvider, profileProvider, _) {
            return Stack(
              children: [
                Container(
                  color: Theme.of(context).brightness == Brightness.light
                      ? redColor
                      : Theme.of(context).secondaryHeaderColor,
                  padding:
                      EdgeInsets.only(top: FetchPixels.getPixelHeight(268)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                Positioned(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      Provider.of<InvestmentProvider>(context, listen: false)
                          .getInvestments(context);
                      MyApp.setWholeAppState(context);
                    },
                    child: Column(
                      children: [
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        appBar(
                          context,
                          firstName:
                              profileProvider.myProfileInfo.firstname ?? "",
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: AnimationLimiter(
                              child: Column(
                                children:
                                    AnimationConfiguration.toStaggeredList(
                                  duration: const Duration(milliseconds: 200),
                                  childAnimationBuilder: (widget) =>
                                      SlideAnimation(
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
                                      margin: EdgeInsets.symmetric(
                                          horizontal: horspace),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: horspace),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          getCustomFont("Total Worth", 15,
                                              Colors.black, 1,
                                              fontWeight: FontWeight.w600),
                                          getCustomFont(
                                              "₦${investmentProvider.totalWorth}\u20A6"
                                                  .valueWithComma,
                                              24,
                                              redColor,
                                              1,
                                              fontWeight: FontWeight.w600)
                                        ],
                                      ),
                                    ),
                                    getVerSpace(FetchPixels.getPixelHeight(19)),
                                    SizedBox(
                                      height: FetchPixels.getPixelHeight(160),
                                      child: CarouselSlider.builder(
                                        options: CarouselOptions(
                                          // autoPlay: true,
                                          aspectRatio: 11.2 / 9,
                                          viewportFraction: 1.0,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          height: 160,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              profileProvider.selectedBanner =
                                                  index;
                                              profileProvider.changeNotifiers();
                                            });
                                          },
                                        ),
                                        itemCount: 3,
                                        itemBuilder: (BuildContext context,
                                            int itemIndex, int pageViewIndex) {
                                          BannerModel currentBanner =
                                              profileProvider
                                                  .banners[itemIndex];

                                          return GestureDetector(
                                            onTap: () async {
                                              print(currentBanner);
                                              String url =
                                                  currentBanner.link ?? "";
                                              if (await canLaunchUrl(
                                                  Uri.parse(url))) {
                                                launchUrl(Uri.parse(url));
                                              } else {
                                                print(currentBanner.link);
                                              }
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 15.0),
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    currentBanner.image ?? "",
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    getVerSpace(FetchPixels.getPixelHeight(15)),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: DotsIndicator(
                                        dotsCount:
                                            profileProvider.banners.length,
                                        position: profileProvider.selectedBanner
                                            .toDouble(),
                                        decorator: DotsDecorator(
                                          size: Size.square(9.0),
                                          activeColor: redColor,
                                          activeShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          activeSize: Size(16.0, 8.0),
                                        ),
                                      ),
                                    ),
                                    // getVerSpace(FetchPixels.getPixelHeight(19)),
                                    // SizedBox(
                                    //   height: FetchPixels.getPixelHeight(160),
                                    //   child: buildPageView(),
                                    // ),
                                    // getVerSpace(FetchPixels.getPixelHeight(17)),
                                    // indicator(),
                                    getVerSpace(FetchPixels.getPixelHeight(24)),
                                    getPaddingWidget(
                                      EdgeInsets.symmetric(
                                          horizontal: horspace),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          getMediumCustomFont(
                                            context,
                                            "Minting Plans",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     Constant.navigatePush(
                                          //         context, PortfolioScreen());
                                          //   },
                                          //   child: getCustomFont(
                                          //       "View all", 15, subtextColor, 1,
                                          //       fontWeight: FontWeight.w400),
                                          // )
                                        ],
                                      ),
                                    ),
                                    getVerSpace(FetchPixels.getPixelHeight(12)),
                                    Builder(
                                      builder: (context) {
                                        if (investmentProvider
                                            .investments.isNotEmpty) {
                                          return portfolioList(
                                              investments: investmentProvider
                                                  .investments);
                                        } else {
                                          return Container(
                                            height: 200,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: getSvgImage(
                                                    "transaction_minus.svg",
                                                    width: 80,
                                                    height: 80,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .color!
                                                        : Colors.white,
                                                  ),
                                                ),
                                                getMediumCustomFont(context,
                                                    "No Minting Plans yet")
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                    ),
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
                    ),
                  ),
                )
              ],
            );
          },
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
            Constant.navigatePush(context, DetailScreen());
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

  SizedBox portfolioList({required List<InvestmentModel> investments}) {
    print("${investments.length} Length");
    return SizedBox(
      height: FetchPixels.getPixelHeight(138 * 4),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        primary: false,
        // shrinkWrap: true,
        // physics: const BouncingScrollPhysics(),
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        // reverse: true,
        // itemCount: investments.length,
        itemCount: investments.length,
        itemBuilder: (context, index) {
          // ModelPortfolio modelPortfolio = portfolioLists[index];
          InvestmentModel currentInvestment = investments[index];
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
                        child: TabTransaction(
                          investment: currentInvestment,
                        ),
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
                left: FetchPixels.getPixelHeight(20),
              ),
              padding: EdgeInsets.only(
                left: FetchPixels.getPixelHeight(16),
                top: FetchPixels.getPixelHeight(16),
                right: FetchPixels.getPixelHeight(15),
                bottom: FetchPixels.getPixelHeight(16),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        blurRadius: 15,
                        offset: const Offset(0, 10))
                  ],
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(14))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // getSvgImage(modelPortfolio.image ?? "",
                        //     height: FetchPixels.getPixelHeight(50),
                        //     width: FetchPixels.getPixelHeight(50)),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              child: Text(
                                "${currentInvestment.duration}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Text(
                              "Days",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        getHorSpace(FetchPixels.getPixelHeight(14)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getMediumCustomFont(
                                context,
                                "${currentInvestment.broker} Broker" ?? "",
                                fontWeight: FontWeight.w600,
                              ),
                              getVerSpace(FetchPixels.getPixelHeight(4)),
                              getMediumCustomFont(
                                context,
                                "${currentInvestment.package}" ?? "",
                                fontSize: 14,
                                fontColor: mictextColor,
                                fontWeight: FontWeight.w600,
                              ),
                              // getVerSpace(FetchPixels.getPixelHeight(4)),
                              // getCustomFont(
                              //     "modelPortfolio.profit" ?? "",
                              //     15,
                              //     "modelPortfolio.profit![0]" == "-"
                              //         ? errorColor
                              //         : successColor,
                              //     1,
                              //     fontWeight: FontWeight.w400),
                              getVerSpace(FetchPixels.getPixelHeight(6)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getCustomFont(
                                    "₦${currentInvestment.vestedAmount}"
                                        .valueWithComma,
                                    18,
                                    successColor,
                                    1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color:
                                          currentInvestment.status == "APPROVED"
                                              ? Colors.orange
                                              : currentInvestment.status ==
                                                      "INACTIVE"
                                                  ? redColor
                                                  : Colors.green,
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    child: Text(
                                      "${currentInvestment.status}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
          print(value);
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
                        getCustomFont("Refer Now", 14, redColor, 1,
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

  Widget appBar(BuildContext context, {required String firstName}) {
    String getGreeting() {
      DateTime dateTime = DateTime.now();
      print(dateTime);
      String greeting = "Good Morning";

      if (dateTime.hour >= 0 && dateTime.hour < 12) {
        greeting = "Good Morning";
      } else if (dateTime.hour >= 12 && dateTime.hour < 16) {
        greeting = "Good Afternoon";
      } else {
        greeting = "Good Evening";
      }
      return greeting;
    }

    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCustomFont("Hello, $firstName", 15, Colors.white, 1,
                  fontWeight: FontWeight.w400),
              getVerSpace(FetchPixels.getPixelHeight(4)),
              getCustomFont(getGreeting(), 20, Colors.white, 1,
                  fontWeight: FontWeight.w700)
            ],
          ),
          Row(
            children: [
              // GestureDetector(
              //     onTap: () {
              //       Constant.navigatePush(context, MarketTrendScreen());
              //     },
              //     child: getSvgImage("search.svg", color: Colors.white)),
              getHorSpace(FetchPixels.getPixelHeight(18)),
              GestureDetector(
                onTap: () {
                  Constant.navigatePush(context, MyProfile());
                },
                child: getAssetImage("fwheirsappp_white.png",
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
