import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/officer_navigation.dart';
import 'package:kiloin/repository/officer_drawer_repository.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:provider/provider.dart';

class OfficerDrawer extends StatefulWidget {
  const OfficerDrawer({Key? key}) : super(key: key);

  @override
  _OfficerDrawerState createState() => _OfficerDrawerState();
}

class _OfficerDrawerState extends State<OfficerDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: darkGreen,
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Petugas",
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
          buildTile(
            context,
            item: OfficerNavigation.dashboard,
            title: "Dashboard",
            image: Image.asset("assets/image/dashboardIcon.png"),
          ),
          buildTile(
            context,
            item: OfficerNavigation.transaction,
            color: veryLightGray,
            title: "Transaksi",
            image: Image.asset("assets/image/transaksiIcon.png"),
          ),
          buildTile(
            context,
            item: OfficerNavigation.reward,
            title: "Reward",
            image: Image.asset("assets/image/rewardIcon.png"),
          ),
          buildTile(context,
              item: OfficerNavigation.logout,
              title: "Keluar",
              image: Image.asset(
                "assets/image/exit.png",
                color: redDanger,
              ))
        ],
      ),
    );
  }

  Widget buildTile(
    BuildContext context, {
    required OfficerNavigation item,
    required String title,
    required Image image,
    Color color = whitePure,
  }) {
    final repository = Provider.of<OfficerDrawerRepository>(context);
    final currentSelected = repository.officerNavigation;
    final isSelected = item == currentSelected;

    return Ink(
      color: color,
      child: ListTile(
        onTap: () => selectTile(context, item),
        selected: isSelected,
        selectedTileColor: lightGreen,
        leading: image,
        title: Text(
          title,
          style: mediumRobotoFont.copyWith(
            fontSize: 16.sp,
            color: darkGray,
          ),
        ),
      ),
    );
  }

  void selectTile(BuildContext context, OfficerNavigation item) {
    final repository = Provider.of<OfficerDrawerRepository>(
      context,
      listen: false,
    );

    repository.setOfficerNavigation(item);
  }
}
