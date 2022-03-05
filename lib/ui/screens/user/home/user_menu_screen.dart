import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../models/user.dart' as UserModel;
import '../../../../models/mission.dart';
import '../../../../shared/color.dart';
import '../../../../shared/font.dart';
import '../../../../utils/firebase_utils.dart';
import '../../../widgets/menu_screen_card.dart';
import '../../../widgets/menu_screen_list_tile.dart';
import '../reedem/user_redeem_screen.dart';
import '../../wrapper.dart';

class UserMenuScreen extends StatefulWidget {
  static String routeName = "/menu_screen";

  @override
  _UserMenuScreenState createState() => _UserMenuScreenState();
}

class _UserMenuScreenState extends State<UserMenuScreen> {
  bool isChecked = false;

  var currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  CollectionReference missionRef =
      FirebaseFirestore.instance.collection("missions");

  CollectionReference userCompletedMissionRef =
      FirebaseFirestore.instance.collection('user_completed_missions');

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
        body: ListView(
          padding: EdgeInsets.only(
            top: 10.h,
            left: 20.w,
            right: 20.w,
            bottom: 30.h,
          ),
          children: [
            Center(
              child: StreamBuilder(
                stream: userRef.doc(currentUserId).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    UserModel.User user = UserModel.User.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>,
                      id: currentUserId,
                    );
                    return Column(
                      children: [
                        // PROFILE SECTION
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 37,
                                backgroundImage: user.photoUrl == ""
                                    ? AssetImage(
                                        "assets/image/photo.png",
                                      )
                                    : Image.network(user.photoUrl!).image,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                        (user.name == "") ? "User" : user.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: boldRobotoFont.copyWith(
                                          fontSize: 20.sp,
                                        )),
                                  ),
                                  Text(
                                    (user.phone == "")
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
                              point: user.exp!.toDouble(),
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
                                                  style: regularRobotoFont
                                                      .copyWith(
                                                    fontSize: 9.sp,
                                                    color: darkGreen,
                                                  ),
                                                ),
                                                Text(
                                                  user.balance!.toString(),
                                                  style:
                                                      boldRobotoFont.copyWith(
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
                                          builder: (_) => UserRedeemScreen(
                                            id: currentUserId,
                                          ),
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
            SizedBox(
              height: 10.h,
            ),
            // MISSION SECTION
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
              child: Center(
                child: FutureBuilder(
                  future: missionRef
                      .where('is_active', isEqualTo: true)
                      .where("hidden", isEqualTo: false)
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var documents = snapshot.data.docs;

                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = documents[index];
                          if (data.exists) {
                            return buildMission(
                                Mission.fromJson(data.data()), data.id);
                          }
                          return SizedBox();
                        },
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
        ),
      ),
    );
  }

  Widget checkBoxMission(String missionId) {
    return FutureBuilder(
        future:
            userCompletedMissionRef.doc("${currentUserId}_$missionId").get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          bool isCompleted = snapshot.hasData && snapshot.data!.exists;

          return RoundCheckBox(
            isChecked: isCompleted,
            size: 25,
            border: Border.all(
              color: lightGreen,
            ),
            onTap: null,
            checkedWidget: Container(
              color: lightGreen,
              child: Icon(
                Icons.check,
                color: whitePure,
              ),
            ),
          );
        });
  }

  Widget buildMission(Mission mission, String missionId) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.w,
      ),
      child: Row(
        children: [
          checkBoxMission(missionId),
          SizedBox(
            width: 5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 0.72.sw,
                child: Text(
                  mission.name!,
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
                    mission.balance!.toString(),
                  ),
                  buildChip(
                    "Experience",
                    mission.exp!.toString(),
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
