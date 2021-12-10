import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/admin_navigation.dart';
import 'package:kiloin/repository/admin_drawer_repository.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:provider/provider.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
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
          buildTile(
            context,
            item: AdminNavigation.dashboard,
            title: "Dashboard",
            image: Image.asset("assets/image/dashboardIcon.png"),
          ),
          buildTile(
            context,
            item: AdminNavigation.account,
            color: veryLightGray,
            title: "Akun",
            image: Image.asset("assets/image/akunIcon.png"),
          ),
          buildTile(
            context,
            item: AdminNavigation.trash,
            title: "Sampah",
            image: Image.asset("assets/image/sampahIcon.png"),
          ),
          buildTile(
            context,
            item: AdminNavigation.transaction,
            color: veryLightGray,
            title: "Transaksi",
            image: Image.asset("assets/image/transaksiIcon.png"),
          ),
          buildTile(
            context,
            item: AdminNavigation.reward,
            title: "Reward",
            image: Image.asset("assets/image/rewardIcon.png"),
          ),
          buildTile(
            context,
            item: AdminNavigation.rank,
            color: veryLightGray,
            title: "Rank",
            image: Image.asset("assets/image/rankIcon.png"),
          ),
        ],
      ),
    );
  }

  Widget buildTile(
    BuildContext context, {
    required AdminNavigation item,
    required String title,
    required Image image,
    Color color = whitePure,
  }) {
    final repository = Provider.of<AdminDrawerRepository>(context);
    final currentSelected = repository.adminNavigation;
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

  void selectTile(BuildContext context, AdminNavigation item) {
    final repository = Provider.of<AdminDrawerRepository>(
      context,
      listen: false,
    );

    repository.setAdminNavigation(item);
  }
}
