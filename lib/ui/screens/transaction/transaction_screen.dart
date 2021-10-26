import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/ui/screens/transaction/empty_transaction_screen.dart';

import '../../../shared/font.dart';
import '../../../shared/color.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: darkGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10.sp,
            ),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.arrow_back_ios,
              ),
            ),
            Text(
              "Home",
              style: regularRobotoFont.copyWith(
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              width: 60.w,
            ),
            Center(
              child: Text(
                "Transaksi",
                style: boldRobotoFont.copyWith(
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: (isEmpty)
          ? EmptyTransactionScreen()
          : Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 10.h,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) => buildItem(),
                itemCount: 2,
              ),
            ),
    );
  }
}

Widget buildItem() {
  return Card(
      elevation: 5,
      child: ExpansionTile(
        leading: Text(
          "27/10/2021",
          style: regularRobotoFont.copyWith(
            fontSize: 14.sp,
            color: grayPure,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rp. 15,000",
              style: regularRobotoFont.copyWith(
                fontSize: 14.sp,
                color: lightGreen,
              ),
            ),
            Text(
              "Penukaran sampah",
              style: regularRobotoFont.copyWith(
                fontSize: 10.sp,
                color: grayPure,
              ),
            )
          ],
        ),
        children: [
          DataTable(columns: [
            DataColumn(
                label: Text(
              "Kategori Sampah",
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700),
            )),
            DataColumn(
                numeric: true,
                label: Text(
                  "Berat(Kg)",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )),
            DataColumn(
                numeric: true,
                label: Text(
                  "Total(Rp)",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ))
          ], rows: [
            DataRow(cells: [
              DataCell(Text("Plastik",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ))),
              DataCell(Text("1",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ))),
              DataCell(Text("1000",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ))),
            ]),
            DataRow(cells: [
              DataCell(Text("Kertas",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ))),
              DataCell(Text("1",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ))),
              DataCell(Text("1000",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ))),
            ]),
            DataRow(cells: [
              DataCell(Text("Logam",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ))),
              DataCell(Text("1",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ))),
              DataCell(Text("1000",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ))),
            ])
          ])
        ],
      ));
}
