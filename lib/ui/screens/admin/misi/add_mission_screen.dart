import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/repository/mission_repository.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:provider/provider.dart';

class AdminAddMissionScreen extends StatefulWidget {
  const AdminAddMissionScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_add_mission";

  @override
  _AdminAddMissionScreenState createState() => _AdminAddMissionScreenState();
}

class _AdminAddMissionScreenState extends State<AdminAddMissionScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        leading: IconButton(
            onPressed: () {
              final repository = Provider.of<MissionRepository>(
                context,
                listen: false,
              );
              Navigator.of(context).pop();
              repository.clearAll();
            },
            icon: Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Tambah misi",
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
              key: key,
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
                      hintText: "Contoh: kumpulkan 10 kg sampah",
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
                    keyboardType: TextInputType.number,
                    controller: expController,
                    decoration: InputDecoration(
                      hintText: "Contoh: 10",
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
                    keyboardType: TextInputType.number,
                    controller: balanceController,
                    decoration: InputDecoration(
                      hintText: "Contoh: 10",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                        8.r,
                      )),
                      isDense: true,
                    ),
                  ),
                  Consumer(
                    builder: (context, repository, child) {
                      final repository =
                          Provider.of<MissionRepository>(context);
                      return ListTile(
                        title: Text(
                          "Sembunyikan dari misi",
                          style: boldRobotoFont.copyWith(
                            fontSize: 14.sp,
                            color: darkGray,
                          ),
                        ),
                        leading: Checkbox(
                          value: repository.isSembunyikanChecked,
                          onChanged: (bool) {
                            repository.setCheckBoxSembunyikan(bool!);
                          },
                        ),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, repository, child) {
                      final repository =
                          Provider.of<MissionRepository>(context);
                      return ListTile(
                        title: Text(
                          "Aktifkan misi",
                          style: boldRobotoFont.copyWith(
                            fontSize: 14.sp,
                            color: darkGray,
                          ),
                        ),
                        leading: Checkbox(
                          value: repository.isAktifkanChecked,
                          onChanged: (bool) {
                            repository.setCheckBoxAktifkan(bool!);
                          },
                        ),
                      );
                    },
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
            onPressed: () async {
              await submitData();
              Navigator.of(context).pop();
            },
            child: Text(
              "Tambahkan misi",
              style: boldRobotoFont.copyWith(
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future submitData() async {
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
      await missionRef.add({
        "name": name,
        "exp": int.parse(exp),
        "balance": int.parse(balance),
        "is_active": is_active,
        "hidden": hidden
      }).then((value) => Navigator.of(context).pop());
    } catch (e) {
      print(e);
    }
  }
}
