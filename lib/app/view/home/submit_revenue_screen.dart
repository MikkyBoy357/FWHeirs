import 'package:flutter/material.dart';
import 'package:fwheirs/app/models/investment_model.dart';
import 'package:fwheirs/app/view/home/revenue_transactions_screen.dart';
import 'package:fwheirs/app/view_models/investment_providers/investment_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../widgets/name_text_field.dart';

class SubmitRevenueScreen extends StatefulWidget {
  final InvestmentModel investment;
  const SubmitRevenueScreen({
    Key? key,
    required this.investment,
  }) : super(key: key);

  @override
  State<SubmitRevenueScreen> createState() => _SubmitRevenueScreenState();
}

class _SubmitRevenueScreenState extends State<SubmitRevenueScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<InvestmentProvider>(context, listen: false)
          .getDueRevenue(context, id: widget.investment.id ?? "");
      Provider.of<InvestmentProvider>(context, listen: false).initPaidAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.investment.package);
    return Consumer<InvestmentProvider>(
      builder: (context, InvestmentProvider investmentProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Pay Subscription",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            elevation: 0,
            leading: getPaddingWidget(
              EdgeInsets.symmetric(vertical: FetchPixels.getPixelHeight(18)),
              GestureDetector(
                child: getSvgImage("back.svg"),
                onTap: () {
                  Constant.backToPrev(context);
                },
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Constant.navigatePush(context, RevenueTransactionsScreen());
                },
                icon: Icon(
                  Icons.info_outline,
                  color: redColor,
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: investmentProvider.upscaleFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(20),
                  getMediumCustomFont(context,
                      "Expected amount: ₦${investmentProvider.dueRevenues.isNotEmpty ? (investmentProvider.dueRevenues[0].dueRevenue ?? 0) : 0}"),
                  getMediumCustomFont(context, "Enter paid amount"),
                  getVerSpace(20),
                  NumberTextField(
                    hintText: "Paid Amount",
                    // hintText:
                    //     "${int.parse(widget.investment.vestedAmount ?? "0") + 1} - ${investmentProvider.maxVest}",
                    controller: investmentProvider.paidAmountController,
                    onChanged: (val) {
                      investmentProvider.changeNotifiers();
                    },
                  ),
                  getVerSpace(20),
                  GestureDetector(
                    onTap: () {
                      investmentProvider.pickImage();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: getMediumCustomFont(context, "Upload Proof Image"),
                    ),
                  ),
                  getVerSpace(20),
                  Builder(
                    builder: (context) {
                      print(investmentProvider.imageFile);
                      if (investmentProvider.imageFile != null) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: blueColor,
                            image: DecorationImage(
                              image: FileImage(investmentProvider.imageFile!),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: terminateAccountButton(
              context,
              label: "Submit",
              color:
                  ((investmentProvider.paidAmountController.text.length < 4) &&
                          investmentProvider.imageFile != null)
                      ? Colors.grey
                      : Colors.green,
              onTap: () {
                investmentProvider.submitRevenue(
                  context,
                  investment: widget.investment,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

Widget terminateAccountButton(BuildContext context,
    {String? label, Color? color, VoidCallback? onTap}) {
  return getButton(context, Theme.of(context).secondaryHeaderColor,
      label ?? "Terminate Investment", color ?? Colors.red, onTap, 16,
      weight: FontWeight.w600,
      borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
      buttonHeight: FetchPixels.getPixelHeight(60),
      isBorder: true,
      borderColor: color ?? Colors.red,
      borderWidth: FetchPixels.getPixelHeight(2));
}
