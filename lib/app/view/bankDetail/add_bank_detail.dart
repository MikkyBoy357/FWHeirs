import 'package:flutter/material.dart';
import 'package:fwheirs/app/view_models/referrals_providers.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:fwheirs/widgets/name_text_field.dart';
import 'package:provider/provider.dart';

import '../../../widgets/dropdown_text_field.dart';

class AddBankDetail extends StatefulWidget {
  const AddBankDetail({Key? key}) : super(key: key);

  @override
  State<AddBankDetail> createState() => _AddBankDetailState();
}

class _AddBankDetailState extends State<AddBankDetail> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ReferralsProvider>(context, listen: false).getBanks(context);
      Provider.of<ReferralsProvider>(context, listen: false).setBankNames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Consumer<ReferralsProvider>(
        builder: (context, referralsProvider, _) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: horSpace,
                  vertical: FetchPixels.getPixelHeight(30)),
              child: getButton(context, redColor, "Save", Colors.white, () {
                referralsProvider.addBank(context);
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
                  key: referralsProvider.addBankFormKey,
                  child: Column(
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(14)),
                      appBar(context),
                      // getVerSpace(FetchPixels.getPixelHeight(29)),
                      // profileImageWidget(),
                      getVerSpace(FetchPixels.getPixelHeight(30)),
                      DropDownTextField(
                        title: "Bank Name",
                        hasPrefixImage: false,
                        controller: referralsProvider.bankNameController,
                        hintText: 'Select Bank Name',
                        dropDownList: referralsProvider.bankNames,
                        onChanged: (newValue) {
                          setState(() {
                            // _armorcDues = newValue;
                            referralsProvider.bankNameController.text =
                                newValue.toString();
                            print("newBank => $newValue");
                            referralsProvider
                                .setSelectedBank(newValue.toString());
                            print(
                                "SelectedBank => ${referralsProvider.selectedBank.name}");
                            print(
                                "SelectedBank CODE => ${referralsProvider.selectedBank.code}");
                            // print(amorcDuesDropDown.indexOf(newValue));
                            // var index = amorcDuesDropDown.indexOf(newValue);
                            // payment.changeDuesAmount(index);
                            // payment.calculateTotal();
                          });
                        },
                        value:
                            referralsProvider.bankNameController.text.isNotEmpty
                                ? referralsProvider.bankNameController.text
                                : referralsProvider.banks[0].name,
                      ),
                      getVerSpace(horSpace),
                      NumberTextField(
                        controller: referralsProvider.accountNumberController,
                        hintText: "Account Number",
                        maxLength: 10,
                        onChanged: (String? newValue) {
                          referralsProvider.verifyAccount(context);
                        },
                      ),
                      getVerSpace(horSpace),
                      NameTextField(
                        enabled: false,
                        controller: referralsProvider.accountNameController,
                        hintText: "Account Name",
                      ),
                      // getVerSpace(horSpace),
                      // NameTextField(
                      //   controller: referralsProvider.bankCodeNoController,
                      //   hintText: "Bank Code",
                      // ),
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
      title: "Add Bank Details",
      fontsize: 24,
      weight: FontWeight.w700,
      textColor: Theme.of(context).textTheme.bodyMedium!.color!,
    );
  }
}
