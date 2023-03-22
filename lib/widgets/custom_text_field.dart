import 'package:flutter/material.dart';
import 'package:fwheirs/base/color_data.dart';

import '../base/constant.dart';

class CustomTextField extends StatefulWidget {
  final double? width;
  final double height;
  final String hintText;
  final TextEditingController controller;
  final int minLines;
  final int maxLines;
  final bool obscureText;
  final bool enabled;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved, onChange;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final bool enableErrorMessage;
  final bool? streamText;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    this.width,
    this.height = 55,
    required this.hintText,
    required this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.enabled = true,
    required this.validateFunction,
    this.onSaved,
    this.onChange,
    this.textInputType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.enableErrorMessage = true,
    this.streamText,
    this.suffixIcon,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.maxLines != 1 ? 35 : widget.height,
          width: widget.width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400] ?? Colors.grey,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 10,
            ),
            child: Center(
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.disabled,
                      textCapitalization: TextCapitalization.sentences,
                      // initialValue: widget.initialValue,
                      enabled: widget.enabled,
                      onChanged: widget.onChange,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: Constant.fontsFamily,
                      ),
                      key: widget.key,
                      maxLines: widget.maxLines,
                      controller: widget.controller,
                      obscureText: widget.obscureText,
                      keyboardType: widget.textInputType,
                      validator: widget.validateFunction,
                      onSaved: (val) {
                        error = widget.validateFunction!(val)!;
                        setState(() {});
                        widget.onSaved!(val!);
                      },
                      textInputAction: widget.textInputAction,
                      focusNode: widget.focusNode,
                      // onFieldSubmitted: (String term) {
                      //   if (widget.nextFocusNode != null) {
                      //     widget.focusNode!.unfocus();
                      //     FocusScope.of(context)
                      //         .requestFocus(widget.nextFocusNode);
                      //   } else {
                      //     widget.submitAction!();
                      //   }
                      // },
                      decoration: InputDecoration(
                        suffixIcon: widget.suffixIcon,
                        // prefixIcon: Icon(
                        //   widget.prefix,
                        //   size: 15.0,
                        // ),
                        // suffixIcon: InkWell(
                        //   onTap: widget.locationAction,
                        //   child: Icon(
                        //     widget.suffix,
                        //     size: 15.0,
                        //   ),
                        // ),
                        // fillColor: Colors.white,
                        filled: false,
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontFamily: Constant.fontsFamily,
                        ),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        // border: border(context),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorStyle: const TextStyle(height: 0.0, fontSize: 0.0),
                      ),
                    ),
                    // Container(
                    //   color: Colors.blue,
                    //   height: 30,
                    //   width: 50,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // if (error != null)
        //   Container(
        //     height: 5.0,
        //   )
        // else
        //   Container(),
        // if (error != null)
        //   Text(
        //     error,
        //     style: TextStyle(
        //       color: Colors.red,
        //     ),
        //   )
        // else
        //   Container(),
      ],
    );
  }
}
