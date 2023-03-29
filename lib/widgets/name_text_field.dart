import 'package:flutter/material.dart';

import '../base/validation.dart';
import 'custom_text_field.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    Key? key,
    required this.controller,
    this.title = 'Title',
    this.hintText = 'Name',
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: hintText,
      controller: controller,
      validateFunction: Validations.validateString,
      textInputType: TextInputType.text,
      onChange: (String? newVal) {},
    );
  }
}

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    Key? key,
    required this.controller,
    this.title = 'Title',
    this.hintText = 'Name',
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
      textInputType: TextInputType.number,
    );
  }
}
