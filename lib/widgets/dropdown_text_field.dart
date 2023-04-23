import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fwheirs/app/models/payout_account_model.dart';
import 'package:fwheirs/app/view_models/referrals_providers.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/widget_utils.dart';
import 'package:provider/provider.dart';

import '../app/view_models/investment_providers/investment_provider.dart';

class DropDownTextField extends StatelessWidget {
  final List dropDownList;
  final double? width;
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? prefixImage;
  final bool hasPrefixImage;
  final Function(Object?)? onChanged;
  final value;
  final VoidCallback? onPressed;

  const DropDownTextField({
    Key? key,
    required this.dropDownList,
    this.width,
    this.title = 'DropDown',
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.obscureText = false,
    this.value,
    this.prefixImage,
    this.onPressed,
    required this.hasPrefixImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color!,
          ),
        ),
        Container(
          height: 5,
        ),
        Card(
          // elevation: 4.0,
          child: Container(
            height: 55,
            width: width ?? MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Center(
                child: DropdownButton(
                  icon: IconButton(
                    icon: Icon(
                      CupertinoIcons.chevron_down,
                      size: 20,
                    ),
                    onPressed: onPressed,
                  ),
                  hint: Text(hintText),
                  style: TextStyle(
                    color: Colors.grey,
                  ), // Not necessary for Option 1
                  value: value,
                  isExpanded: true,
                  onChanged: onChanged,
                  underline: Container(
                    height: 10,
                  ),
                  items: dropDownList.map((location) {
                    // print(location.toString());
                    return DropdownMenuItem(
                      value: location,
                      child: Row(
                        children: [
                          Builder(
                            builder: (context) {
                              if (hasPrefixImage) {
                                String? prefixImage =
                                    Provider.of<InvestmentProvider>(context)
                                        .getBrokerLogo(location)
                                        .toString();
                                print(prefixImage);
                                return Container(
                                  width: 50,
                                  height: 30,
                                  // color: Colors.white,
                                  child: Image.network(prefixImage),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                          Visibility(
                            visible: hasPrefixImage,
                            child: getHorSpace(10),
                          ),
                          Expanded(
                            child: Text(
                              location.toString(),
                              style: TextStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PayoutAccountDropDownTextField extends StatelessWidget {
  final List dropDownList;
  final double? width;
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? prefixImage;
  final bool hasPrefixImage;
  final Function(Object?)? onChanged;
  final value;
  final VoidCallback? onPressed;

  const PayoutAccountDropDownTextField({
    Key? key,
    required this.dropDownList,
    this.width,
    this.title = 'DropDown',
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.obscureText = false,
    this.value,
    this.prefixImage,
    required this.hasPrefixImage,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color!,
          ),
        ),
        Container(
          height: 5,
        ),
        Card(
          // elevation: 4.0,
          child: Container(
            height: 75,
            width: width ?? MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Center(
                child: DropdownButton(
                  icon: IconButton(
                    icon: Icon(
                      CupertinoIcons.chevron_down,
                      size: 20,
                    ),
                    onPressed: onPressed,
                  ),
                  hint: Text(hintText),
                  style: TextStyle(
                    color: Colors.grey,
                  ), // Not necessary for Option 1
                  value: value,
                  isExpanded: true,
                  onChanged: onChanged,
                  underline: Container(
                    height: 10,
                  ),
                  items: dropDownList.map((location) {
                    // print(location.toString());
                    PayoutAccountModel payoutAccount =
                        Provider.of<ReferralsProvider>(context)
                            .getPayoutAccountFromId(location);
                    return DropdownMenuItem(
                      value: location,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            child: Text(location),
                          ),
                          getHorSpace(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  payoutAccount.accountName.toString(),
                                  style: TextStyle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  payoutAccount.accountName.toString(),
                                  style: TextStyle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width / 2,
                                color: textColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
