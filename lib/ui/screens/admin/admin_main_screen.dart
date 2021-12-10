import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/admin_navigation.dart';
import 'package:kiloin/repository/admin_drawer_repository.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/ui/screens/admin/admin_dashboard.dart';
import 'package:kiloin/ui/screens/admin/akun/index.dart';
import 'package:kiloin/ui/screens/admin/rank/index.dart';
import 'package:kiloin/ui/screens/admin/reward/index.dart';
import 'package:kiloin/ui/screens/admin/sampah/index.dart';
import 'package:kiloin/ui/screens/admin/transaksi/index.dart';

import 'package:provider/provider.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: lightGreen,
    ));

    return buildPages();
  }

  Widget buildPages() {
    final repository = Provider.of<AdminDrawerRepository>(context);
    final currentNavigation = repository.adminNavigation;

    switch (currentNavigation) {
      case AdminNavigation.dashboard:
        return AdminDashboard();
      case AdminNavigation.account:
        return IndexAkun();
      case AdminNavigation.trash:
        return IndexSampah();
      case AdminNavigation.transaction:
        return IndexTransaksi();
      case AdminNavigation.reward:
        return IndexReward();
      case AdminNavigation.rank:
        return IndexRank();
    }
  }
}
