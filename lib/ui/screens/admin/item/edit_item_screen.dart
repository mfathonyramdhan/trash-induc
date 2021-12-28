import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';

class AdminEditItemScreen extends StatefulWidget {
  const AdminEditItemScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_edit_trash";

  @override
  _AdminEditItemScreenState createState() => _AdminEditItemScreenState();
}

class _AdminEditItemScreenState extends State<AdminEditItemScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController itemName = TextEditingController();
  TextEditingController itemSell = TextEditingController();
  TextEditingController itemBuy = TextEditingController();

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
          "Edit Sampah",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Form(
            key: key,
            child: Column(
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
                  controller: itemName,
                  decoration: InputDecoration(
                    hintText: "Contoh: Kertas",
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
                Row(
                  children: [
                    Flexible(
                        child: TextFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "Foto item",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                            8.r,
                          ))),
                    )),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: darkGreen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                            8.r,
                          )),
                          fixedSize: Size(
                            90.w,
                            47.h,
                          )),
                      onPressed: () {},
                      icon: Icon(
                        Icons.upload_file,
                      ),
                      label: Text("Upload file"),
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
                            "Harga jual(Rp)",
                            style: boldRobotoFont.copyWith(
                              fontSize: 14.sp,
                              color: darkGray,
                            ),
                          ),
                          TextFormField(
                            controller: itemSell,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: "Contoh: 1000",
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
                            controller: itemBuy,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: "Contoh: 1000",
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
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(
                          35.h,
                        ),
                        elevation: 5,
                        primary: darkGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                          8.r,
                        ))),
                    onPressed: () {},
                    child: Text(
                      "Update item",
                      style: boldRobotoFont.copyWith(
                        fontSize: 14.sp,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
