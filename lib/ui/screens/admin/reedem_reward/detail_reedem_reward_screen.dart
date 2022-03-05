import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kiloin/models/reedemed_reward.dart';

import '../../../../shared/color.dart';
import '../../../../shared/font.dart';

class AdminDetailRedeemRewardScreen extends StatefulWidget {
  AdminDetailRedeemRewardScreen({
    Key? key,
    required this.redeemedReward,
  }) : super(key: key);

  RedeemedReward redeemedReward;

  @override
  _AdminDetailRedeemRewardScreenState createState() =>
      _AdminDetailRedeemRewardScreenState();
}

class _AdminDetailRedeemRewardScreenState
    extends State<AdminDetailRedeemRewardScreen> {
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
          "Detail redeem",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: widget.redeemedReward.reward!.photoUrl != ""
                    ? CircleAvatar(
                        radius: 100.r,
                        backgroundColor: darkGreen,
                        child: CircleAvatar(
                          radius: 90.r,
                          backgroundImage: Image.network(
                                  widget.redeemedReward.reward!.photoUrl!)
                              .image,
                        ),
                      )
                    : SizedBox(
                        height: 200.h,
                        width: 60.w,
                        child: Center(
                          child: Text("Tidak ada foto"),
                        )),
              ),
              Text(
                "Nama reward yang di redeem",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.redeemedReward.reward!.name,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                  ),
                  isDense: true,
                ),
              ),
              Text(
                "Nama user",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.redeemedReward.user!.name,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                  ),
                  isDense: true,
                ),
              ),
              Text(
                "Nama reward yang di redeem",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.redeemedReward.reward!.name,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                  ),
                  isDense: true,
                ),
              ),
              Text(
                "Nama petugas yang menangani",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.redeemedReward.petugas!.name == ""
                    ? "-"
                    : widget.redeemedReward.petugas!.name,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                  ),
                  isDense: true,
                ),
              ),
              Text(
                "Status",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.redeemedReward.status == "pending"
                    ? "Belum dikonfirmasi"
                    : widget.redeemedReward.status,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                  ),
                  isDense: true,
                ),
              ),
              Text(
                "Diajukan pada tanggal",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: DateFormat("dd/MM/yyyy")
                    .format(DateTime.fromMicrosecondsSinceEpoch(
                  widget.redeemedReward.reward!.created_at!
                      .microsecondsSinceEpoch,
                )),
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                  ),
                  isDense: true,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
