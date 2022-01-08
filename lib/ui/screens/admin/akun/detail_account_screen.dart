import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/screens/admin/akun/edit_account_screen.dart';

class AdminDetailAccountScreen extends StatefulWidget {
  const AdminDetailAccountScreen({Key? key}) : super(key: key);

  @override
  _AdminDetailAccountScreenState createState() =>
      _AdminDetailAccountScreenState();
}

class _AdminDetailAccountScreenState extends State<AdminDetailAccountScreen> {
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
          "Detail Akun",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: darkGreen,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AdminEditAccountScreen(),
              ));
            },
            icon: Icon(
              Icons.edit,
            ),
            label: Text("Edit akun"),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: redDanger,
            ),
            onPressed: () {},
            icon: Icon(
              Icons.delete,
            ),
            label: Text("Hapus akun"),
          )
        ],
      ),
    );
  }
}