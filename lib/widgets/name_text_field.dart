import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../base/validation.dart';
import 'custom_text_field.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    Key? key,
    this.enabled = true,
    required this.controller,
    this.title = 'Title',
    this.hintText = 'Name',
    this.onChanged,
    this.isOptional = false,
  }) : super(key: key);

  final bool enabled;
  final bool isOptional;
  final TextEditingController controller;
  final String title;
  final String hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      enabled: enabled,
      hintText: hintText,
      controller: controller,
      validateFunction: isOptional ? null : Validations.validateString,
      textInputType: TextInputType.text,
      onChange: (String? newVal) {},
    );
  }
}

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    Key? key,
    this.isAmountField = false,
    required this.controller,
    this.title = 'Title',
    this.hintText = 'Number',
    this.maxLength = 20,
    this.onChanged,
  }) : super(key: key);

  final bool isAmountField;
  final TextEditingController controller;
  final String title;
  final String hintText;
  final int maxLength;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: hintText,
      controller: controller,
      validateFunction: Validations.validateNumber,
      textInputType:
          TextInputType.numberWithOptions(decimal: false, signed: false),
      textInputFormatters: [
        isAmountField
            ? NumericTextFormatter()
            : LengthLimitingTextInputFormatter(maxLength),
        FilteringTextInputFormatter(new RegExp('[ -,.-]'), allow: false),
        LengthLimitingTextInputFormatter(20),
      ],
      onChange: onChanged,
    );
  }
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      var value = newValue.text;
      if (newValue.text.length > 2) {
        value = value.replaceAll(RegExp(r'\D'), '');
        value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
        print("Value ---- $value");
      }
      return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(
            offset: value.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
