import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/mission.dart';
import 'package:kiloin/repository/mission_repository.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:provider/provider.dart';

class AdminEditMissionScreen extends StatefulWidget {
  const AdminEditMissionScreen({
    Key? key,
    required this.mission,
  }) : super(key: key);
  static String routeName = "/admin_edit_reward";

  final Mission mission;

  @override
  _AdminEditMissionScreenState createState() => _AdminEditMissionScreenState();
}

class _AdminEditMissionScreenState extends State<AdminEditMissionScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.mission.name!;
    expController.text = widget.mission.exp.toString();
    balanceController.text = widget.mission.balance.toString();
  }

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
          "Update misi",
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
                controller: nameController,
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
                controller: expController,
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
                controller: balanceController,
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
                  onChanged: (bool) {},
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
                  onChanged: (bool) {},
                ),
              ),
            ],
          )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: darkGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                  8.r,
                ))),
            onPressed: () {},
            child: Text(
              "Update misi",
              style: boldRobotoFont.copyWith(
                fontSize: 14.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future updateData() async {
    final repository = Provider.of<MissionRepository>(
      context,
      listen: false,
    );

    final missionRef = FirebaseFirestore.instance.collection("missions");

    String name = nameController.text;
    String exp = expController.text;
    String balance = balanceController.text;
    bool is_active = repository.isAktifkanChecked;
    bool hidden = repository.isSembunyikanChecked;

    try {
      await missionRef.doc(widget.mission.id).update({
        "name": name,
        "exp": int.parse(exp),
        "balance": int.parse(balance),
        "is_active": is_active,
        "hidden": hidden
      });
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }
}
