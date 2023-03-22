import 'package:flutter/material.dart';

import '../base/validation.dart';
import 'custom_text_field.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    Key? key,
    required this.controller,
    this.title = 'Title',
    this.hintText = 'Type here',
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: hintText,
      controller: controller,
      validateFunction: Validations.validateString,
      textInputType: TextInputType.text,
    );
  }
}
