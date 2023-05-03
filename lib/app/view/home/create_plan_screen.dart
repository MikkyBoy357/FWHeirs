import 'package:flutter/material.dart';
import 'package:fwheirs/app/view_models/investment_providers/investment_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:fwheirs/widgets/name_text_field.dart';
import 'package:provider/provider.dart';

import '../../../widgets/dropdown_text_field.dart';

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
            .setBrokersNames();
        Provider.of<InvestmentProvider>(context, listen: false)
            .setPackagesNames();
        Provider.of<InvestmentProvider>(context, listen: false).initDropdowns();
        // Provider.of<InvestmentProvider>(context, listen: false)
        //     .getBrokers(context);
        // Provider.of<InvestmentProvider>(context, listen: false)
        //     .getPackages(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Consumer<InvestmentProvider>(
        builder: (context, investmentProvider, _) {
          print("${investmentProvider.brokers}");
          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: horSpace,
                  vertical: FetchPixels.getPixelHeight(30)),
              child: getButton(context, redColor, "Save", Colors.white, () {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(14)),
                      appBar(context),
                      // getVerSpace(FetchPixels.getPixelHeight(29)),
                      // profileImageWidget(),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      DropDownTextField(
                        title: "Select Broker",
                        hasPrefixImage: true,
                        controller: investmentProvider.brokerController,
                        hintText: 'Select Broker',
                        dropDownList: investmentProvider.brokersNames,
                        onChanged: (newValue) {
                          setState(() {
                            // _armorcDues = newValue;
                            investmentProvider.brokerController.text =
                                newValue.toString();
                            print("newBroker => $newValue");
                            investmentProvider
                                .setSelectedBroker(newValue.toString());
                            print(
                                "SelectedBroker => ${investmentProvider.selectedBroker.id}");
                          });
                        },
                        value:
                            investmentProvider.brokerController.text.isNotEmpty
                                ? investmentProvider.brokerController.text
                                : investmentProvider.brokers[0].name,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      DropDownTextField(
                        title: "Select Package",
                        hasPrefixImage: false,
                        controller: investmentProvider.brokerController,
                        hintText: 'Select Package',
                        dropDownList: investmentProvider.packagesNames,
                        onChanged: (newValue) {
                          setState(() {
                            // _armorcDues = newValue;
                            investmentProvider.packageController.text =
                                newValue.toString();
                            print("newPackage => $newValue");
                            investmentProvider
                                .setSelectedPackage(newValue.toString());
                            print(
                                "SelectedPackage => ${investmentProvider.selectedPackage.id}");
                            // print(amorcDuesDropDown.indexOf(newValue));
                            // var index = amorcDuesDropDown.indexOf(newValue);
                            // payment.changeDuesAmount(index);
                            // payment.calculateTotal();
                          });
                        },
                        value:
                            investmentProvider.packageController.text.isNotEmpty
                                ? investmentProvider.packageController.text
                                : investmentProvider.packages[0].name,
                      ),
                      getVerSpace(horSpace),
                      NumberTextField(
                        hintText: "Duration in days",
                        controller: investmentProvider.durationController,
                      ),
                      getVerSpace(horSpace),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getMediumCustomFont(context, "Amount"),
                          Row(
                            children: [
                              getMediumCustomFont(
                                context,
                                "Min: ${investmentProvider.minVest} || Max: ${investmentProvider.maxVest}"
                                    .valueWithComma,
                              ),
                            ],
                          ),
                        ],
                      ),
                      getVerSpace(5),
                      NumberTextField(
                        // hintText:
                        //     "${investmentProvider.minVest} - ${investmentProvider.minVest}",
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
      textColor: Theme.of(context).textTheme.bodyMedium!.color!,
    );
  }
}
