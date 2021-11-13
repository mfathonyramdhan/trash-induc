import 'package:flutter/material.dart';
import 'package:kiloin/firebase/firebase_utils.dart';
import 'package:kiloin/ui/screens/auth/login_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
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
            "Admin Page",
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
