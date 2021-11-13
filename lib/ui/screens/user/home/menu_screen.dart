import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/firebase/firebase_utils.dart';
import 'package:kiloin/models/user.dart' as UserModel;
import 'package:kiloin/shared/color.dart';

import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/screens/user/reedem/reedem_screen.dart';
import 'package:kiloin/ui/screens/wrapper.dart';
import 'package:kiloin/ui/widgets/menu_screen_card.dart';
import 'package:kiloin/ui/widgets/menu_screen_list_tile.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class MenuScreen extends StatefulWidget {
  static String routeName = "/menu_screen";

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isChecked = false;

  var currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

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
              TextButton.icon(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: darkGreen,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: Text(
                  "Home",
                  style: regularRobotoFont.copyWith(
                    fontSize: 14.sp,
                    color: darkGreen,
                  ),
                ),
              ),
              SizedBox(
                width: 70.w,
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
        body: Center(
          child: FutureBuilder(
            future: userRef.doc(currentUserId).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                UserModel.User user = UserModel.User.fromJson(
                    snapshot.data!.data() as Map<String, dynamic>);
                return ListView(
                  padding: EdgeInsets.only(
                    top: 10.h,
                    left: 20.w,
                    right: 20.w,
                    bottom: 30.h,
                  ),
                  children: [
                    // PROFILE SECTION
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
                                child: Text(
                                    (user.name == "-") ? "User" : user.name!,
                                    overflow: TextOverflow.ellipsis,
                                    style: boldRobotoFont.copyWith(
                                      fontSize: 20.sp,
                                    )),
                              ),
                              Text(
                                (user.phone == "-")
                                    ? "Nomor telp belum diisi"
                                    : user.phone!,
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
                          if (user.membership == "bronze")
                            Chip(
                              label: Text(
                                "Bronze",
                                style: mediumRobotoFont.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              backgroundColor: Color(
                                0xffCD7F32,
                              ),
                            ),
                          if (user.membership == "silver")
                            Chip(
                              label: Text(
                                "Silver",
                                style: mediumRobotoFont.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              backgroundColor: Color(
                                0xffD3D3D3,
                              ),
                            ),
                          if (user.membership == "gold")
                            Chip(
                              label: Text(
                                "Gold",
                                style: mediumRobotoFont.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              backgroundColor: Color(
                                0xffFFD700,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    // 2 CARD SECTION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // EXP CARD
                        MenuScreenCard(
                          assetPath: "assets/image/medal_backdrop.png",
                          type: "Experience",
                          point: user.expPoint!,
                        ),
                        // BALANCE CARD
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
                                              user.balancePoint!.toString(),
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
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (_) => ReedemScreen(),
                                    ));
                                  },
                                  child: Container(
                                    width: 78.w,
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                    SizedBox(
                      height: 19.h,
                    ),
                    // MISSION SECTION
                    Text(
                      "Daftar Misi",
                      style: boldRobotoFont.copyWith(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
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
                          buildMission(
                            "Mengentot sampah masyarakat",
                          ),
                          buildMission(
                            "Mengentok",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    // CARD LIST TILE SECTION
                    InkWell(
                      onTap: () {},
                      child: CustomMenuScreenListTile(
                        imageLeading: "assets/image/problem.png",
                        title: "Ulasan dan Saran",
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: CustomMenuScreenListTile(
                        imageLeading: "assets/image/call.png",
                        title: "Tentang Kami",
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: CustomMenuScreenListTile(
                        imageLeading: "assets/image/sent.png",
                        title: "Bantuan",
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await FirebaseUtils.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Wrapper.routeName,
                          (route) => false,
                        );
                      },
                      child: CustomMenuScreenListTile(
                        imageLeading: "assets/image/exit.png",
                        title: "Keluar",
                        backgroundColor: redDanger,
                      ),
                    )
                  ],
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return CircularProgressIndicator(
                color: darkGreen,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildMission(String task) {
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
                  task,
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
                  buildChip(
                    "Balance",
                    "100",
                  ),
                  buildChip(
                    "Experience",
                    "200",
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildChip(String type, String value) {
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
            type,
            style: regularRobotoFont.copyWith(
              fontSize: 10.sp,
              color: lightGreen,
            ),
          ),
          Text(
            "+" + value,
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
