import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Admin",
                  style: boldRobotoFont.copyWith(
                    fontSize: 20.sp,
                  ),
                ),
                Text(
                  "Trash Induc (v 1.0)",
                  style: regularRobotoFont.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: darkGreen,
            ),
          ),
          Ink(
            color: veryLightGreen,
            child: ListTile(
              onTap: () {},
              leading: Image.asset("assets/image/dashboardIcon.png"),
              title: Text(
                "Dashboard",
                style: mediumRobotoFont.copyWith(
                  fontSize: 16.sp,
                  color: darkGray,
                ),
              ),
            ),
          ),
          Ink(
            color: veryLightGray,
            child: ListTile(
              onTap: () {},
              leading: Image.asset("assets/image/akunIcon.png"),
              title: Text(
                "Akun",
                style: mediumRobotoFont.copyWith(
                  fontSize: 16.sp,
                  color: darkGray,
                ),
              ),
            ),
          ),
          Ink(
            color: whitePure,
            child: ListTile(
              onTap: () {},
              leading: Image.asset("assets/image/sampahIcon.png"),
              title: Text(
                "Sampah",
                style: mediumRobotoFont.copyWith(
                  fontSize: 16.sp,
                  color: darkGray,
                ),
              ),
            ),
          ),
          Ink(
            color: veryLightGray,
            child: ListTile(
              onTap: () {},
              leading: Image.asset("assets/image/transaksiIcon.png"),
              title: Text(
                "Transaksi",
                style: mediumRobotoFont.copyWith(
                  fontSize: 16.sp,
                  color: darkGray,
                ),
              ),
            ),
          ),
          Ink(
            color: whitePure,
            child: ListTile(
              onTap: () {},
              leading: Image.asset("assets/image/rewardIcon.png"),
              title: Text(
                "Reward",
                style: mediumRobotoFont.copyWith(
                  fontSize: 16.sp,
                  color: darkGray,
                ),
              ),
            ),
          ),
          Ink(
            color: veryLightGray,
            child: ListTile(
              onTap: () {},
              leading: Image.asset("assets/image/rankIcon.png"),
              title: Text(
                "Rank",
                style: mediumRobotoFont.copyWith(
                  fontSize: 16.sp,
                  color: darkGray,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
