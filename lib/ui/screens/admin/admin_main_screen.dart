import 'package:flutter/material.dart';

import 'package:kiloin/ui/widgets/admin_drawer.dart';
import 'package:kiloin/utils/firebase_utils.dart';
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
      drawer: AdminDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              icon: Image.asset(
                "assets/image/buttonSidebar.png",
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        title: Text("title"),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
