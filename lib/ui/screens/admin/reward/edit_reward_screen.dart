import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

class AdminEditRewardScreen extends StatefulWidget {
  const AdminEditRewardScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_edit_reward";

  @override
  _AdminEditRewardScreenState createState() => _AdminEditRewardScreenState();
}

class _AdminEditRewardScreenState extends State<AdminEditRewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Edit reward",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
