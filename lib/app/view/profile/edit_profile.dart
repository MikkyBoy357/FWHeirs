import 'package:flutter/material.dart';
import 'package:fwheirs/app/view_models/profile_providers/profile_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:fwheirs/widgets/email_text_field.dart';
import 'package:fwheirs/widgets/name_text_field.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  var horSpace = FetchPixels.getPixelHeight(20);

  Future<void> getData() async {
    // firstNameController.text = await PrefData.getFirstName();
    // lastNameController.text = await PrefData.getLastName();
    // emailController.text = await PrefData.getEmail();
    // phoneNoController.text = await PrefData.getPhoneNo();
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
    return WillPopScope(child: Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
                horizontal: horSpace, vertical: FetchPixels.getPixelHeight(30)),
            child: getButton(context, redColor, "Save", Colors.white, () {
              profileProvider.editProfileInfo(context);
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
                  getVerSpace(FetchPixels.getPixelHeight(29)),
                  profileImageWidget(),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  NameTextField(
                    hintText: "First Name",
                    controller: profileProvider.firstNameController,
                  ),
                  getVerSpace(horSpace),
                  NameTextField(
                    hintText: "Last Name",
                    controller: profileProvider.lastNameController,
                  ),
                  getVerSpace(horSpace),
                  EmailTextField(
                    hintText: "Email",
                    controller: profileProvider.emailController,
                  ),
                  getVerSpace(horSpace),
                  NameTextField(
                    hintText: "Phone No.",
                    controller: profileProvider.firstNameController,
                  ),
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
      title: "Edit Profile",
      fontsize: 24,
      weight: FontWeight.w700,
      textColor: Colors.black,
    );
  }
}
