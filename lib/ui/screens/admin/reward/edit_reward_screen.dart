import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kiloin/models/reward.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:path/path.dart';

class AdminEditRewardScreen extends StatefulWidget {
  const AdminEditRewardScreen({
    Key? key,
    required this.reward,
  }) : super(key: key);
  static String routeName = "/admin_edit_reward";

  final Reward reward;

  @override
  _AdminEditRewardScreenState createState() => _AdminEditRewardScreenState();
}

class _AdminEditRewardScreenState extends State<AdminEditRewardScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  DateTime? selectedDate;
  File? selectedFile;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.reward.name!;
    costController.text = widget.reward.cost.toString();
    dateController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(
      widget.reward.expired_at!.microsecondsSinceEpoch,
    ));
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
          "Update reward",
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
                    "Nama reward",
                    style: boldRobotoFont.copyWith(
                      fontSize: 14.sp,
                      color: darkGray,
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
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
                    controller: nameController,
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
                              initialDate: widget.reward.expired_at!.toDate(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2050))
                          .then((value) {
                        setState(() {
                          dateController.text = DateFormat("dd/MM/yyyy").format(
                            value!,
                          );
                        });
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                        8.r,
                      )),
                      isDense: true,
                    ),
                  ),
                  Text(
                    "Pilih foto",
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
                            hintText: "Foto reward",
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
                      "Update reward",
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
    await rewardRef.doc(widget.reward.id).update({
      "name": rewardName,
      "cost": rewardCost,
      "photoUrl": url,
      "expired_at": rewardExpired,
    }).then((value) => print("done"));
  }
}
