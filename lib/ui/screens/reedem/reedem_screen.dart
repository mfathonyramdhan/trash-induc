import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/screens/reedem/reward_wallet_screen.dart.dart';
import 'package:kiloin/ui/screens/reedem/reedemed_screen..dart';
import 'package:kiloin/ui/widgets/menu_screen_card.dart';

class ReedemScreen extends StatefulWidget {
  const ReedemScreen({Key? key}) : super(key: key);

  @override
  _ReedemScreenState createState() => _ReedemScreenState();
}

class _ReedemScreenState extends State<ReedemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: whitePure,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: darkGreen,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: Text(
                  "Menu",
                  style: regularRobotoFont.copyWith(
                    fontSize: 14.sp,
                    color: darkGreen,
                  ),
                ),
              ),
              SizedBox(
                width: 55.w,
              ),
              Center(
                child: Text(
                  "Transaksi",
                  style: boldRobotoFont.copyWith(
                    fontSize: 18.sp,
                    color: darkGreen,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body:
            // BACKGROUND CONTAINER
            Container(
          color: darkGreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 20.h,
              ),
              // CARD SECTION
              Center(
                  child: MenuScreenCard(
                assetPath: "assets/image/medal_backdrop.png",
                type: "Balance",
                point: 1200,
              )),
              SizedBox(
                height: 20.h,
              ),
              // TAB SECTION
              DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: whitePure,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  15.r,
                                ),
                                topRight: Radius.circular(
                                  15.r,
                                ))),
                        child: TabBar(
                          indicator: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: darkGreen,
                            width: 5,
                          ))),
                          labelColor: blackPure,
                          unselectedLabelColor: grayPure,
                          tabs: [
                            Tab(
                              text: "Reward Wallet",
                            ),
                            Tab(
                              text: "Reedemed",
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: whitePure,
                        height: 0.596.sh,
                        child: TabBarView(
                          children: [
                            RewardWallet(),
                            Reedemed(),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
