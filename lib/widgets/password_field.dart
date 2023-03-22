import 'package:flutter/material.dart';
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
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String title;

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
