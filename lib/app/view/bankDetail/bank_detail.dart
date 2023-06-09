import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fwheirs/app/data/data_file.dart';
import 'package:fwheirs/app/models/model_payment.dart';
import 'package:fwheirs/app/view_models/referrals_providers.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:provider/provider.dart';

import '../../models/payout_account_model.dart';
import 'add_bank_detail.dart';

class BankDetail extends StatefulWidget {
  const BankDetail({Key? key}) : super(key: key);

  @override
  State<BankDetail> createState() => _BankDetailState();
}

class _BankDetailState extends State<BankDetail> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);
  List<ModelPayment> paymentLists = DataFile.paymentList;

  void initFunction() {
    Provider.of<ReferralsProvider>(context, listen: false)
        .getPayoutAccounts(context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
      child: Consumer<ReferralsProvider>(
        builder: (context, referralsProvider, _) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                "Bank Details",
                22,
                Theme.of(context).textTheme.bodyLarge!.color!,
                1,
                fontWeight: FontWeight.w700,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                initFunction();
              },
              child: getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horSpace),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // getVerSpace(FetchPixels.getPixelHeight(14)),
                      // appBar(context),
                      if (paymentLists.isEmpty)
                        emptyWidget(context)
                      else
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getVerSpace(FetchPixels.getPixelHeight(39)),
                                getMediumCustomFont(context, "Your banks:"),
                                getVerSpace(FetchPixels.getPixelHeight(16)),
                                Builder(builder: (context) {
                                  if (referralsProvider
                                      .payoutAccounts.isNotEmpty) {
                                    return cardList(
                                        myBanks:
                                            referralsProvider.payoutAccounts);
                                  } else {
                                    return Text(
                                      "Nothing to show, Click the button below to add bank details.",
                                      style: TextStyle(fontSize: 18),
                                    );
                                  }
                                }),
                              ],
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding:
                  EdgeInsets.only(bottom: 30, top: 10, left: 20, right: 20),
              child: getButton(
                context,
                redColor,
                "Add New Bank",
                Colors.white,
                () {
                  Constant.sendToScreen(AddBankDetail(), context);
                },
                16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60),
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

  AnimationLimiter cardList({required List<PayoutAccountModel> myBanks}) {
    print(myBanks);
    return AnimationLimiter(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: myBanks.length,
        itemBuilder: (context, index) {
          PayoutAccountModel payoutAccountModel = myBanks[index];
          ModelPayment modelPayment = paymentLists[0];
          return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 200),
              child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                      child: Container(
                    margin: EdgeInsets.only(bottom: horSpace),
                    padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelHeight(10),
                        vertical: FetchPixels.getPixelHeight(10)),
                    decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        boxShadow: [
                          BoxShadow(
                              color: shadowColor,
                              blurRadius: 23,
                              offset: const Offset(0, 7))
                        ],
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: FetchPixels.getPixelHeight(62),
                              width: FetchPixels.getPixelHeight(62),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(
                                      FetchPixels.getPixelHeight(12))),
                              padding: EdgeInsets.symmetric(
                                  vertical: FetchPixels.getPixelHeight(8),
                                  horizontal: FetchPixels.getPixelHeight(8)),
                              child: getSvgImage(modelPayment.image ?? ""),
                            ),
                            getHorSpace(FetchPixels.getPixelHeight(16)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.9,
                                  child: getMediumCustomFont(
                                    context,
                                    payoutAccountModel.bankName ?? "",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                getVerSpace(FetchPixels.getPixelHeight(4)),
                                getMediumCustomFont(
                                  context,
                                  payoutAccountModel.accountNumber ?? "",
                                  fontWeight: FontWeight.w400,
                                ),
                                getVerSpace(FetchPixels.getPixelHeight(4)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.9,
                                  child: getMediumCustomFont(
                                    context,
                                    payoutAccountModel.accountName ?? "",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            print("Delete Bank");
                            Provider.of<ReferralsProvider>(context,
                                    listen: false)
                                .deleteBank(context,
                                    id: "${payoutAccountModel.id}");
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ))));
        },
      ),
    );
  }

  Expanded emptyWidget(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getSvgImage("unlock.svg"),
            getVerSpace(horSpace),
            getCustomFont("No Cards Yet!", 20, Colors.black, 1,
                fontWeight: FontWeight.w700),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            getMultilineCustomFont(
                "Add your card and lets get started.", 16, Colors.black,
                fontWeight: FontWeight.w400,
                txtHeight: FetchPixels.getPixelHeight(1.3)),
            getVerSpace(FetchPixels.getPixelHeight(40)),
            getButton(context, Colors.white, "Add Card", redColor, () {}, 16,
                weight: FontWeight.w600,
                isBorder: true,
                borderColor: redColor,
                borderWidth: FetchPixels.getPixelHeight(2),
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(14)),
                buttonHeight: FetchPixels.getPixelHeight(60),
                insetsGeometry: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelHeight(98)))
          ],
        ));
  }

  Widget appBar(BuildContext context) {
    return gettoolbarMenu(
      context,
      "back.svg",
      () {
        backToPrev();
      },
      istext: true,
      title: "Bank Details",
      fontsize: 24,
      weight: FontWeight.w700,
      textColor: Theme.of(context).textTheme.bodyMedium!.color!,
    );
  }
}
