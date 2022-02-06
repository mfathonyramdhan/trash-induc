import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
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
  bool deletePhoto = false;

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
                (deletePhoto == true ||
                        widget.item.photoUrl == "" ||
                        selectedFile == null)
                    ? Center(
                        child: SizedBox(
                          height: 240.h,
                          width: 100.w,
                          child: InkWell(
                            onTap: () {
                              pickImage(
                                ImageSource.gallery,
                              );
                            },
                            child: DottedBorder(
                              color: grayPure,
                              strokeWidth: 5,
                              dashPattern: [
                                15,
                                10,
                              ],
                              borderType: BorderType.RRect,
                              radius: Radius.circular(
                                15.r,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tap untuk pilih foto",
                                    ),
                                    Container(
                                      height: 200.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Image(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                            "assets/image/photo-placeholder.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Stack(children: [
                          CircleAvatar(
                            radius: 100.r,
                            backgroundColor: darkGreen,
                            child: CircleAvatar(
                              backgroundImage: selectedFile == null
                                  ? Image.network(widget.item.photoUrl!).image
                                  : Image.file(selectedFile!).image,
                              radius: 90.r,
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: darkGreen,
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: 80.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                      15.r,
                                                    ),
                                                    topRight: Radius.circular(
                                                      15.r,
                                                    ))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                TextButton.icon(
                                                    onPressed: () {
                                                      pickImage(
                                                        ImageSource.gallery,
                                                      );
                                                      deletePhoto = false;
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                    ),
                                                    label: Text("Ganti foto")),
                                                TextButton.icon(
                                                    onPressed: () {
                                                      setState(() {
                                                        deletePhoto = true;
                                                        selectedFile = null;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                    ),
                                                    label: Text("Hapus foto"))
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: whitePure,
                                  ),
                                ),
                              ))
                        ]),
                      ),
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
    String? url;
    String itemName = nameController.text;
    int itemBuy = int.parse(buyController.text);
    int itemSell = int.parse(sellController.text);
    int itemExp = int.parse(expController.text);
    int itemBalance = int.parse(balanceController.text);
    var itemRef = FirebaseFirestore.instance.collection(destination);
    var storageRef = FirebaseStorage.instance;

    try {
      if (deletePhoto) {
        try {
          await storageRef.refFromURL(widget.item.photoUrl!).delete();
          url = "";
        } catch (e) {
          print(e);
        }
      }

      if (pickedFile != null) {
        String fileName = basename(pickedFile.path);
        try {
          await storageRef.refFromURL(widget.item.photoUrl!).delete();
          await storageRef.ref(destination).child(fileName).putFile(pickedFile);
          url = await storageRef
              .ref(destination)
              .child(fileName)
              .getDownloadURL();
        } catch (e) {
          print(e);
        }
      }

      await itemRef.doc(widget.item.id).update({
        "name": itemName,
        "sell": itemSell,
        "buy": itemBuy,
        "exp_point": itemExp,
        "balance_point": itemBalance,
        "photoUrl": url,
      });
    } catch (e) {
      print(e);
    }
  }
}
