import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

class DetailTransactionScreen extends StatefulWidget {
  const DetailTransactionScreen({Key? key}) : super(key: key);

  @override
  _DetailTransactionScreenState createState() =>
      _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends State<DetailTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          "Detail",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
      ),
      body: FutureBuilder(
          // future: ,
          builder: (context, snapshot) {
        return ListView(
          children: [
            Row(
              children: [
                Text("User: "),
                Text("data"),
              ],
            ),
            Row(
              children: [
                Text("User id: "),
                Text("data"),
              ],
            ),
            Row(children: [
              Text("Petugas: "),
              Text("data"),
            ]),
            Row(
              children: [
                Text("Petugas id: "),
                Text("data"),
              ],
            ),
            Divider(
              color: blackPure,
            ),
            Column(
              children: [],
            ),
            Divider(
              color: blackPure,
            ),
            Row(
              children: [
                Text("Total uang: "),
                Text("data"),
              ],
            ),
            Row(
              children: [
                Text("Total exp: "),
                Text("data"),
              ],
            ),
            Row(
              children: [
                Text("Total balance: "),
                Text("data"),
              ],
            )
          ],
        );
      }),
    );
  }
}
