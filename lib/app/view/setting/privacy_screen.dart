import 'package:flutter/material.dart';
import 'package:fwheirs/base/constant.dart';
import 'package:fwheirs/base/resizer/fetch_pixels.dart';
import 'package:fwheirs/base/widget_utils.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  void backToPrev() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.white,
          body: SafeArea(
            child: getPaddingWidget(
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
              Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(14)),
                  gettoolbarMenu(
                    context,
                    "back.svg",
                    () {
                      backToPrev();
                    },
                    istext: true,
                    title: "Terms & Privacy",
                    fontsize: 24,
                    weight: FontWeight.w700,
                    textColor: Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(39)),
                  Expanded(
                      flex: 1,
                      child: ListView(
                        primary: true,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          getMediumCustomFont(
                            context,
                            "Sed ligula est, aliquet non lobortis sit amet, consequat vel diam. Nunc nec nisl ullamcorper, varius orci at, sollicitudin est. Vestibulum eget tempor arcu. Proin non hendrerit augue, nec rutrum urna. Donec ut volutpat diam. Donec ultricies fermentum arcu, vel fringilla diam finibus non. Donec gravida mauris a porttitor bibendum.Cras dapibus non orci sit amet varius. Donec sapien felis, pretium non aliquet at, ultrices eget lacus. Sed semper pellentesque turpis at dapibus. Nunc elementum ipsum nibh, quis consequat felis faucibus mollis. Curabitur odio orci, tincidunt quis aliquam id, semper nec mauris. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nullam vel libero vehicula, convallis augue sagittis, pellentesque lorem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ))
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
}
