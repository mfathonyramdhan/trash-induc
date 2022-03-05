import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/reedemed_reward.dart';
import 'package:kiloin/models/user.dart' as UserModel;

import '../../../../shared/color.dart';
import '../../../../shared/font.dart';

class AdminEditRedeemRewardScreen extends StatefulWidget {
  AdminEditRedeemRewardScreen({
    Key? key,
    required this.redeemedReward,
  }) : super(key: key);

  RedeemedReward redeemedReward;

  @override
  _AdminEditRedeemRewardScreenState createState() =>
      _AdminEditRedeemRewardScreenState();
}

class _AdminEditRedeemRewardScreenState
    extends State<AdminEditRedeemRewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Konfirmasi penukaran reward",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Form(
              child: Column(
            children: [],
          )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(
                  35.h,
                ),
                elevation: 5,
                primary: darkGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                  8.r,
                ))),
            onPressed: () {
              confirmData();
            },
            child: Text(
              "Update reward",
              style: boldRobotoFont.copyWith(
                fontSize: 14.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future confirmData() async {
    FirebaseFirestore.instance
        .runTransaction((transaction) async {
          var petugasId = FirebaseAuth.instance.currentUser!.uid;
          var redeemRef = FirebaseFirestore.instance
              .collection("user_redeemed_reward")
              .doc(widget.redeemedReward.id);
          var petugasRef = await FirebaseFirestore.instance
              .collection("users")
              .doc(petugasId)
              .get();
          var petugasData = UserModel.User.fromJson(
            petugasRef.data()!,
            id: petugasId,
          );

          await redeemRef.update({
            "status": "done",
            "updated_at": DateTime.now(),
            "petugas": petugasData.toJson(),
          });

          return true;
        })
        .then((value) => value ? Navigator.of(context).pop() : print(value))
        .catchError((error) => print(error));
  }
}
