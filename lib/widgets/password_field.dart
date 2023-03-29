import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../base/constant.dart';
import '../base/validation.dart';
import 'custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.controller,
    this.hintText = 'Password',
    this.title = 'Password',
    this.textInputType = TextInputType.number,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String title;
  final TextInputType textInputType;
  final void Function(String)? onChanged;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTextField(
          hintText: widget.hintText,
          controller: widget.controller,
          obscureText: isObscure,
          enabled: true,
          validateFunction: Validations.validatePassword,
          textInputType: widget.textInputType,
          onChange: widget.onChanged,
          textInputFormatters: [
            LengthLimitingTextInputFormatter(
              6,
            ), //6 is maximum number of characters you want in textfield
          ],
        ),
        Positioned(
          right: 15,
          top: 15,
          child: GestureDetector(
            onTap: () {
              isObscure = !isObscure;
              setState(() {});
            },
            child: SvgPicture.asset(
              Constant.assetImagePath + "eye.svg",
              // color: color,
              // width: width,
              // height: height,
              // fit: boxFit,
            ),
          ),
        ),
      ],
    );
  }
}
