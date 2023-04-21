import 'package:flutter/material.dart';
import 'package:fwheirs/app/view/home/withdraw_screen.dart';
import 'package:fwheirs/app/view_models/referrals_providers.dart';
import 'package:fwheirs/widgets/name_text_field.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../widgets/dropdown_text_field.dart';

class WithdrawFormScreen extends StatefulWidget {
  const WithdrawFormScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawFormScreen> createState() => _WithdrawFormScreenState();
}

class _WithdrawFormScreenState extends State<WithdrawFormScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ReferralsProvider>(context, listen: false)
          .getPayoutAccounts(context);

      Provider.of<ReferralsProvider>(context, listen: false)
          .setPayoutAccountIds();
    });
  }

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
                  controller: referralsProvider.amountController,
                ),
                getVerSpace(20),
                PayoutAccountDropDownTextField(
                  title: "Select Payout Bank",
                  hasPrefixImage: false,
                  controller: referralsProvider.payoutIdController,
                  hintText: 'Select Package',
                  dropDownList: referralsProvider.payoutAccountIds,
                  onChanged: (newValue) {
                    setState(() {
                      // _armorcDues = newValue;
                      referralsProvider.payoutIdController.text =
                          newValue.toString();
                      print("newPackage => $newValue");
                      referralsProvider
                          .setSelectedPayoutAccount(newValue.toString());
                      print(
                          "SelectedPackage => ${referralsProvider.selectedPayoutAccount.id}");
                      // print(amorcDuesDropDown.indexOf(newValue));
                      // var index = amorcDuesDropDown.indexOf(newValue);
                      // payment.changeDuesAmount(index);
                      // payment.calculateTotal();
                    });
                  },
                  value: referralsProvider.payoutIdController.text.isNotEmpty
                      ? referralsProvider.payoutIdController.text
                      : referralsProvider.payoutAccounts[0].id,
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
              onTap: () {
                Provider.of<ReferralsProvider>(context, listen: false)
                    .makeWithdrawal(context);
              },
            ),
          ),
        );
      },
    );
  }
}
