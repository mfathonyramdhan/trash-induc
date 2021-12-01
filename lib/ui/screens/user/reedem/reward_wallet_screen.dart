import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../shared/color.dart';
import '../../../../shared/font.dart';

class RewardWallet extends StatefulWidget {
  const RewardWallet({Key? key}) : super(key: key);

  @override
  RewardWalletState createState() => RewardWalletState();
}

class RewardWalletState extends State<RewardWallet> {
  CollectionReference rewardRef =
      FirebaseFirestore.instance.collection("rewards");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: rewardRef.get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) =>
                  buildCard(snapshot.data.docs[index].data()),
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
    );
  }

  Widget buildCard(Map<String, dynamic> reward) {
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
                        color: blackPure,
                      ),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reward["name"],
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
                                    .format(
                                        new DateTime.fromMicrosecondsSinceEpoch(
                                            reward["expired_at"]
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
                                style: ButtonStyle(
                                    side: MaterialStateProperty.all(BorderSide(
                                      color: Colors.blue,
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all(whitePure)),
                                onPressed: () {},
                                child: Text(
                                  "Reedem " + reward["cost"].toString(),
                                  style: boldRobotoFont.copyWith(
                                    fontSize: 13.sp,
                                    color: Colors.blue,
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
  }
}
