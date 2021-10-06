import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../shared/color.dart';

Future<dynamic> showValidationBar(BuildContext context, {String message = "", Color color = redDanger}) {
  return Flushbar(
    duration: Duration(seconds: 4),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: color,
    message: message,
  ).show(context);
}