import 'package:flutter/material.dart';
import 'package:fwheirs/app/models/investment_model.dart';
import 'package:fwheirs/app/view_models/investment_providers/investment_provider.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../widgets/name_text_field.dart';

class SubmitRevenueScreen extends StatelessWidget {
  final InvestmentModel investment;
  const SubmitRevenueScreen({
    Key? key,
    required this.investment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(investment.package);
    return Consumer<InvestmentProvider>(
      builder: (context, InvestmentProvider investmentProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Submit Revenue",
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
                onPressed: () {},
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
                  getMediumCustomFont(context, "Expected amount: ₦333"),
                  getMediumCustomFont(context, "Enter paid amount"),
                  getVerSpace(20),
                  NumberTextField(
                    hintText:
                        "${int.parse(investment.vestedAmount ?? "0") + 1} - ${investmentProvider.maxVest}",
                    controller: investmentProvider.upscaleAmountController,
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
              color: Colors.green,
              onTap: () {
                investmentProvider.upscaleInvestment(
                  context,
                  investment: investment,
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
