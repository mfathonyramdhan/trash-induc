import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/color.dart';
import '../../../../shared/font.dart';
import 'user_edit_profile_screen.dart';
import '../../../../models/user.dart' as UserModel;

class UserProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: darkGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(
                Icons.arrow_back_ios,
                color: whitePure,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: Text(
                "Home",
                style: regularRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: whitePure,
                ),
              ),
            ),
            SizedBox(
              width: 75.w,
            ),
            Center(
              child: Text(
                "Profil",
                style: boldRobotoFont.copyWith(
                  fontSize: 18.sp,
                  color: whitePure,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: userRef.doc(currentUserId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            UserModel.User user = UserModel.User.fromJson(
                snapshot.data!.data() as Map<String, dynamic>);
            return Container(
              padding: EdgeInsets.only(
                top: 22.h,
                left: 22.h,
                right: 22.h,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 179.h,
                    child: Stack(
                      children: [
                        Container(
                          height: 164.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20.r,
                            ),
                            color: darkGreen,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: lightGreen,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/image/blank-profile-picture.png"),
                                      radius: 37,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 26.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (user.name == "-")
                                          ? SizedBox(
                                              width: 160.w,
                                              child: Text(
                                                "User",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: boldRobotoFont.copyWith(
                                                  fontSize: 18.sp,
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              width: 160.w,
                                              child: Text(
                                                user.name!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: boldRobotoFont.copyWith(
                                                  fontSize: 18.sp,
                                                ),
                                              ),
                                            ),
                                      Text(
                                        user.email!,
                                        style: lightRobotoFont.copyWith(
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: whitePure,
                                          ),
                                          Text(
                                            "Jember, Sumbersari",
                                            style: mediumRobotoFont.copyWith(
                                              fontSize: 12.sp,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 26.h,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "Rank #1",
                                      style: boldRobotoFont.copyWith(
                                        fontSize: 20.sp,
                                      ),
                                      children: [
                                    TextSpan(
                                        text: "of 100 member",
                                        style: lightRobotoFont.copyWith(
                                          fontSize: 16.sp,
                                        ))
                                  ]))
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UserEditProfileScreen(),
                              ));
                            },
                            child: Container(
                              width: 100.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    20.r,
                                  ),
                                  color: whitePure,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(
                                          2,
                                          3,
                                        ),
                                        blurRadius: 2,
                                        color: Colors.black.withOpacity(
                                          0.5,
                                        ))
                                  ]),
                              child: Center(
                                child: Text(
                                  "Edit Profil",
                                  style: boldRobotoFont.copyWith(
                                    fontSize: 14.sp,
                                    color: darkGreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ranking",
                      style: boldRobotoFont.copyWith(
                        fontSize: 18.sp,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  FutureBuilder(builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => ListTile(
                            leading: Text(
                              (index + 1).toString(),
                              style: boldRobotoFont.copyWith(
                                fontSize: 14.sp,
                                color: darkGreen,
                              ),
                            ),
                            title: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15.r,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "Nama",
                                  style: mediumRobotoFont.copyWith(
                                    fontSize: 14.sp,
                                    color: darkGreen,
                                  ),
                                )
                              ],
                            ),
                            trailing: Text(
                              "\$ 100",
                              style: regularRobotoFont.copyWith(
                                fontSize: 10.sp,
                                color: lightGreen,
                              ),
                            ),
                          ),
                          itemCount: 10,
                        ),
                      );
                    }
                    // return Center(
                    //   child: CircularProgressIndicator(
                    // color: darkGreen,
                    // ),
                    // );
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          leading: Text(
                            (index + 1).toString(),
                            style: boldRobotoFont.copyWith(
                              fontSize: 14.sp,
                              color: darkGreen,
                            ),
                          ),
                          title: Row(
                            children: [
                              CircleAvatar(
                                radius: 15.r,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "Nama",
                                style: mediumRobotoFont.copyWith(
                                  fontSize: 14.sp,
                                  color: darkGreen,
                                ),
                              )
                            ],
                          ),
                          trailing: Text(
                            "\$ 100",
                            style: regularRobotoFont.copyWith(
                              fontSize: 10.sp,
                              color: lightGreen,
                            ),
                          ),
                        ),
                        itemCount: 10,
                      ),
                    );
                  })
                ],
              ),
            );
          }

          return Center(
              child: CircularProgressIndicator(
            color: darkGreen,
          ));
        },
      ),
    );
  }
}
