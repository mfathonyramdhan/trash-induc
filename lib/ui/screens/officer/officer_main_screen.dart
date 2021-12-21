import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiloin/models/officer_navigation.dart';
import 'package:kiloin/repository/officer_drawer_repository.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/ui/screens/auth/login_screen.dart';
import 'package:kiloin/ui/screens/loading.dart';
import 'package:kiloin/ui/screens/officer/officer_dashboard.dart';
import 'package:kiloin/ui/screens/officer/reward/index_reward_screen.dart';
import 'package:kiloin/ui/screens/officer/transaksi/index_transaction_screen.dart';
import 'package:kiloin/utils/firebase_utils.dart';
import 'package:provider/provider.dart';

class OfficerMainScreen extends StatefulWidget {
  const OfficerMainScreen({Key? key}) : super(key: key);
  static String routeName = "/officer_main_screen";

  @override
  _OfficerMainScreenState createState() => _OfficerMainScreenState();
}

class _OfficerMainScreenState extends State<OfficerMainScreen> {
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
    final repository = Provider.of<OfficerDrawerRepository>(context);
    final currentNavigation = repository.officerNavigation;

    switch (currentNavigation) {
      case OfficerNavigation.dashboard:
        return OfficerDashboardScreen();
      case OfficerNavigation.transaction:
        return OfficerIndexTransactionScreen();
      case OfficerNavigation.reward:
        return OfficerIndexRewardScreen();
      case OfficerNavigation.logout:
        return LogoutScreen();
    }
  }
}
