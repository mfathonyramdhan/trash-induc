import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/color.dart';
import '../screens/admin/admin_main_screen.dart';
import '../screens/petugas/petugas_main_screen.dart';
import '../screens/user/home/main_screen.dart';
import '../screens/auth/login_screen.dart';
import '../../models/user.dart' as UserModel;

class Wrapper extends StatelessWidget {
  static String routeName = '/wrapper';

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseUser = FirebaseAuth.instance;

    CollectionReference userRef =
        FirebaseFirestore.instance.collection("users");

    if (firebaseUser.currentUser != null) {
      return FutureBuilder(
        future: userRef.doc(firebaseUser.currentUser!.uid.toString()).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            UserModel.User user = UserModel.User.fromJson(
                snapshot.data!.data() as Map<String, dynamic>);
            if (user.role == "user") {
              return ScreenUtilInit(
                designSize: Size(360, 640),
                builder: () => MainScreen(),
              );
            }
            if (user.role == "admin") {
              return ScreenUtilInit(
                designSize: Size(640, 360),
                builder: () => AdminMainScreen(),
              );
            }
            if (user.role == "petugas") {
              return ScreenUtilInit(
                designSize: Size(640, 360),
                builder: () => PetugasMainScreen(),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(
              color: whitePure,
            ),
          );
        },
      );
    }
    return LoginScreen();
  }
}
