import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';

class PetugasDrawer extends StatefulWidget {
  const PetugasDrawer({Key? key}) : super(key: key);

  @override
  PetugasDrawerState createState() => PetugasDrawerState();
}

class PetugasDrawerState extends State<PetugasDrawer> {
  int selectedIndex = -1;

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: darkGreen,
      child: Row(
        children: [
          isExpanded ? iconTile() : menuTile(),
          invisibleSubMenus(),
        ],
      ),
    );
  }

  Widget iconTile() {
    return Container(
      width: 200.w,
      color: darkGreen,
      child: Column(
        children: [
          controlTile(),
          accountTile(),
        ],
      ),
    );
  }

  Widget controlTile() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: InkWell(
        onTap: expandOrShrink,
      ),
    );
  }

  Widget accountTile() {
    return Container(
      color: lightGreen,
      child: ListTile(),
    );
  }

  Widget menuTile() {
    return AnimatedContainer(
      duration: Duration(
        seconds: 1,
      ),
      width: 100.w,
      color: darkGreen,
      child: Column(
        children: [],
      ),
    );
  }

  Widget invisibleSubMenus() {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 700,
      ),
      width: isExpanded ? 0.w : 125.w,
      color: darkGreen,
      child: Column(
        children: [
          Container(
            height: 95.h,
          ),
          // Expanded(child: child)
        ],
      ),
    );
  }

  void expandOrShrink() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
