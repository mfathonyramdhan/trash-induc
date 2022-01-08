import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

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
  DateTime selectedDate = DateTime.now();
  GlobalKey<FormState> key = GlobalKey<FormState>();

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
                  ListTile(
                    title: Text(
                      "Sembunyikan dari misi",
                      style: boldRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: darkGray,
                      ),
                    ),
                    leading: Checkbox(
                      value: false,
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
                      value: false,
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
}
