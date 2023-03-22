import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/pref_data.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  Future<void> getData() async {
    firstNameController.text = await PrefData.getFirstName();
    lastNameController.text = await PrefData.getLastName();
    emailController.text = await PrefData.getEmail();
    phoneNoController.text = await PrefData.getPhoneNo();
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
                horizontal: horSpace, vertical: FetchPixels.getPixelHeight(30)),
            child: getButton(context, blueColor, "Save", Colors.white, () {
              PrefData.setFirstName(firstNameController.text);
              PrefData.setLastName(lastNameController.text);
              PrefData.setEmail(emailController.text);
              PrefData.setPhoneNo(phoneNoController.text);
              backToPrev();
              backToPrev();
            }, 16,
                weight: FontWeight.w600,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
                buttonHeight: FetchPixels.getPixelHeight(60)),
          ),
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: horSpace),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  appBar(context),
                  // getVerSpace(FetchPixels.getPixelHeight(29)),
                  // profileImageWidget(),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getDefaultTextFiledWithLabel(
                      context, "Bank Name", firstNameController,
                      withprefix: false,
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(horSpace),
                  getDefaultTextFiledWithLabel(
                      context, "Account Name", lastNameController,
                      withprefix: false,
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(horSpace),
                  getDefaultTextFiledWithLabel(
                      context, "Account Number", emailController,
                      withprefix: false,
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(60)),
                  getVerSpace(horSpace),
                  getDefaultTextFiledWithLabel(
                      context, "Account Type", phoneNoController,
                      withprefix: false,
                      image: "message.svg",
                      isEnable: false,
                      height: FetchPixels.getPixelHeight(60),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          backToPrev();
          return false;
        });
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
      textColor: Colors.black,
    );
  }
}
