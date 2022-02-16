import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kiloin/models/reward.dart';

import '../../../../models/user.dart';
import '../../../../shared/color.dart';
import '../../../../shared/font.dart';

class UserRewardWalletScreen extends StatefulWidget {
  const UserRewardWalletScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  UserRewardWalletScreenState createState() => UserRewardWalletScreenState();
}

class UserRewardWalletScreenState extends State<UserRewardWalletScreen> {
  Future<List<Reward>> fetchReward() async {
    var rewards = <Reward>[];

    var _transactionData =
        await FirebaseFirestore.instance.collection("rewards").get();

    rewards = _transactionData.docs
        .map((e) => Reward.fromJson(e.data(), id: e.id))
        .toList();
    return rewards;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Reward>>(
        future: fetchReward(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Reward reward = snapshot.data![index];

                  return Stack(children: [
                    Card(
                        elevation: 5,
                        child: Stack(children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            height: 115.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                              5.r,
                            )),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 4,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 105,
                                    width: 95,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        5.r,
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(reward.photoUrl !=
                                                  ""
                                              ? reward.photoUrl!
                                              : "https://dummyimage.com/600x400/000/fff")),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reward.name!,
                                          style: boldRobotoFont.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w900,
                                            color: blackPure,
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          "Exp " +
                                              DateFormat.yMd()
                                                  .format(new DateTime
                                                          .fromMicrosecondsSinceEpoch(
                                                      reward.expired_at!
                                                          .microsecondsSinceEpoch))
                                                  .toString(),
                                          style: regularRobotoFont.copyWith(
                                            fontSize: 11.sp,
                                            color: blackPure,
                                          ),
                                        ),
                                        Spacer(),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation:
                                                      (widget.user.balance! <
                                                              reward.cost!)
                                                          ? 0
                                                          : 5,
                                                  primary: whitePure,
                                                  side: BorderSide(
                                                    width: 1,
                                                    color:
                                                        (widget.user.balance! <
                                                                reward.cost!)
                                                            ? whitePure
                                                            : blueSky,
                                                  )),
                                              onPressed: (widget.user.balance! <
                                                      reward.cost!)
                                                  ? null
                                                  : () => showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: SingleChildScrollView(
                                                              child: Text("Anda akan menukarkan " +
                                                                  reward.cost
                                                                      .toString() +
                                                                  " poin untuk hadiah " +
                                                                  reward.name! +
                                                                  ", yakin?")),
                                                          title: Text(
                                                              "Konfirmasi penukaran hadiah"),
                                                          actions: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child:
                                                                  Text("Tidak"),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {},
                                                              child:
                                                                  Text("Iya"),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                              child: Text(
                                                "Reedem " +
                                                    reward.cost.toString(),
                                                style: boldRobotoFont.copyWith(
                                                  fontSize: 13.sp,
                                                  color: (widget.user.balance! <
                                                          reward.cost!)
                                                      ? blackPure.withOpacity(
                                                          0.7,
                                                        )
                                                      : blueSky,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 35.w,
                              height: 15.h,
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
                                  fontSize: 12.sp,
                                  color: whitePure,
                                ),
                              )),
                            ),
                          )
                        ])),
                  ]);
                });
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return CircularProgressIndicator(
            color: darkGreen,
          );
        },
      ),
    );
  }
}
