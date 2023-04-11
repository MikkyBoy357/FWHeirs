import 'package:flutter/material.dart';
import 'package:fwheirs/app/view/home/withdraw_screen.dart';
import 'package:fwheirs/app/view_models/referrals_providers.dart';
import 'package:fwheirs/widgets/name_text_field.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';

class WithdrawFormScreen extends StatelessWidget {
  const WithdrawFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReferralsProvider>(
      builder: (context, referralsProvider, _) {
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
              "Withdraw",
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
            //       color: redColor,
            //     ),
            //   ),
            // ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                NumberTextField(
                  hintText: "Amount",
                  controller: TextEditingController(),
                ),
                getVerSpace(20),
                NumberTextField(
                  hintText: "Payout id",
                  controller: TextEditingController(),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: TerminateAccountButton(
              context: context,
              label: "Make Withdrawal",
              color: Colors.green,
              onTap: () {},
            ),
          ),
        );
      },
    );
  }
}
