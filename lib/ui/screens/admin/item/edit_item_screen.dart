import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiloin/models/item.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:path/path.dart';

class AdminEditItemScreen extends StatefulWidget {
  const AdminEditItemScreen({
    required this.item,
    Key? key,
  }) : super(key: key);
  static String routeName = "/admin_edit_trash";

  final Item item;

  @override
  _AdminEditItemScreenState createState() => _AdminEditItemScreenState();
}

class _AdminEditItemScreenState extends State<AdminEditItemScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController sellController = TextEditingController();
  TextEditingController buyController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  File? selectedFile;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.item.name!;
    sellController.text = widget.item.sell.toString();
    buyController.text = widget.item.buy.toString();
    balanceController.text = widget.item.balance_point.toString();
    expController.text = widget.item.exp_point.toString();
  }

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
                  controller: nameController,
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
                      onPressed: () {
                        pickImage(
                          ImageSource.gallery,
                        );
                      },
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
                            controller: sellController,
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
                            controller: buyController,
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
                            controller: expController,
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
                            "Balance point/kg",
                            style: boldRobotoFont.copyWith(
                              fontSize: 14.sp,
                              color: darkGray,
                            ),
                          ),
                          TextFormField(
                            controller: balanceController,
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
                    onPressed: () {
                      // updateData(
                      //   "items",
                      //   selectedFile,
                      // );
                    },
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

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      setState(() {
        selectedFile = File(image.path).absolute;
      });
    } on Exception catch (e) {
      print("Failed to take image: $e");
    }
  }

  Future updateData(String destination, File? pickedFile) async {
    String itemName = nameController.text;
    int itemBuy = int.parse(buyController.text);
    int itemSell = int.parse(sellController.text);
    int itemExp = int.parse(expController.text);
    int itemBalance = int.parse(balanceController.text);
    String fileName = basename(pickedFile!.path);
    final itemRef = FirebaseFirestore.instance.collection(destination);
    final storageRef = FirebaseStorage.instance;
    try {
      await storageRef.refFromURL(widget.item.photoUrl!).delete();
      await storageRef
          .ref()
          .child(destination)
          .child(fileName)
          .putFile(pickedFile);
      String url = await storageRef
          .ref()
          .child(destination)
          .child(fileName)
          .getDownloadURL();

      await itemRef.doc(widget.item.id).update({
        "name": itemName,
        "sell": itemSell,
        "buy": itemBuy,
        "exp_point": itemExp,
        "balance_point": itemBalance,
        "photoUrl": url,
      });
    } catch (e) {}
  }
}
