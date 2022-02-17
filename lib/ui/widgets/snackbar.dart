import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static buildSnackbar(BuildContext context, String message, Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(
        seconds: 2,
      ),
      action: SnackBarAction(
        label: "Dismiss",
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }
}
