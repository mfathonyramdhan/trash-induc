import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kiloin/models/reedemed_reward.dart';

import '../../../../shared/color.dart';
import '../../../../shared/font.dart';

class UserReedemedScreen extends StatefulWidget {
  UserReedemedScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  String id;

  @override
  _UserReedemedScreenState createState() => _UserReedemedScreenState();
}

class _UserReedemedScreenState extends State<UserReedemedScreen> {
  Future<List<RedeemedReward>> _fetchRedeemedRewards() async {
    var redeemedRewards = await FirebaseFirestore.instance
        .collection('user_redeemed_rewards')
        .where("user.id", isEqualTo: widget.id)
        .get();
    return redeemedRewards.docs
        .map((i) => RedeemedReward.fromJson(i.data(), id: i.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<RedeemedReward>>(
          future: _fetchRedeemedRewards(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    RedeemedReward redeemedReward = snapshot.data![index];

                    return Stack(children: [
                      Card(
                          elevation: 4,
                          child: Stack(children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              height: 105.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                5.r,
                              )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 80.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(redeemedReward
                                              .reward!.photoUrl!)),
                                      borderRadius: BorderRadius.circular(
                                        5.r,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        redeemedReward.reward!.name!,
                                        style: boldRobotoFont.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w900,
                                          color: blackPure,
                                        ),
                                      ),
                                      Text(
                                        "Ditukar pada " +
                                            DateFormat.yMd()
                                                .format(new DateTime
                                                        .fromMicrosecondsSinceEpoch(
                                                    redeemedReward
                                                        .reward!
                                                        .created_at!
                                                        .microsecondsSinceEpoch))
                                                .toString(),
                                        style: regularRobotoFont.copyWith(
                                          fontSize: 11.sp,
                                          color: blackPure,
                                        ),
                                      )
                                    ],
                                  ),
                                  // SizedBox(
                                  //   width: 13.w,
                                  // ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          side: BorderSide(
                                            color: darkGreen,
                                          ),
                                          primary: whitePure,
                                          elevation: 0,
                                        ),
                                        onPressed: null,
                                        child: Text(
                                          redeemedReward.status == "pending"
                                              ? "Menunggu"
                                              : "Selesai",
                                          style: boldRobotoFont.copyWith(
                                            fontSize: 13.sp,
                                            color: darkGreen,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            if (redeemedReward.created_at!.toDate() ==
                                DateTime.now())
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 40.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                            5.r,
                                          ),
                                          bottomLeft: Radius.circular(
                                            5.r,
                                          ))),
                                  child: Center(
                                      child: Text(
                                    "New",
                                    style: boldRobotoFont.copyWith(
                                      fontSize: 14.sp,
                                      color: whitePure,
                                    ),
                                  )),
                                ),
                              )
                          ])),
                    ]);
                  });
            }

            return CircularProgressIndicator(
              color: darkGreen,
            );
          }),
    );
  }
}
