import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/widgets/officer_drawer.dart';

class OfficerDashboardScreen extends StatefulWidget {
  const OfficerDashboardScreen({Key? key}) : super(key: key);

  @override
  OfficerDashboardScreenState createState() => OfficerDashboardScreenState();
}

class OfficerDashboardScreenState extends State<OfficerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OfficerDrawer(),
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
          "Dashboard",
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
