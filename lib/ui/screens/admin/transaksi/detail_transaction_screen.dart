import 'dart:ui';

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: darkGreen,
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          "Detail transaksi",
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
            Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 50.w,
                  height: 75.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/splash.png"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Trash induc",
                  style: boldRobotoFont.copyWith(
                    fontSize: 14.sp,
                    color: blackPure,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "ID: BJrwskJGVy2edKEUlQ6r",
                  style: regularRobotoFont.copyWith(
                    fontSize: 18.sp,
                    color: blackPure,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Nama: ",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                    Text(
                      "Dida Arda",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "ID User: ",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                    Text(
                      "6969696969",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Petugas: ",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                    Text(
                      "Gilang",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "ID Petugas: ",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                    Text(
                      "68686869",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
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
                    Text(
                      "Total exp: ",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                    Text(
                      "20.0",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Total balance: ",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                    Text(
                      "10.0",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Total uang: ",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                    Text(
                      "Rp. 2000",
                      style: mediumRobotoFont.copyWith(
                        fontSize: 14.sp,
                        color: blackPure,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}
