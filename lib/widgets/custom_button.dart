import 'package:flutter/material.dart';
import 'package:fwheirs/base/color_data.dart';
import 'package:fwheirs/base/constant.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isActive;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? (isActive ? redColor : Colors.grey[600])
                : (isActive ? redColor : Colors.grey[600]),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: Constant.fontsFamily,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
