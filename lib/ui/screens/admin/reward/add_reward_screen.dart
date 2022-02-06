import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:path/path.dart';

class AdminAddRewardScreen extends StatefulWidget {
  const AdminAddRewardScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_add_reward";

  @override
  _AdminAddRewardScreenState createState() => _AdminAddRewardScreenState();
}

class _AdminAddRewardScreenState extends State<AdminAddRewardScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  DateTime? selectedDate;
  File? selectedFile;

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
          "Tambah reward",
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
                  selectedFile == null
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Tap untuk pilih foto",
                                        style: TextStyle(),
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
                              radius: 90.r,
                              backgroundImage: Image.file(selectedFile!).image,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                                backgroundColor: lightGreen,
                                child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: 80.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                            15.r,
                                                          ),
                                                          topRight:
                                                              Radius.circular(
                                                            15.r,
                                                          ))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  TextButton.icon(
                                                      onPressed: () {
                                                        pickImage(
                                                          ImageSource.gallery,
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                      ),
                                                      label:
                                                          Text("Ganti foto")),
                                                  TextButton.icon(
                                                      onPressed: () {
                                                        setState(() {
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
                                    ))),
                          )
                        ])),
                  Text(
                    "Nama reward",
                    style: boldRobotoFont.copyWith(
                      fontSize: 14.sp,
                      color: darkGray,
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Contoh: Piring cantik",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                        8.r,
                      )),
                      isDense: true,
                    ),
                  ),
                  Text(
                    "Harga reward",
                    style: boldRobotoFont.copyWith(
                      fontSize: 14.sp,
                      color: darkGray,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: costController,
                    decoration: InputDecoration(
                      hintText: "Contoh: 2000",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                        8.r,
                      )),
                      isDense: true,
                    ),
                  ),
                  Text(
                    "Berakhir pada tanggal",
                    style: boldRobotoFont.copyWith(
                      fontSize: 14.sp,
                      color: darkGray,
                    ),
                  ),
                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: selectedDate == null
                                  ? DateTime.now()
                                  : selectedDate!,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2050))
                          .then((value) {
                        setState(() {
                          selectedDate = value!;
                          dateController.text = DateFormat("dd/MM/yyyy").format(
                            selectedDate!,
                          );
                        });
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Pilih tanggal",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                        8.r,
                      )),
                      isDense: true,
                    ),
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
                      submitData(
                        "rewards",
                        selectedFile!,
                      );
                    },
                    child: Text(
                      "Tambahkan reward",
                      style: boldRobotoFont.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  )
                ],
              ))
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

  Future submitData(String destination, File pickedFile) async {
    String rewardName = nameController.text;
    int rewardCost = int.parse(costController.text);
    DateTime rewardExpired = selectedDate!;
    String fileName = basename(pickedFile.path);

    final rewardRef = FirebaseFirestore.instance.collection(destination);
    final storageRef =
        FirebaseStorage.instance.ref().child(destination).child(fileName);
    await storageRef.putFile(pickedFile);
    String url = await storageRef.getDownloadURL();
    await rewardRef.add({
      "name": rewardName,
      "cost": rewardCost,
      "photoUrl": url,
      "expired_at": rewardExpired,
    });
  }
}
