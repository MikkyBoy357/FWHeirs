import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fwheirs/app/data/data_file.dart';
import 'package:fwheirs/app/models/model_trend.dart';
import 'package:fwheirs/app/view_models/profile_providers/profile_provider.dart';
import 'package:fwheirs/app/view_models/referrals_providers.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:provider/provider.dart';

import '../../../models/referral_model.dart';
import '../withdraw_screen.dart';

class TabMarket extends StatefulWidget {
  const TabMarket({Key? key}) : super(key: key);

  @override
  State<TabMarket> createState() => _TabMarketState();
}

class _TabMarketState extends State<TabMarket> {
  var horspace = FetchPixels.getPixelHeight(20);
  TextEditingController searchController = TextEditingController();
  List<String> categoryLists = DataFile.categoryList;
  int select = 0;
  List<ModelTrend> newTrendList = DataFile.trendList;

  // onItemChanged(String value) {
  //   setState(() {
  //     newTrendList = DataFile.trendList
  //         .where((string) =>
  //             string.name!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  int length = 0;

  @override
  void initState() {
    super.initState();
    length = newTrendList.length;
    setState(() {});
    Future.delayed(Duration.zero, () {
      Provider.of<ReferralsProvider>(context, listen: false)
          .getReferrals(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Consumer<ReferralsProvider>(
      builder: (context, referralsProvider, _) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: getCustomFont(
              "Agent",
              22,
              Theme.of(context).textTheme.bodyLarge!.color!,
              1,
              fontWeight: FontWeight.w700,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Constant.navigatePush(context, WithdrawScreen());
                },
                icon: Icon(
                  Icons.info_outline,
                  color: redColor,
                ),
              ),
            ],
            elevation: 0,
          ),
          body: Column(
            children: [
              // getVerSpace(FetchPixels.getPixelHeight(14)),
              // appBar(context),
              getVerSpace(FetchPixels.getPixelHeight(23)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // height: 60,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Join our agent program to earn some money when you refer people to our platform.",
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.left,
                      textScaleFactor: FetchPixels.getTextScale(),
                    ),
                  ),
                  // getCustomFont("up 0.63%", 15, redColor, 1,
                  //     fontWeight: FontWeight.w600),
                  // getCustomFont(" in last 24h", 15, Colors.black, 1,
                  //     fontWeight: FontWeight.w400),
                ],
              ),
              // getVerSpace(FetchPixels.getPixelHeight(20)),
              // searchWidget(context),
              getVerSpace(FetchPixels.getPixelHeight(24)),
              categoryList(),
              getVerSpace(FetchPixels.getPixelHeight(24)),
              Builder(builder: (context) {
                print(Provider.of<ProfileProvider>(context)
                    .myProfileInfo
                    .toJson());
                if (select == 0) {
                  return Column(
                    children: [
                      getMediumCustomFont(
                        context,
                        "Here is your agent code:",
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "${Provider.of<ProfileProvider>(context).myProfileInfo.refCode}",
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Balance: ₦500000".valueWithComma,
                        ),
                      ),
                    ],
                  );
                } else {
                  return markettrendList(
                    referrals: referralsProvider.referrals,
                  );
                }
              })
            ],
          ),
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: terminateAccountButton(
          //     context,
          //     label: "Withdraw",
          //     color: redColor,
          //     onTap: () {
          //       Constant.navigatePush(context, WithdrawScreen());
          //     },
          //   ),
          // ),
        );
      },
    );
  }

  Expanded markettrendList({required List<ReferralModel> referrals}) {
    return Expanded(
      child: AnimationLimiter(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: referrals.length,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ReferralModel modelTrend = referrals[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 200),
              child: SlideAnimation(
                verticalOffset: 44.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      // PrefData.setTrendName(modelTrend.name ?? "");
                      // PrefData.setTrendImage(modelTrend.image ?? "");
                      // PrefData.setTrendCurrency(modelTrend.currency ?? "");
                      // PrefData.setTrendPrice(modelTrend.price ?? 0.00);
                      // PrefData.setTrendProfit(modelTrend.profit ?? "");
                      // Constant.navigatePush(context, DetailScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: index == 0 ? FetchPixels.getPixelHeight(5) : 0,
                          left: horspace,
                          right: horspace,
                          bottom: FetchPixels.getPixelHeight(20)),
                      padding: EdgeInsets.only(
                          left: FetchPixels.getPixelHeight(16),
                          right: FetchPixels.getPixelHeight(16),
                          top: FetchPixels.getPixelHeight(16),
                          bottom: FetchPixels.getPixelHeight(18)),
                      decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          boxShadow: [
                            BoxShadow(
                                color: shadowColor,
                                blurRadius: 23,
                                offset: const Offset(0, 10))
                          ],
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(14))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              getAssetImage("fwheirsappp.png",
                                  height: FetchPixels.getPixelHeight(50),
                                  width: FetchPixels.getPixelHeight(50)),
                              getHorSpace(FetchPixels.getPixelHeight(12)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getMediumCustomFont(
                                    context,
                                    "${modelTrend.firstname} ${modelTrend.lastname}",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  getVerSpace(FetchPixels.getPixelHeight(3)),
                                  getMediumCustomFont(
                                    context,
                                    "${modelTrend.email}",
                                    fontColor: textColor,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              )
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     getMediumCustomFont(
                          //       context,
                          //       "\$${modelTrend.price}",
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //     getVerSpace(FetchPixels.getPixelHeight(5)),
                          // Wrap(
                          //   children: [
                          //     Container(
                          //       decoration: BoxDecoration(
                          //           color: modelTrend.profit![0] == "-"
                          //               ? errorbg
                          //               : successBg,
                          //           borderRadius: BorderRadius.circular(
                          //               FetchPixels.getPixelHeight(21))),
                          //       padding: EdgeInsets.symmetric(
                          //           horizontal: FetchPixels.getPixelHeight(6),
                          //           vertical: FetchPixels.getPixelHeight(1)),
                          //       child: Row(
                          //         children: [
                          //           getSvgImage(modelTrend.profit![0] == "-"
                          //               ? "error_icon.svg"
                          //               : 'success_icon.svg'),
                          //           getHorSpace(FetchPixels.getPixelHeight(4)),
                          //           getCustomFont(
                          //               modelTrend.profit ?? '',
                          //               13,
                          //               modelTrend.profit![0] == "-"
                          //                   ? errorColor
                          //                   : successColor,
                          //               1,
                          //               fontWeight: FontWeight.w400)
                          //         ],
                          //       ),
                          //     )
                          //   ],
                          // )
                          // ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox categoryList() {
    return SizedBox(
      height: FetchPixels.getPixelHeight(44),
      child: ListView.builder(
        primary: true,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        // itemCount: categoryLists.length,
        itemBuilder: (context, index) {
          return Wrap(
            children: [
              GestureDetector(
                child: Container(
                  decoration: select == index
                      ? BoxDecoration(
                          color: redColor,
                          boxShadow: [
                            BoxShadow(
                                color: shadowColor,
                                blurRadius: 23,
                                offset: const Offset(0, 7))
                          ],
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(14)))
                      : null,
                  padding: EdgeInsets.symmetric(
                      vertical: FetchPixels.getPixelHeight(11),
                      horizontal:
                          select == index ? FetchPixels.getPixelHeight(20) : 0),
                  margin: EdgeInsets.only(
                      right: FetchPixels.getPixelHeight(37),
                      left: index == 0 ? horspace : 0),
                  child: getCustomFont(categoryLists[index], 15,
                      select == index ? Colors.white : textColor, 1,
                      fontWeight:
                          select == index ? FontWeight.w600 : FontWeight.w400),
                ),
                onTap: () {
                  setState(() {
                    select = index;
                    if (index == 0) {
                      length = newTrendList.length;
                    } else if (index == 1) {
                      length = 2;
                    } else if (index == 2) {
                      length = 4;
                    } else if (index == 3) {
                      length = 5;
                    }
                  });
                },
              )
            ],
          );
        },
      ),
    );
  }

  Widget searchWidget(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
      getSearchWidget(context, searchController, () {}, (value) {},
          withPrefix: true),
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(context, "back.svg", () {},
          istext: true,
          title: "Referrals",
          fontsize: 24,
          weight: FontWeight.w700,
          textColor: Theme.of(context).textTheme.bodyLarge!.color!,
          isleftimage: false,
          isrightimage: true,
          rightimage: "more.svg"),
    );
  }
}

Widget terminateAccountButton(BuildContext context,
    {String? label, Color? color, VoidCallback? onTap}) {
  return getButton(context, Theme.of(context).secondaryHeaderColor,
      label ?? "Terminate Investment", color ?? Colors.red, onTap, 16,
      weight: FontWeight.w600,
      borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
      buttonHeight: FetchPixels.getPixelHeight(60),
      isBorder: true,
      borderColor: color ?? Colors.red,
      borderWidth: FetchPixels.getPixelHeight(2));
}
