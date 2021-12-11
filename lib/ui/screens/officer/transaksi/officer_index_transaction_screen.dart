import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/screens/officer/transaksi/officer_add_transaction_screen.dart';
import 'package:kiloin/ui/widgets/officer_drawer.dart';

class OfficerIndexTransactionScreen extends StatefulWidget {
  const OfficerIndexTransactionScreen({Key? key}) : super(key: key);

  @override
  _AdminIndexTransactionScreenState createState() =>
      _AdminIndexTransactionScreenState();
}

class _AdminIndexTransactionScreenState
    extends State<OfficerIndexTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OfficerDrawer(),
      appBar: AppBar(
        backgroundColor: darkGreen,
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
        title: Text(
          "Transaksi",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OfficerAddTransactionScreen(),
                ),
              );
            },
            icon: Image.asset("assets/image/buttonCreate.png"),
          )
        ],
      ),
    );
  }
}
