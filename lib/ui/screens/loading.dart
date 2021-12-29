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
  Future<dynamic>? signOut;

  Future<dynamic> signOutInit() async {
    await FirebaseUtils.signOut();
    return;
  }

  @override
  void initState() {
    signOutInit();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginScreen(),
            )));
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
