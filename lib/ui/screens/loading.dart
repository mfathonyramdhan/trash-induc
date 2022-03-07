import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/ui/screens/auth/login_screen.dart';
import 'package:kiloin/utils/firebase_utils.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);
  static String routeName = "/logout";

  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  Future signOutInit() async {
    await FirebaseUtils.signOut().then(
        (value) => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LoginScreen(),
            )));
  }

  @override
  void initState() {
    signOutInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreen,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: whitePure,
            ),
            Text(
              "Mohon tunggu",
              style: regularRobotoFont.copyWith(
                fontSize: 18.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
