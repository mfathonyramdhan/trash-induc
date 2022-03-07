import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/item.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/widgets/app_bar.dart';

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
      appBar: CustomAppBar(title: "Detail Item"),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              widget.item.photoUrl != ""
                  ? Center(
                      child: CircleAvatar(
                        backgroundColor: darkGreen,
                        radius: 100.r,
                        child: CircleAvatar(
                          radius: 90.r,
                          backgroundImage:
                              Image.network(widget.item.photoUrl!).image,
                        ),
                      ),
                    )
                  : Center(
                      child: SizedBox(
                          height: 200.h,
                          width: 60.w,
                          child: Center(
                            child: Text("Tidak ada foto"),
                          )),
                    ),
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
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Exp point/kg",
                          style: boldRobotoFont.copyWith(
                            fontSize: 14.sp,
                            color: darkGray,
                          ),
                        ),
                        TextFormField(
                          initialValue: widget.item.exp_point.toString(),
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
                          "Balance point/kg",
                          style: boldRobotoFont.copyWith(
                            fontSize: 14.sp,
                            color: darkGray,
                          ),
                        ),
                        TextFormField(
                          initialValue: widget.item.balance_point.toString(),
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
