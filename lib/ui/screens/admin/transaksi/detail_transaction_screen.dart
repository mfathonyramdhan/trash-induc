import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kiloin/models/transaction.dart';
import 'package:kiloin/models/transaction_item.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/widgets/app_bar.dart';

class DetailTransactionScreen extends StatefulWidget {
  const DetailTransactionScreen({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  _DetailTransactionScreenState createState() =>
      _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends State<DetailTransactionScreen> {
  Future<DocumentSnapshot> _futureTransaction() async {
    return await FirebaseFirestore.instance
        .collection('transactions')
        .doc(widget.transaction.id!)
        .get();
  }

  Future<List<TransactionItem>> _futureTransactionItems(String id) async {
    var data = await FirebaseFirestore.instance
        .collection('transaction_items')
        .where('transaction_id', isEqualTo: id)
        .get();

    return data.docs
        .map((e) => TransactionItem.fromJson(
              e.data(),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Detail transaksi"),
      body: FutureBuilder<DocumentSnapshot>(
          future: _futureTransaction(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.exists) {
              Transaction transaction = Transaction.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>,
                  id: widget.transaction.id);
              return ListView(
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
                    "ID: " + transaction.id!,
                    style: regularRobotoFont.copyWith(
                      fontSize: 18.sp,
                      color: blackPure,
                    ),
                  ),
                  Text(
                    DateFormat("dd/MM/yyyy")
                        .format(DateTime.fromMicrosecondsSinceEpoch(
                      transaction.created_at!.microsecondsSinceEpoch,
                    )),
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
                        transaction.user!.name!,
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
                        transaction.user!.id!,
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
                        transaction.petugas!.name!,
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
                        transaction.petugas!.id!,
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
                  FutureBuilder<List<TransactionItem>>(
                      future: _futureTransactionItems(transaction.id!),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<TransactionItem>> snapshot) {
                        if (snapshot.hasData) {
                          List<TransactionItem> transactionItems =
                              snapshot.data!;

                          return Column(
                            children: [
                              SizedBox(
                                height: (90 * transactionItems.length).h,
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      TransactionItem transactionItem =
                                          snapshot.data![index];

                                      return ListTile(
                                        leading: Text(
                                          transactionItem.qty.toString() +
                                              " x ",
                                        ),
                                        title: Text(
                                          transactionItem.item!.name!,
                                        ),
                                        trailing: Text(
                                          transactionItem.item!.sell.toString(),
                                        ),
                                      );
                                    }),
                              ),
                              Row(
                                children: [
                                  Text("Total uang: ",
                                      style: mediumRobotoFont.copyWith(
                                        fontSize: 14.sp,
                                        color: blackPure,
                                      )),
                                  Text(
                                      transactionItems
                                          .fold(
                                              0,
                                              (previousValue, element) =>
                                                  double.tryParse(previousValue!
                                                      .toString())! +
                                                  (element.item!.sell! *
                                                      element.qty!))
                                          .toString(),
                                      style: mediumRobotoFont.copyWith(
                                        fontSize: 14.sp,
                                        color: blackPure,
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Total exp: ",
                                      style: mediumRobotoFont.copyWith(
                                        fontSize: 14.sp,
                                        color: blackPure,
                                      )),
                                  Text(
                                      transactionItems
                                          .fold(
                                              0,
                                              (previousValue, element) =>
                                                  double.tryParse(previousValue!
                                                      .toString())! +
                                                  (element.item!.exp_point! *
                                                      element.qty!))
                                          .toString(),
                                      style: mediumRobotoFont.copyWith(
                                        fontSize: 14.sp,
                                        color: blackPure,
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Total balance: ",
                                      style: mediumRobotoFont.copyWith(
                                        fontSize: 14.sp,
                                        color: blackPure,
                                      )),
                                  Text(
                                      transactionItems
                                          .fold(
                                              0,
                                              (previousValue, element) =>
                                                  double.tryParse(previousValue!
                                                      .toString())! +
                                                  (element.item!
                                                          .balance_point! *
                                                      element.qty!))
                                          .toString(),
                                      style: mediumRobotoFont.copyWith(
                                        fontSize: 14.sp,
                                        color: blackPure,
                                      ))
                                ],
                              ),
                            ],
                          );
                        }

                        return CircularProgressIndicator();
                      }),
                ],
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
