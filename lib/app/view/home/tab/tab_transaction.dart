import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fwheirs/app/data/data_file.dart';
import 'package:fwheirs/app/models/investment_model.dart';
import 'package:fwheirs/app/models/model_portfolio.dart';
import 'package:fwheirs/app/view_models/investment_providers/investment_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:fwheirs/widgets/error_dialog.dart';
import 'package:provider/provider.dart';

class TabTransaction extends StatefulWidget {
  final InvestmentModel investment;

  const TabTransaction({
    Key? key,
    required this.investment,
  }) : super(key: key);

  @override
  State<TabTransaction> createState() => _TabTransactionState();
}

class _TabTransactionState extends State<TabTransaction> {
  var horspace = FetchPixels.getPixelHeight(20);
  List<ModelPortfolio> portfolioLists = DataFile.portfolioList;
  bool isSwitch = true;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: getPaddingWidget(
          EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(18)),
          GestureDetector(
            child: getSvgImage("back.svg"),
            onTap: () {
              Constant.backToPrev(context);
            },
          ),
        ),
        title: getCustomFont(
          "Market Trend",
          22,
          Theme.of(context).textTheme.bodyLarge!.color!,
          1,
          fontWeight: FontWeight.w700,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       CupertinoIcons.info,
        //       color: blueColor,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          // getVerSpace(FetchPixels.getPixelHeight(14)),
          // appBar(context),
          getVerSpace(FetchPixels.getPixelHeight(39)),
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                          currentValueWidget(),
                          getVerSpace(horspace),
                          totalBalanceWidget(context),
                          getVerSpace(horspace),
                          // priceAlertWidget(),
                          terminateAccountButton(
                            context,
                            label: "Upscale Investment",
                            color: Colors.green,
                            onTap: () {},
                          ),
                          getVerSpace(horspace),
                          terminateAccountButton(
                            context,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmDialog(
                                    onYes: () {
                                      Provider.of<InvestmentProvider>(context,
                                              listen: false)
                                          .terminateInvestment(context,
                                              investmentId:
                                                  widget.investment.id);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(40)),
                          getVerSpace(FetchPixels.getPixelHeight(24)),
                          // transactionList()
                        ],
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
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

  Container priceAlertWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
      height: FetchPixels.getPixelHeight(71),
      padding: EdgeInsets.symmetric(
        horizontal: FetchPixels.getPixelHeight(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getMediumCustomFont(
            context,
            "Portfolio price alert",
            fontWeight: FontWeight.w600,
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

  Container totalBalanceWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horspace, vertical: horspace),
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
      child: Column(
        children: [
          getMediumCustomFont(
            context,
            "Total Balance",
            fontWeight: FontWeight.w400,
          ),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont("₦****", 18, blueColor, 1, fontWeight: FontWeight.w600),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(
              context,
              Theme.of(context).scaffoldBackgroundColor,
              "${widget.investment.broker} User's Guide",
              Colors.black,
              () {},
              15,
              weight: FontWeight.w400,
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              buttonHeight: FetchPixels.getPixelHeight(48),
              sufixIcon: true,
              suffixImage: "arrow_right.svg")
        ],
      ),
    );
  }

  Container currentValueWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          boxShadow: [
            BoxShadow(
                color: shadowColor, blurRadius: 23, offset: const Offset(0, 7))
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
      child: Column(
        children: [
          getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(35)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getCustomFont("Current equity", 15, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getMediumCustomFont(
                      context,
                      "₦****",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                  ],
                ),
                Container(
                  width: FetchPixels.getPixelHeight(1),
                  color: deviderColor,
                  height: FetchPixels.getPixelHeight(95),
                ),
                Column(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getCustomFont("Invested value", 15, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getMediumCustomFont(
                      context,
                      "₦${widget.investment.vestedAmount}".valueWithComma,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                  ],
                ),
              ],
            ),
          ),
          Container(height: FetchPixels.getPixelHeight(1), color: deviderColor),
          getVerSpace(FetchPixels.getPixelHeight(19)),
          getPaddingWidget(
            EdgeInsets.symmetric(horizontal: horspace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCustomFont("Gain / Loss", 15, textColor, 1,
                    fontWeight: FontWeight.w400),
                Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFE7F9EF),
                          borderRadius: BorderRadius.circular(
                              FetchPixels.getPixelHeight(21))),
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelHeight(6),
                          vertical: FetchPixels.getPixelHeight(1)),
                      child: Row(
                        children: [
                          getSvgImage("down.svg"),
                          getHorSpace(FetchPixels.getPixelHeight(4)),
                          getCustomFont('23.4%', 15, successColor, 1,
                              fontWeight: FontWeight.w400)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
        ],
      ),
    );
  }

  ListView transactionList() {
    return ListView.builder(
      primary: true,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: portfolioLists.length,
      itemBuilder: (context, index) {
        ModelPortfolio modelPortfolio = portfolioLists[index];
        return Container(
          margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
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
                    offset: const Offset(0, 10))
              ],
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(14))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  getSvgImage(modelPortfolio.image ?? "",
                      height: FetchPixels.getPixelHeight(50),
                      width: FetchPixels.getPixelHeight(50)),
                  getHorSpace(FetchPixels.getPixelHeight(12)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getMediumCustomFont(
                        context,
                        modelPortfolio.name ?? "",
                        fontWeight: FontWeight.w400,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(4)),
                      getCustomFont(
                          modelPortfolio.profit ?? "",
                          15,
                          modelPortfolio.profit![0] == "-"
                              ? errorColor
                              : successColor,
                          1,
                          fontWeight: FontWeight.w400)
                    ],
                  )
                ],
              ),
              getMediumCustomFont(
                context,
                "\$${modelPortfolio.price}",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
        );
      },
    );
  }

  Widget appBar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: horspace),
      gettoolbarMenu(context, "back.svg", () {
        Constant.backToPrev(context);
      },
          istext: true,
          title: "Transaction",
          fontsize: 24,
          weight: FontWeight.w700,
          textColor: Theme.of(context).textTheme.bodyLarge!.color!,
          isleftimage: true,
          isrightimage: true,
          rightimage: "more.svg"),
    );
  }
}
