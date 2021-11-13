import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/widgets/dropdown_field.dart';
import 'package:kiloin/ui/widgets/text_form_field.dart';
import 'package:kiloin/models/user.dart' as UserModel;

class EditProfileScreen extends StatefulWidget {
  static String routeName = "/edit_profile";

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController userId = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final TextEditingController province = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController village = TextEditingController();

  final TextEditingController photo = TextEditingController();
  final TextEditingController photoId = TextEditingController();
  final TextEditingController photoWithId = TextEditingController();

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
                  onCompleted: () {},
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
                              radius: 51,
                              backgroundColor: lightGreen,
                              child: CircleAvatar(
                                radius: 45,
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
                            CustomTextForm(
                              controller: fullName,
                              label: "Nama Lengkap",
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Nama tidak boleh kosong";
                                }
                                if (value.length < 4) {
                                  return "Nama harus lebih dari 3 karakter";
                                }
                                return null;
                              },
                            ),
                            CustomTextForm(
                              label: "Nomor HP",
                              keyboardType: TextInputType.number,
                              controller: phoneNumber,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Nomor HP tidak boleh kosoong";
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                      validation: () {
                        if (!formKey[0].currentState!.validate()) {
                          return "";
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
                                CustomDropDownField(
                                  label: "Provinsi",
                                ),
                                CustomDropDownField(
                                  label: "Kota/Kabupaten",
                                ),
                                CustomDropDownField(
                                  label: "Kecamatan",
                                ),
                                CustomDropDownField(
                                  label: "Desa",
                                ),
                                CustomTextForm(
                                  label: "Alamat lengkap",
                                  keyboardType: TextInputType.multiline,
                                  controller: address,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Alamat tidak boleh kosong";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextForm(
                                  label: "Kode Pos",
                                  keyboardType: TextInputType.number,
                                  controller: postalCode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Kode pos tidak boleh kosong";
                                    }
                                    return null;
                                  },
                                )
                              ],
                            )),
                        validation: () {
                          if (!formKey[1].currentState!.validate()) {
                            return "";
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
                                  onTap: () async {},
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
                                          "Foto diri kamu",
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
                                  onTap: () async {},
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
                                          "Foto tanda pengenalmu",
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
                                  onTap: () async {},
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
                                          "Foto diri bersama tanda pengenalmu",
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                        value: isAccepted,
                                        onChanged: (value) {
                                          setState(() {
                                            isAccepted = value!;
                                          });
                                        }),
                                    Text(
                                      "Dengan melengkapi data diri, saya setuju pada\nSyarat & Ketentuan dan Kebijakan Transh Induc",
                                      style: regularRobotoFont.copyWith(
                                        fontSize: 12.sp,
                                        color: blackPure,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                        validation: () {
                          if (!formKey[1].currentState!.validate()) {
                            return "";
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
}