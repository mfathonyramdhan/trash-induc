import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kiloin/models/reward.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

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
          "Detail reward",
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
              Text(
                "Foto reward",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              widget.reward.photoUrl == ""
                  ? Center(
                      child: Text("Tidak ada foto"),
                    )
                  : Center(
                      child: Column(
                        children: [
                          Text(
                            widget.reward.photoUrl!,
                          ),
                          Container(
                            height: 100.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://dummyimage.com/600x400/000/fff.jpg"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
