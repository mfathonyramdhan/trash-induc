import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kiloin/shared/font.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import '../../../shared/color.dart';

class MenuScreen extends StatefulWidget {
  static String routeName = "/menu_screen";

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF527D46),
            Color(0xFF7EB044),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: whitePure,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10.sp,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: darkGreen,
                ),
              ),
              Text(
                "Home",
                style: regularRobotoFont.copyWith(
                    fontSize: 14.sp, color: darkGreen),
              ),
              SizedBox(
                width: 80.w,
              ),
              Center(
                child: Text(
                  "Menu",
                  style: boldRobotoFont.copyWith(
                    fontSize: 18.sp,
                    color: darkGreen,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: EdgeInsets.only(
            top: 10.h,
            left: 20.w,
            right: 20.w,
            bottom: 30.h,
          ),
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 37,
                    backgroundImage: AssetImage(
                      "assets/image/photo.png",
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: Text("Charles Holmes",
                            overflow: TextOverflow.ellipsis,
                            style: boldRobotoFont.copyWith(
                              fontSize: 20.sp,
                            )),
                      ),
                      Text(
                        "+6280000000000",
                        style: regularRobotoFont.copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "*profil perlu dilengkapi",
                        style: regularRobotoFont.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                          fontSize: 10.sp,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "N2013567",
                        style: regularRobotoFont.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Chip(
                        label: Text(
                          "Gold",
                          style: mediumRobotoFont.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        backgroundColor: Colors.amber,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 82.h,
                  color: Colors.transparent,
                  child: Stack(children: [
                    Container(
                      width: 156.w,
                      height: 72.h,
                      decoration: BoxDecoration(
                          color: whitePure,
                          borderRadius: BorderRadius.circular(
                            15.r,
                          )),
                      child: Stack(
                        children: [
                          Image(
                              image: AssetImage(
                            "assets/image/medal_backdrop.png",
                          )),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 17.h,
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Your Experience",
                                    style: regularRobotoFont.copyWith(
                                      fontSize: 9.sp,
                                      color: darkGreen,
                                    ),
                                  ),
                                  Text(
                                    500.toString(),
                                    style: boldRobotoFont.copyWith(
                                      fontSize: 30.sp,
                                      color: darkGreen,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                Container(
                  height: 82.h,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        width: 156.w,
                        height: 72.h,
                        decoration: BoxDecoration(
                            color: whitePure,
                            borderRadius: BorderRadius.circular(
                              15.r,
                            )),
                        child: Stack(
                          children: [
                            Image(
                                image: AssetImage(
                              "assets/image/dollar_backdrop.png",
                            )),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 17.h,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Your Balance",
                                      style: regularRobotoFont.copyWith(
                                        fontSize: 9.sp,
                                        color: darkGreen,
                                      ),
                                    ),
                                    Text(
                                      1260.toString(),
                                      style: boldRobotoFont.copyWith(
                                        fontSize: 30,
                                        color: darkGreen,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 8,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: 78.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "TUKAR POIN",
                                  style: regularRobotoFont.copyWith(
                                    fontSize: 9.sp,
                                    color: darkGreen,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: darkGreen,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Text(
              "Daftar Misi",
              style: boldRobotoFont.copyWith(
                fontSize: 18.sp,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              height: 202.h,
              decoration: BoxDecoration(
                  color: whitePure,
                  borderRadius: BorderRadius.circular(
                    10.r,
                  )),
              child: ListView(
                children: [
                  buildMission(),
                  buildMission(),
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5.w,
              ),
              height: 45.w,
              decoration: BoxDecoration(
                  color: whitePure,
                  borderRadius: BorderRadius.circular(
                    10.r,
                  )),
              child: ListTile(
                dense: true,
                leading: Image(
                  image: AssetImage(
                    "assets/image/problem.png",
                  ),
                ),
                title: Text(
                  "Ulasan dan Saran",
                  style: boldRobotoFont.copyWith(
                    fontSize: 16.sp,
                    color: blackPure,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: blackPure,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5.w,
              ),
              height: 45.w,
              decoration: BoxDecoration(
                  color: whitePure,
                  borderRadius: BorderRadius.circular(
                    10.r,
                  )),
              child: ListTile(
                dense: true,
                leading: Image(
                  image: AssetImage(
                    "assets/image/problem.png",
                  ),
                ),
                title: Text(
                  "Ulasan dan Saran",
                  style: boldRobotoFont.copyWith(
                    fontSize: 16.sp,
                    color: blackPure,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: blackPure,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5.w,
              ),
              height: 45.w,
              decoration: BoxDecoration(
                  color: whitePure,
                  borderRadius: BorderRadius.circular(
                    10.r,
                  )),
              child: ListTile(
                dense: true,
                leading: Image(
                  image: AssetImage(
                    "assets/image/problem.png",
                  ),
                ),
                title: Text(
                  "Ulasan dan Saran",
                  style: boldRobotoFont.copyWith(
                    fontSize: 16.sp,
                    color: blackPure,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: blackPure,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5.w,
              ),
              height: 45.w,
              decoration: BoxDecoration(
                  color: whitePure,
                  borderRadius: BorderRadius.circular(
                    10.r,
                  )),
              child: ListTile(
                dense: true,
                leading: Image(
                  image: AssetImage(
                    "assets/image/problem.png",
                  ),
                ),
                title: Text(
                  "Ulasan dan Saran",
                  style: boldRobotoFont.copyWith(
                    fontSize: 16.sp,
                    color: blackPure,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: blackPure,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMission() {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.w,
      ),
      child: Row(
        children: [
          RoundCheckBox(
            size: 25,
            border: Border.all(
              color: lightGreen,
            ),
            checkedColor: lightGreen,
            onTap: (selected) {},
          ),
          SizedBox(
            width: 5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 0.72.sw,
                child: Text(
                  "Mengumpulkan sampah sebanyak 8888888kg",
                  maxLines: 2,
                  style: mediumRobotoFont.copyWith(
                    fontSize: 10.sp,
                    color: blackPure,
                  ),
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              Row(
                children: [
                  buildChip(),
                  buildChip(),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildChip() {
    return Container(
      margin: EdgeInsets.only(
        right: 10.w,
      ),
      width: 87.w,
      height: 15.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: lightGreen,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
            15.r,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Balance",
            style: regularRobotoFont.copyWith(
              fontSize: 10.sp,
              color: lightGreen,
            ),
          ),
          Text(
            "+100",
            style: boldRobotoFont.copyWith(
              fontSize: 10.sp,
              color: lightGreen,
            ),
          )
        ],
      ),
    );
  }
}
