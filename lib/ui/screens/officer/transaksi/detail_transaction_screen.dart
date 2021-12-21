import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: ListView(
        children: [],
      ),
    );
  }
}
