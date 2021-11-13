import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/screens/user/reedem/reedemed_screen..dart';
import 'package:kiloin/ui/screens/user/reedem/reward_wallet_screen.dart.dart';
import 'package:kiloin/ui/widgets/menu_screen_card.dart';
import 'package:kiloin/models/user.dart' as UserModel;

class ReedemScreen extends StatefulWidget {
  static String routeName = "/reedem";

  const ReedemScreen({Key? key}) : super(key: key);

  @override
  _ReedemScreenState createState() => _ReedemScreenState();
}

class _ReedemScreenState extends State<ReedemScreen> {
  var currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Menu",
                  style: regularRobotoFont.copyWith(
                    fontSize: 14.sp,
                    color: darkGreen,
                  ),
                ),
              ),
              SizedBox(
                width: 60.w,
              ),
              Center(
                child: Text(
                  "Tukar Poin",
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
        body:
            // BACKGROUND CONTAINER
            Container(
          color: darkGreen,
          child: Center(
            child: FutureBuilder(
              future: userRef.doc(currentUserId).get(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  UserModel.User user = UserModel.User.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      // CARD SECTION
                      Center(
                          child: MenuScreenCard(
                        assetPath: "assets/image/medal_backdrop.png",
                        type: "Balance",
                        point: user.balancePoint!,
                      )),
                      SizedBox(
                        height: 20.h,
                      ),
                      // TAB SECTION
                      DefaultTabController(
                          length: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: whitePure,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                          15.r,
                                        ),
                                        topRight: Radius.circular(
                                          15.r,
                                        ))),
                                child: TabBar(
                                  indicator: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: darkGreen,
                                    width: 5,
                                  ))),
                                  labelColor: blackPure,
                                  unselectedLabelColor: grayPure,
                                  tabs: [
                                    Tab(
                                      text: "Reward Wallet",
                                    ),
                                    Tab(
                                      text: "Reedemed",
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: whitePure,
                                height: 0.596.sh,
                                child: TabBarView(
                                  children: [
                                    RewardWallet(),
                                    Reedemed(),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                  );
                }
                return CircularProgressIndicator(
                  color: whitePure,
                );
              },
            ),
          ),
        ));
  }
}