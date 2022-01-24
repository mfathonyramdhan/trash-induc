import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/mission.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

class AdminDetailMissionScreen extends StatefulWidget {
  const AdminDetailMissionScreen({
    Key? key,
    required this.mission,
  }) : super(key: key);

  final Mission mission;

  @override
  AdminDetailMissionScreenState createState() =>
      AdminDetailMissionScreenState();
}

class AdminDetailMissionScreenState extends State<AdminDetailMissionScreen> {
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
          "Detail misi",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama misi",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.mission.name,
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
                "Exp yang didapat",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.mission.exp.toString(),
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
                "Balance yang didapat",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.mission.balance.toString(),
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                    8.r,
                  )),
                  isDense: true,
                ),
              ),
              ListTile(
                title: Text(
                  "Sembunyikan dari misi",
                  style: boldRobotoFont.copyWith(
                    fontSize: 14.sp,
                    color: darkGray,
                  ),
                ),
                leading: Checkbox(
                  value: widget.mission.hidden,
                  onChanged: null,
                ),
              ),
              ListTile(
                title: Text(
                  "Aktifkan misi",
                  style: boldRobotoFont.copyWith(
                    fontSize: 14.sp,
                    color: darkGray,
                  ),
                ),
                leading: Checkbox(
                  value: widget.mission.is_active,
                  onChanged: null,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
