import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String text;

  const ErrorDialog({Key? key, this.text = "Invalid request"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text(text),
      actions: [
        ElevatedButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String text;
  final String buttonLabel;
  final VoidCallback? onTap;

  const SuccessDialog({
    Key? key,
    this.text = "Request was successful",
    this.buttonLabel = "Done",
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Success"),
      content: Text(text),
      actions: [
        ElevatedButton(
          child: Text(buttonLabel),
          onPressed: onTap,
        ),
      ],
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  final String text;
  final String yesLabel;
  final String noLabel;
  final VoidCallback? onYes;

  const ConfirmDialog({
    Key? key,
    this.text = "Do you want to continue?",
    this.yesLabel = "Yes",
    this.noLabel = "No",
    this.onYes,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Success"),
      content: Text(text),
      actions: [
        TextButton(
          child: Text(
            noLabel,
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
        TextButton(
          onPressed: onYes,
          child: Text(
            yesLabel,
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }
}
