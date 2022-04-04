import 'package:cached_network_image/cached_network_image.dart';
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

  Future<List<UserModel.User>> fetchUser() async {
    var result = await userRef.where("role", isEqualTo: "user").get();

    return result.docs
        .map((e) =>
            UserModel.User.fromJson(e.data() as Map<String, dynamic>, id: e.id))
        .toList();
  }

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
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        stream: userRef.doc(currentUserId).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Object?>> userSnapshot) {
          if (userSnapshot.hasData) {
            UserModel.User user = UserModel.User.fromJson(
              userSnapshot.data!.data() as Map<String, dynamic>,
              id: currentUserId,
            );
            return FutureBuilder<List<UserModel.User>>(
                future: fetchUser(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserModel.User>> snapshot) {
                  if (snapshot.hasData) {
                    snapshot.data!.sort(
                      (b, a) => a.balance!.compareTo(b.balance!),
                    );

                    var users = snapshot.data;

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
                                              backgroundImage: user.photoUrl ==
                                                      ""
                                                  ? Image.asset(
                                                          "assets/image/photo.png")
                                                      .image
                                                  : Image(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                      user.photoUrl!,
                                                    )).image,
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
                                              SizedBox(
                                                width: 160.w,
                                                child: Text(
                                                  user.name == ""
                                                      ? "User"
                                                      : user.name!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      boldRobotoFont.copyWith(
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                user.email == ""
                                                    ? "-"
                                                    : user.email!,
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
                                                  SizedBox(
                                                    width: 120.w,
                                                    child: Text(
                                                      user.address == ""
                                                          ? "-"
                                                          : user.address!,
                                                      style: mediumRobotoFont
                                                          .copyWith(
                                                        fontSize: 12.sp,
                                                      ),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                              text:
                                                  "Rank #${users!.indexWhere((element) => element.id == currentUserId) + 1} ",
                                              style: boldRobotoFont.copyWith(
                                                fontSize: 20.sp,
                                              ),
                                              children: [
                                            TextSpan(
                                                text:
                                                    "of ${users.length} member",
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (_) => UserEditProfileScreen(
                                          user: user,
                                          copyOfUrl: user.photoUrl!,
                                        ),
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
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                UserModel.User user = users[index];
                                return ListTile(
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
                                        backgroundImage: user.photoUrl == ""
                                            ? Image.asset(
                                                    "assets/image/photo.png")
                                                .image
                                            : Image(
                                                image:
                                                    CachedNetworkImageProvider(
                                                user.photoUrl!,
                                              )).image,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        user.name!,
                                        style: mediumRobotoFont.copyWith(
                                          fontSize: 14.sp,
                                          color: darkGreen,
                                        ),
                                      )
                                    ],
                                  ),
                                  trailing: Text(
                                    user.balance.toString(),
                                    style: regularRobotoFont.copyWith(
                                      fontSize: 10.sp,
                                      color: lightGreen,
                                    ),
                                  ),
                                );
                              },
                              itemCount: users.length,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                });
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
