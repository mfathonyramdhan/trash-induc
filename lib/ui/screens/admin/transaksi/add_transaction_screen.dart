import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

class AdminAddTransactionScreen extends StatefulWidget {
  const AdminAddTransactionScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_add_transaction";

  @override
  AdminAddTransactionScreenState createState() =>
      AdminAddTransactionScreenState();
}

class AdminAddTransactionScreenState extends State<AdminAddTransactionScreen> {
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
          "Tambah transaksi",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset("assets/image/buttonCreate.png"),
          )
        ],
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
