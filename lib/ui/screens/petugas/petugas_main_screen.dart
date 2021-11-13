import 'package:flutter/material.dart';
import 'package:kiloin/utils/firebase_utils.dart';
import 'package:kiloin/ui/screens/auth/login_screen.dart';

class PetugasMainScreen extends StatefulWidget {
  const PetugasMainScreen({Key? key}) : super(key: key);

  @override
  _PetugasMainScreenState createState() => _PetugasMainScreenState();
}

class _PetugasMainScreenState extends State<PetugasMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            "Petugas Page",
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseUtils.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (route) => false);
              },
              child: Text(
                "Sign Out",
              ))
        ],
      ),
    );
  }
}
