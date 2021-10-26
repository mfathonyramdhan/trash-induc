import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/color.dart';
import '../../../shared/font.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: darkGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10.sp,
            ),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.arrow_back_ios,
              ),
            ),
            Text(
              "Home",
              style: regularRobotoFont.copyWith(
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              width: 60.w,
            ),
            Center(
              child: Text(
                "Edit Profile",
                style: boldRobotoFont.copyWith(
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 29.h,
            ),
            CircleAvatar(
              radius: 50.r,
              backgroundColor: lightGreen,
              child: CircleAvatar(
                radius: 45.r,
                backgroundImage: AssetImage(
                  'assets/image/icon_profil.png',
                ),
              ),
            ),
            TextFormField()
          ],
        )),
      ),
    );
  }
}
