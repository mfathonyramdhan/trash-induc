import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiloin/ui/widgets/snackbar.dart';

import '../../../../shared/color.dart';
import '../../../../shared/font.dart';
import '../../../widgets/text_form_field.dart';
import '../../../../models/user.dart' as UserModel;

class UserEditProfileScreen extends StatefulWidget {
  static String routeName = "/edit_profile";

  const UserEditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel.User user;

  @override
  _UserEditProfileScreenState createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool deletePhoto = false;
  File? selectedFile;
  bool isAccepted = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name!;
    phoneController.text = widget.user.phone!;
    addressController.text = widget.user.address!;
    // postalController.text = widget.user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: darkGreen,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: whitePure,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: Text(
                  "Profil",
                  style: regularRobotoFont.copyWith(
                    fontSize: 14.sp,
                    color: whitePure,
                  ),
                ),
              ),
              SizedBox(
                width: 60.w,
              ),
              Center(
                child: Text(
                  "Edit Profil",
                  style: boldRobotoFont.copyWith(
                    fontSize: 18.sp,
                    color: whitePure,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Form(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Stack(children: [
                      CircleAvatar(
                        radius: 51.r,
                        backgroundColor: lightGreen,
                        child: CircleAvatar(
                          backgroundImage: widget.user.photoUrl != ""
                              ? Image.network(widget.user.photoUrl!).image
                              : AssetImage("assets/image/photo.png"),
                          radius: 45.r,
                        ),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundColor: darkGreen,
                            child: IconButton(
                                color: whitePure,
                                onPressed: () {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                12.r,
                                              ),
                                              topRight: Radius.circular(
                                                12.r,
                                              ))),
                                      elevation: 5,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 80.h,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "Set foto profil dari",
                                                style:
                                                    regularRobotoFont.copyWith(
                                                  fontSize: 16.sp,
                                                  color: blackPure,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  TextButton.icon(
                                                      onPressed: () async {
                                                        await pickImage(
                                                          ImageSource.camera,
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.camera,
                                                        color: lightGreen,
                                                        size: 30,
                                                      ),
                                                      label: Text(
                                                        "Kamera",
                                                        style: regularRobotoFont
                                                            .copyWith(
                                                          fontSize: 14.sp,
                                                          color: blackPure,
                                                        ),
                                                      )),
                                                  TextButton.icon(
                                                    onPressed: () async {
                                                      await pickImage(
                                                        ImageSource.gallery,
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.photo,
                                                      color: lightGreen,
                                                      size: 30,
                                                    ),
                                                    label: Text(
                                                      "Galeri",
                                                      style: regularRobotoFont
                                                          .copyWith(
                                                        fontSize: 14.sp,
                                                        color: blackPure,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                icon: Icon(
                                  Icons.edit,
                                )),
                          ))
                    ]),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextForm(
                    initial: widget.user.id,
                    label: "User ID",
                    keyboardType: TextInputType.none,
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextForm(
                    controller: nameController,
                    label: "Nama Lengkap",
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nama tidak boleh kosong";
                      }
                      if (value.length < 2) {
                        return "Nama harus lebih dari 1 karakter";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextForm(
                    label: "Nomor HP",
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty || value == null || value == "-") {
                        return "Nomor HP tidak boleh kosong";
                      }
                      if (value.length > 13 || value.length < 8) {
                        return "Nomor HP tidak valid";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextForm(
                    label: "Alamat lengkap",
                    keyboardType: TextInputType.multiline,
                    controller: addressController,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return "Alamat tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextForm(
                    label: "Kode Pos",
                    keyboardType: TextInputType.number,
                    controller: postalController,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return "Kode pos tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // submitData(destination, pickedFile)
                    },
                    child: Text("Update profil"),
                  )
                ],
              ),
            ),
          ),
        ));
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

  Future submitData(String destination, File? pickedFile) async {
    String name = nameController.text;
    String phoneNumber = phoneController.text;
    String address = addressController.text;
    // String postalCode = postalController.text;

    var userRef =
        FirebaseFirestore.instance.collection("users").doc(widget.user.id);

    try {
      if (pickedFile != null) {}

      if (deletePhoto) {}

      await userRef.update({
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        // "postalCode" : postalCode
      });
    } catch (e) {
      print(e);
    }
  }
}
