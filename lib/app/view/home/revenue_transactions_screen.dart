import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fwheirs/app/models/revenue_transaction_model.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../view_models/investment_providers/investment_provider.dart';

class RevenueTransactionsScreen extends StatefulWidget {
  const RevenueTransactionsScreen({Key? key}) : super(key: key);

  @override
  State<RevenueTransactionsScreen> createState() =>
      _RevenueTransactionsScreenState();
}

class _RevenueTransactionsScreenState extends State<RevenueTransactionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<InvestmentProvider>(context, listen: false)
          .getRevenueTransactions(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InvestmentProvider>(
      builder: (context, investmentProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Revenue Transactions",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            elevation: 0,
            leading: getPaddingWidget(
              EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(18)),
              GestureDetector(
                child: getSvgImage("back.svg"),
                onTap: () {
                  Constant.backToPrev(context);
                },
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  getMediumCustomFont(context, "Transactions List:"),
                  SizedBox(height: 15),
                  ListView.separated(
                    itemCount: investmentProvider.revenueTransactions.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                    itemBuilder: (context, index) {
                      return markettrendList(
                        revenueTransactions:
                            investmentProvider.revenueTransactions,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget markettrendList(
      {required List<RevenueTransactionModel> revenueTransactions}) {
    return AnimationLimiter(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: revenueTransactions.length,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          RevenueTransactionModel modelTrend = revenueTransactions[index];
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
                                  "₦${modelTrend.amount}",
                                  fontWeight: FontWeight.w600,
                                ),
                                getVerSpace(FetchPixels.getPixelHeight(3)),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: modelTrend.status == "0"
                                        ? Colors.orange
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Text(
                                    "${modelTrend.status}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        // Container(
                        //   padding:
                        //       EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        //   decoration: BoxDecoration(
                        //     color: modelTrend.status == "PENDING"
                        //         ? Colors.orange
                        //         : Colors.green,
                        //     borderRadius: BorderRadius.circular(9),
                        //   ),
                        //   child: Text(
                        //     "${modelTrend.status}",
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold, fontSize: 18),
                        //   ),
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
    );
  }
}
