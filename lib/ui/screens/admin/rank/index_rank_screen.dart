import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/widgets/admin_drawer.dart';

class AdminIndexRankScreen extends StatefulWidget {
  const AdminIndexRankScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_index_rank";

  @override
  _AdminIndexRankScreenState createState() => _AdminIndexRankScreenState();
}

class _AdminIndexRankScreenState extends State<AdminIndexRankScreen> {
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
          "Rank",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
    );
  }
}
