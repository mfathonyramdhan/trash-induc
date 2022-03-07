import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kiloin/models/reward.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/widgets/app_bar.dart';

class AdminDetailRewardScreen extends StatefulWidget {
  const AdminDetailRewardScreen({
    Key? key,
    required this.reward,
  }) : super(key: key);

  final Reward reward;

  @override
  _AdminDetailRewardScreenState createState() =>
      _AdminDetailRewardScreenState();
}

class _AdminDetailRewardScreenState extends State<AdminDetailRewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Detail reward"),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.reward.photoUrl != ""
                  ? Center(
                      child: CircleAvatar(
                        radius: 100.r,
                        backgroundColor: darkGreen,
                        child: CircleAvatar(
                          radius: 90.r,
                          backgroundImage:
                              Image.network(widget.reward.photoUrl!).image,
                        ),
                      ),
                    )
                  : Center(
                      child: SizedBox(
                          height: 200.h,
                          width: 60.w,
                          child: Center(
                            child: Text("Tidak ada foto"),
                          )),
                    ),
              Text(
                "Nama reward",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.reward.name,
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
                "Harga reward",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.reward.cost.toString(),
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                    8.r,
                  )),
                  isDense: true,
                ),
              ),
              Text(
                "Berakhir pada tanggal",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: DateFormat("dd/MM/yyyy")
                    .format(DateTime.fromMicrosecondsSinceEpoch(
                  widget.reward.expired_at!.microsecondsSinceEpoch,
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
