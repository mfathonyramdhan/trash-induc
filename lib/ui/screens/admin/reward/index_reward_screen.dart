import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/widgets/admin_drawer.dart';

class AdminIndexRewardScreen extends StatefulWidget {
  const AdminIndexRewardScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_index_reward";

  @override
  _AdminIndexRewardScreenState createState() => _AdminIndexRewardScreenState();
}

class _AdminIndexRewardScreenState extends State<AdminIndexRewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        backgroundColor: darkGreen,
        leading: Builder(
          builder: (context) {
            return IconButton(
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              icon: Image.asset(
                "assets/image/buttonSidebar.png",
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        title: Text(
          "Reward",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset("assets/image/buttonCreate.png"),
          )
        ],
      ),
    );
  }
}
