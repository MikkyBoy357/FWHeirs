import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fwheirs/app/view_models/auth_providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../base/validation.dart';
import 'custom_text_field_with_prefix.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    Key? key,
    required this.controller,
    this.title = 'Phone',
    this.hintText = 'Type here',
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWithPrefix(
      hintText: hintText,
      controller: controller,
      validateFunction: Validations.validateNumber,
      textInputType: TextInputType.text,
      onChange: onChanged,
      prefixWidget: CountryCodePicker(
        dialogBackgroundColor: Theme.of(context).secondaryHeaderColor,
        onChanged: (CountryCode val) {
          print("NewValue => ${val.dialCode}");
          Provider.of<AuthProvider>(context)
              .changeCountryCode(val.dialCode ?? "+234");
        },
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: 'NG',
        favorite: ['NG'],
        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
      ),
      // prefixWidget: Row(
      //   children: [
      //     // Image.asset(
      //     //   Constant.assetImagePath + image,
      //     //   color: color,
      //     //   width: width,
      //     //   height: height,
      //     //   fit: boxFit,
      //     //   scale: FetchPixels.getScale(),
      //     // ),
      //     Text(
      //       "🇳🇬 ",
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontWeight: FontWeight.w400,
      //         fontSize: 25,
      //         fontFamily: Constant.fontsFamily,
      //       ),
      //     ),
      //     Text(
      //       "+234",
      //       style: TextStyle(
      //         color: Theme.of(context).textTheme.bodyMedium!.color!,
      //         fontWeight: FontWeight.w400,
      //         fontSize: 16,
      //         fontFamily: Constant.fontsFamily,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
