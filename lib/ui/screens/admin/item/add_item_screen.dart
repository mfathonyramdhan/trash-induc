import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:path/path.dart';

class AdminAddItemScreen extends StatefulWidget {
  const AdminAddItemScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_add_trash";

  @override
  _AdminAddItemScreenState createState() => _AdminAddItemScreenState();
}

class _AdminAddItemScreenState extends State<AdminAddItemScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController sellController = TextEditingController();
  TextEditingController buyController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  File? file;

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
          "Tambah Sampah",
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
                      initialValue:
                          file != null ? file.toString() : "No selected file",
                      readOnly: true,
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
                        label: Text("Upload file"))
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
                    "Tambahkan item",
                    style: boldRobotoFont.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
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

      final temporaryImage = File(image.path);
      setState(() {
        this.file = temporaryImage;
      });
      print("success set image");
    } on Exception catch (e) {
      print("Failed to take image: $e");
    }
  }
}
