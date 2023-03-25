import 'package:flutter/material.dart';
import 'package:fwheirs/app/view_models/investment_providers/investment_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:fwheirs/widgets/name_text_field.dart';
import 'package:provider/provider.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({Key? key}) : super(key: key);

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);

  // Future<void> getData() async {
  //   firstNameController.text = await PrefData.getFirstName();
  //   lastNameController.text = await PrefData.getLastName();
  //   emailController.text = await PrefData.getEmail();
  //   phoneNoController.text = await PrefData.getPhoneNo();
  // }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<InvestmentProvider>(context, listen: false)
            .getBrokers(context);
        Provider.of<InvestmentProvider>(context, listen: false)
            .getPackages(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Consumer<InvestmentProvider>(
        builder: (context, investmentProvider, _) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: horSpace,
                  vertical: FetchPixels.getPixelHeight(30)),
              child: getButton(
                  context, blueColor, "Save", Colors.white, () {
                    investmentProvider.createInvestment(context);
              }, 16,
                  weight: FontWeight.w600,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                  buttonHeight: FetchPixels.getPixelHeight(60)),
            ),
            body: SafeArea(
              child: getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horSpace),
                Form(
                  key: investmentProvider.createPlanFormKey,
                  child: Column(
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(14)),
                      appBar(context),
                      // getVerSpace(FetchPixels.getPixelHeight(29)),
                      // profileImageWidget(),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      NumberTextField(
                        hintText: "Select Broker",
                        controller: investmentProvider.brokerController,
                      ),
                      getVerSpace(horSpace),
                      NumberTextField(
                        hintText: "Select Package",
                        controller: investmentProvider.packageController,
                      ),
                      getVerSpace(horSpace),
                      NumberTextField(
                        hintText: "Duration in days",
                        controller: investmentProvider.durationController,
                      ),
                      getVerSpace(horSpace),
                      NumberTextField(
                        hintText: "Amount",
                        controller: investmentProvider.amountController,
                      ),
                    ],
                  ),
                ),
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

  Align profileImageWidget() {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          getAssetImage("profile_photo.png",
              height: FetchPixels.getPixelHeight(105),
              width: FetchPixels.getPixelHeight(105)),
          Positioned(
              child: Container(
            height: FetchPixels.getPixelHeight(34),
            width: FetchPixels.getPixelHeight(34),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(30)),
                boxShadow: [
                  BoxShadow(
                      color: containerShadow,
                      blurRadius: 18,
                      offset: const Offset(0, 4))
                ]),
            padding: EdgeInsets.all(FetchPixels.getPixelHeight(5)),
            child: getSvgImage("edit.svg"),
          ))
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return gettoolbarMenu(
      context,
      "back.svg",
      () {
        backToPrev();
      },
      istext: true,
      title: "Create Plan",
      fontsize: 24,
      weight: FontWeight.w700,
      textColor: Colors.black,
    );
  }
}
