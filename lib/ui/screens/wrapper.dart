import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth/login_screen.dart';
import 'home/main_screen.dart';

class Wrapper extends StatelessWidget {
  static String routeName = '/wrapper';

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseUser = FirebaseAuth.instance;

    if (firebaseUser.currentUser == null) {
      return LoginScreen();
    }

    return Scaffold(
      body: MainScreen(),
    );
  }
}
