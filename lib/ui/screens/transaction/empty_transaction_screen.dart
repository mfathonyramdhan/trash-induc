import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';

import '../../../shared/font.dart';

class EmptyTransactionScreen extends StatefulWidget {
  const EmptyTransactionScreen({Key? key}) : super(key: key);

  @override
  EmptyTransactionScreenState createState() => EmptyTransactionScreenState();
}

class EmptyTransactionScreenState extends State<EmptyTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Image.asset(
        "assets/image/no_transaction.png",
        width: 200,
      ),
      Align(
        alignment: Alignment.center,
        child: Text(
          "Transaksi tidak ditemukan",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
            color: blackPure,
          ),
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      Text(
        "Anda belum memiliki transaksi\nSegera tukarkan sampahmu\nke kantor terdekat!",
        textAlign: TextAlign.center,
        style: regularRobotoFont.copyWith(
          fontSize: 14.sp,
          color: blackPure,
        ),
      )
    ]);
  }
}
