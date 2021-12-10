import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/ui/screens/petugas/input_transaksi.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: lightGreen,
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.h,
        ),
        children: [
          Center(
            child: Text(
              "Petugas Page",
            ),
          ),
          ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => InputTransactionScreen(),
                  )),
              child: Text(
                "Insert transaksi",
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: redDanger,
              ),
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
