import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

import '../../../../shared/color.dart';
import '../../../../shared/font.dart';
import '../../../widgets/text_form_field.dart';
import '../../../../models/user.dart' as UserModel;

class UserEditProfileScreen extends StatefulWidget {
  static String routeName = "/edit_profile";

  const UserEditProfileScreen({Key? key}) : super(key: key);

  @override
  _UserEditProfileScreenState createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  String currentProvince = "";
  String currentCity = "";
  String currentDistrict = "";
  String currentVillage = "";
  final TextEditingController address = TextEditingController();
  final TextEditingController postalCode = TextEditingController();

  List<String> provinces = [
    "Jawa Timur",
    "Jawa tapi gak jawa",
    "Jakarta tapi gakmau dibilang jawa",
  ];
  List<String> city = [
    "Jember",
    "Jemb0t",
    "Kntl",
  ];
  List<String> district = [
    "Sumbersari",
  ];
  List<String> village = [
    "Ambulu",
  ];

  final TextEditingController photo = TextEditingController();
  final TextEditingController photoId = TextEditingController();
  final TextEditingController photoWithId = TextEditingController();

  UploadTask? task;
  File? filePhoto;
  File? fileId;
  File? filePhotoAndId;

  List<GlobalKey<FormState>> formKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  bool isAccepted = false;

  var currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

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
      body: FutureBuilder(
          future: userRef.doc(currentUserId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              UserModel.User user = UserModel.User.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>);
              fullName.text = user.name!;
              phoneNumber.text = user.phone!;
              return Container(
                child: CoolStepper(
                  onCompleted: () {
                    submitData();
                  },
                  steps: [
                    CoolStep(
                      title: "P",
                      subtitle: "P",
                      content: Form(
                        key: formKey[0],
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            CircleAvatar(
                              radius: 51.r,
                              backgroundColor: lightGreen,
                              child: CircleAvatar(
                                radius: 45.r,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomTextForm(
                              initial: currentUserId,
                              label: "User ID",
                              keyboardType: TextInputType.none,
                              readOnly: true,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextForm(
                              controller: fullName,
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
                              controller: phoneNumber,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value == null ||
                                    value == "-") {
                                  return "Nomor HP tidak boleh kosong";
                                }
                                if (value.length > 13 || value.length < 8) {
                                  return "Nomor HP tidak valid";
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                      validation: () {
                        if (!formKey[0].currentState!.validate()) {
                          return "Isi semua form dengan benar";
                        }
                        return null;
                      },
                    ),
                    CoolStep(
                        title: "P",
                        subtitle: "P",
                        content: Form(
                            key: formKey[1],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Text(
                                  "Lengkapi data domisili kamu",
                                  style: mediumRobotoFont.copyWith(
                                    fontSize: 18.sp,
                                    color: blackPure,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "*Mohon lengkapi data diri",
                                  style: regularRobotoFont.copyWith(
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.italic,
                                    color: redDanger,
                                  ),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                Text(
                                  "Provinsi",
                                  style: regularRobotoFont.copyWith(
                                    fontSize: 14.sp,
                                    color: blackPure,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                DropdownButtonFormField(
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      currentProvince = newValue!;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                  decoration: InputDecoration(
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: grayPure,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: lightGreen,
                                          ))),
                                  hint: Text(
                                    "Provinsi",
                                  ),
                                  items: provinces
                                      .map((value) => DropdownMenuItem(
                                            child: Text(value),
                                            value: value,
                                          ))
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Kota/Kabupaten",
                                  style: regularRobotoFont.copyWith(
                                    fontSize: 14.sp,
                                    color: blackPure,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                DropdownButtonFormField(
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      currentCity = newValue!;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                  decoration: InputDecoration(
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: grayPure,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: lightGreen,
                                          ))),
                                  hint: Text(
                                    "Kota/Kabupaten",
                                  ),
                                  items: city
                                      .map((value) => DropdownMenuItem(
                                            child: Text(value),
                                            value: value,
                                          ))
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Kecamatan",
                                  style: regularRobotoFont.copyWith(
                                    fontSize: 14.sp,
                                    color: blackPure,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                DropdownButtonFormField(
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      currentDistrict = newValue!;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                  decoration: InputDecoration(
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: grayPure,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: lightGreen,
                                          ))),
                                  hint: Text(
                                    "Kecamatan",
                                  ),
                                  items: district
                                      .map((value) => DropdownMenuItem(
                                            child: Text(value),
                                            value: value,
                                          ))
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Desa",
                                  style: regularRobotoFont.copyWith(
                                    fontSize: 14.sp,
                                    color: blackPure,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                DropdownButtonFormField(
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      currentVillage = newValue!;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                  decoration: InputDecoration(
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: grayPure,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: lightGreen,
                                          ))),
                                  hint: Text(
                                    "Desa",
                                  ),
                                  items: village
                                      .map((value) => DropdownMenuItem(
                                            child: Text(value),
                                            value: value,
                                          ))
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomTextForm(
                                  label: "Alamat lengkap",
                                  keyboardType: TextInputType.multiline,
                                  controller: address,
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
                                  controller: postalCode,
                                  validator: (value) {
                                    if (value!.isEmpty || value == null) {
                                      return "Kode pos tidak boleh kosong";
                                    }
                                    return null;
                                  },
                                )
                              ],
                            )),
                        validation: () {
                          if (!formKey[1].currentState!.validate()) {
                            return "Isi semua form dengan benar";
                          }
                          return null;
                        }),
                    CoolStep(
                        title: "P",
                        subtitle: "P",
                        content: Form(
                            key: formKey[2],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Text(
                                  "Lengkapi foto kamu",
                                  style: mediumRobotoFont.copyWith(
                                    fontSize: 18.sp,
                                    color: blackPure,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "*Mohon lengkapi data diri",
                                  style: regularRobotoFont.copyWith(
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.italic,
                                    color: redDanger,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                InkWell(
                                  onTap: () async {
                                    profilePhotoPressed();
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: grayPure,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          )),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.person,
                                        ),
                                        title: Text(
                                          filePhoto != null
                                              ? basename(filePhoto!.path)
                                              : "Foto diri kamu",
                                          style: regularRobotoFont.copyWith(
                                            fontSize: 14.sp,
                                            color: blackPure,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                InkWell(
                                  onTap: () async {
                                    // idPhotoPressed();
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: grayPure,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          )),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.person,
                                        ),
                                        title: Text(
                                          fileId != null
                                              ? basename(fileId!.path)
                                              : "Foto tanda pengenalmu",
                                          style: regularRobotoFont.copyWith(
                                            fontSize: 14.sp,
                                            color: blackPure,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                InkWell(
                                  onTap: () async {
                                    // profileAndIdPressed();
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: grayPure,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          )),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.person,
                                        ),
                                        title: Text(
                                          filePhotoAndId != null
                                              ? basename(filePhotoAndId!.path)
                                              : "Foto diri bersama tanda pengenalmu",
                                          style: regularRobotoFont.copyWith(
                                            fontSize: 14.sp,
                                            color: blackPure,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                        ),
                                      )),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     Checkbox(
                                //         value: isAccepted,
                                //         onChanged: (value) {
                                //           setState(() {
                                //             isAccepted = value!;
                                //           });
                                //         }),
                                //     Text(
                                //       "Dengan melengkapi data diri, saya setuju pada\nSyarat & Ketentuan dan Kebijakan Transh Induc",
                                //       style: regularRobotoFont.copyWith(
                                //         fontSize: 12.sp,
                                //         color: blackPure,
                                //       ),
                                //     )
                                //   ],
                                // )
                              ],
                            )),
                        validation: () {
                          if (!formKey[2].currentState!.validate()) {
                            return "Isi semua form dengan benar";
                          }
                          return null;
                        })
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(
                child: CircularProgressIndicator(
              color: darkGreen,
            ));
          }),
    );
  }

  Future profilePhotoPressed() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ["jpg", "jpeg", "png"],
    );
    if (result == null) return;

    final path = result.files.single.path!;

    setState(() {
      filePhoto = File(path);
    });
  }

  Future idPhotoPressed() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ["jpg", "jpeg", "png"],
    );
    if (result == null) return;

    final path = result.files.single.path!;

    setState(() {
      fileId = File(path);
    });
  }

  Future profileAndIdPressed() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ["jpg", "jpeg", "png"],
    );
    if (result == null) return;

    final path = result.files.single.path!;

    setState(() {
      filePhotoAndId = File(path);
    });
  }

  Future submitData() async {
    // if (file == null) return;

    // final fileName = basename(file!.path);
    // // to make folder destination based on uid
    // final destination = "uid/$fileName";

    // FirebaseUtils.uploadFile(destination, file!);
  }
}
