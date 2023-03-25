import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fwheirs/app/data/data_file.dart';
import 'package:fwheirs/app/models/model_payment.dart';
import 'package:fwheirs/app/view/bankDetail/add_bank_detail.dart';
import 'package:fwheirs/app/view_models/referrals_providers.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:provider/provider.dart';

import '../../models/bank_model.dart';

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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ReferralsProvider>(context, listen: false).getBanks(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(child: Consumer<ReferralsProvider>(
      builder: (context, referralsProvider, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horSpace),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  appBar(context),
                  if (paymentLists.isEmpty)
                    emptyWidget(context)
                  else
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getVerSpace(FetchPixels.getPixelHeight(39)),
                                getCustomFont(
                                  "Your cards",
                                  16,
                                  Colors.black,
                                  1,
                                  fontWeight: FontWeight.w400,
                                ),
                                getVerSpace(FetchPixels.getPixelHeight(16)),
                                Builder(builder: (context) {
                                  if (referralsProvider.myBanks.isNotEmpty) {
                                    return cardList(
                                        myBanks: referralsProvider.myBanks);
                                  } else {
                                    return Text(
                                      "Nothing to show, Click the button below to add bank details.",
                                      style: TextStyle(fontSize: 18),
                                    );
                                  }
                                }),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: FetchPixels.getPixelHeight(30)),
                              child: getButton(
                                context,
                                blueColor,
                                "Add New Card",
                                Colors.white,
                                () {
                                  Constant.sendToScreen(
                                      AddBankDetail(), context);
                                },
                                16,
                                weight: FontWeight.w600,
                                borderRadius: BorderRadius.circular(
                                    FetchPixels.getPixelHeight(15)),
                                buttonHeight: FetchPixels.getPixelHeight(60),
                              ),
                            ),
                          ],
                        ))
                ],
              ),
            ),
          ),
        );
      },
    ), onWillPop: () async {
      backToPrev();
      return false;
    });
  }

  AnimationLimiter cardList({required List<BankModel> myBanks}) {
    return AnimationLimiter(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: myBanks.length,
        itemBuilder: (context, index) {
          BankModel bankModel = myBanks[index];
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
                        color: Colors.white,
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
                                  color: paymentBg,
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
                                getCustomFont(bankModel.bankName ?? "", 15,
                                    Colors.black, 1,
                                    fontWeight: FontWeight.w600),
                                getVerSpace(FetchPixels.getPixelHeight(4)),
                                getCustomFont(bankModel.accountNumber ?? '', 15,
                                    Colors.black, 1,
                                    fontWeight: FontWeight.w400),
                                getVerSpace(FetchPixels.getPixelHeight(4)),
                                getCustomFont(bankModel.accountName ?? "", 15,
                                    Colors.black, 1,
                                    fontWeight: FontWeight.w600),
                              ],
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            print("Delete Bank");
                            Provider.of<ReferralsProvider>(context,
                                    listen: false)
                                .deleteBank(context, id: "${bankModel.id}");
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
            getButton(context, Colors.white, "Add Card", blueColor, () {}, 16,
                weight: FontWeight.w600,
                isBorder: true,
                borderColor: blueColor,
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
      textColor: Colors.black,
    );
  }
}
