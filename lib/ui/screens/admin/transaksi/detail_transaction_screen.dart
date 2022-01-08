import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/transaction.dart';
import 'package:kiloin/models/transaction_item.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

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
  Future<DocumentSnapshot>? _futureTransaction;

  @override
  void initState() {
    _futureTransaction = FirebaseFirestore.instance
        .collection('transactions')
        .doc(widget.transaction.id)
        .get();

    super.initState();
  }

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
      body: FutureBuilder<DocumentSnapshot>(
          future: _futureTransaction,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.exists) {
              Transaction transaction = Transaction.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>,
                  id: widget.transaction.id);
              return SizedBox(
                height: double.infinity,
                child: ListView(
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
                      "ID: " + transaction.id.toString(),
                      style: regularRobotoFont.copyWith(
                        fontSize: 18.sp,
                        color: blackPure,
                      ),
                    ),
                    Text(
                      transaction.created_at.toString(),
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
                          transaction.user!.name.toString(),
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
                          transaction.user!.email.toString(),
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
                          transaction.petugas!.name.toString(),
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
                          transaction.petugas!.email.toString(),
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
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection('transaction_items')
                            .where('transaction_id', isEqualTo: transaction.id)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var transactionItems = snapshot.data!.docs
                                .map((i) => TransactionItem.fromJson(i.data()))
                                .toList();
                            return ListView.builder(
                                itemCount: transactionItems.length,
                                itemBuilder: (context, index) => ListTile(
                                      leading: Text(
                                        transactionItems[index].qty.toString(),
                                      ),
                                    ));
                          }

                          return CircularProgressIndicator();
                        }),
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}