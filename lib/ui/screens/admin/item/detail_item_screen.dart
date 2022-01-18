import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/item.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

class AdminDetailItemScreen extends StatefulWidget {
  const AdminDetailItemScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  _AdminDetailItemScreenState createState() => _AdminDetailItemScreenState();
}

class _AdminDetailItemScreenState extends State<AdminDetailItemScreen> {
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
          "Detail Item",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama item",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              TextFormField(
                initialValue: widget.item.name,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                    8.r,
                  )),
                  isDense: true,
                ),
              ),
              Text(
                "Foto Item",
                style: boldRobotoFont.copyWith(
                  fontSize: 14.sp,
                  color: darkGray,
                ),
              ),
              widget.item.photoUrl != null
                  ? Center(
                      child: Text("Tidak ada foto"),
                    )
                  : Center(
                      child: Column(
                        children: [
                          Text(
                            widget.item.photoUrl.toString(),
                          ),
                          Container(
                            height: 100.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://dummyimage.com/600x400/000/fff.jpg"))),
                          )
                        ],
                      ),
                    ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Harga jual(Rp)",
                          style: boldRobotoFont.copyWith(
                            fontSize: 14.sp,
                            color: darkGray,
                          ),
                        ),
                        TextFormField(
                          initialValue: widget.item.sell.toString(),
                          readOnly: true,
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                8.r,
                              ))),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Harga beli(Rp)",
                          style: boldRobotoFont.copyWith(
                            fontSize: 14.sp,
                            color: darkGray,
                          ),
                        ),
                        TextFormField(
                          initialValue: widget.item.buy.toString(),
                          readOnly: true,
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                8.r,
                              ))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
