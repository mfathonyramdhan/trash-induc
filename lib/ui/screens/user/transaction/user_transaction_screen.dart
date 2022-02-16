import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kiloin/models/transaction.dart';
import 'package:kiloin/models/transaction_item.dart';

import '../../../../shared/color.dart';
import '../../../../shared/font.dart';
import 'user_empty_transaction_screen.dart';

Map<String, List<TransactionItem?>> transactionItems = {};

class UserTransactionScreen extends StatefulWidget {
  static String routeName = "/transaction";

  const UserTransactionScreen({Key? key}) : super(key: key);

  @override
  _UserTransactionScreenState createState() => _UserTransactionScreenState();
}

class _UserTransactionScreenState extends State<UserTransactionScreen> {
  var userId = FirebaseAuth.instance.currentUser!.uid;

  Future<List<Transaction>> fetchTransaction() async {
    var transactions = <Transaction>[];

    var _transactionData = await FirebaseFirestore.instance
        .collection("transactions")
        .where("user.id", isEqualTo: userId)
        .get();

    transactions = _transactionData.docs
        .map((e) => Transaction.fromJson(e.data(), id: e.id))
        .toList();
    return transactions;
  }

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
            TextButton.icon(
              icon: Icon(
                Icons.arrow_back_ios,
                color: whitePure,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: Text(
                "Home",
                style: regularRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: whitePure,
                ),
              ),
            ),
            SizedBox(
              width: 55.w,
            ),
            Center(
              child: Text(
                "Transaksi",
                style: boldRobotoFont.copyWith(
                  fontSize: 18.sp,
                  color: whitePure,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Transaction>>(
          future: fetchTransaction(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return UserEmptyTransactionScreen();
              }

              return Padding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 10.h,
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Transaction transaction = snapshot.data![index];
                    return Card(
                        elevation: 5,
                        child: ExpansionTile(
                          collapsedIconColor: lightGreen,
                          leading: Text(
                            DateFormat("dd/MM/yyyy")
                                .format(DateTime.fromMicrosecondsSinceEpoch(
                              transaction.created_at!.microsecondsSinceEpoch,
                            )),
                            style: regularRobotoFont.copyWith(
                              fontSize: 14.sp,
                              color: grayPure,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rp " +
                                    NumberFormat("###,###,###")
                                        .format(transaction.total),
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
                            FutureBuilder<List<TransactionItem?>?>(
                                future: _getTransactionItem(transaction.id!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return DataTable(columns: [
                                      DataColumn(
                                          label: Text(
                                        "Kategori Sampah",
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
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
                                      ...snapshot.data!
                                          .map((item) => DataRow(cells: [
                                                DataCell(Text(item!.item!.name!,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ))),
                                                DataCell(
                                                    Text(item.qty.toString(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ))),
                                                DataCell(Text(
                                                    (item.item!.sell! *
                                                            item.qty!)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ))),
                                              ]))
                                          .toList(),
                                    ]);
                                  }

                                  return CircularProgressIndicator();
                                })
                          ],
                        ));
                  },
                  itemCount: snapshot.data!.length,
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(
                color: darkGreen,
              ),
            );
          }),
    );
  }

  Future<List<TransactionItem?>?> _getTransactionItem(String id) async {
    if (transactionItems.containsKey(id)) {
      return transactionItems[id];
    }

    var transaction = await FirebaseFirestore.instance
        .collection('transaction_items')
        .where('transaction_id', isEqualTo: id)
        .get();

    transactionItems[id] = transaction.docs
        .map((e) => TransactionItem.fromJson(e.data()))
        .toList();

    return transactionItems[id];
  }

  // List<DataRow> dataRows() {
  //   List<DataRow> data = [];

  // }
}
