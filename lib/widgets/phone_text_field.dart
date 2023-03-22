import 'package:flutter/material.dart';

import '../base/constant.dart';
import '../base/validation.dart';
import 'custom_text_field_with_prefix.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    Key? key,
    required this.controller,
    this.title = 'Phone',
    this.hintText = 'Type here',
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWithPrefix(
      hintText: hintText,
      controller: controller,
      validateFunction: Validations.validateNumber,
      textInputType: TextInputType.text,
      prefixWidget: Row(
        children: const [
          // Image.asset(
          //   Constant.assetImagePath + image,
          //   color: color,
          //   width: width,
          //   height: height,
          //   fit: boxFit,
          //   scale: FetchPixels.getScale(),
          // ),
          Text(
            "🇳🇬 ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 25,
              fontFamily: Constant.fontsFamily,
            ),
          ),
          Text(
            "+234",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: Constant.fontsFamily,
            ),
          ),
        ],
      ),
    );
  }
}
