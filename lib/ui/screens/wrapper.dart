import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/login_screen.dart';
import 'home/main_screen.dart';
import '../../bloc/user_bloc.dart';

class Wrapper extends StatelessWidget {
  static String routeName = '/wrapper';

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseUser = FirebaseAuth.instance;

    if (firebaseUser.currentUser == null) {
      return LoginScreen();
    }

    BlocProvider.of<UserBloc>(context).add(
      LoadUser(firebaseUser.currentUser!.uid),
    );

    return Scaffold(
      body: MainScreen(),
    );
  }
}
