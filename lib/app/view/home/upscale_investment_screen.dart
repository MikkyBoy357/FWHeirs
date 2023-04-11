import 'package:flutter/material.dart';
import 'package:fwheirs/app/models/investment_model.dart';
import 'package:fwheirs/app/view_models/investment_providers/investment_provider.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:provider/provider.dart';

import '../../../base/resizer/fetch_pixels.dart';
import '../../../widgets/name_text_field.dart';

class UpscaleInvestmentScreen extends StatelessWidget {
  final InvestmentModel investment;
  const UpscaleInvestmentScreen({
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
            title: Text("Upscale Investment"),
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: investmentProvider.upscaleFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(20),
                  getMediumCustomFont(context, "Enter upscale amount"),
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
              label: "Upscale Investment",
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
