import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/ui/screens/home/menu_screen.dart';

import '../../screens/auth/login_screen.dart';
import '../../widgets/garbage_card.dart';
import '../../../extension/date_time_extension.dart';
import '../../../bloc/user_bloc.dart';
import '../../../services/auth_services.dart';
import '../../../services/social_services.dart';
import '../../../shared/color.dart';
import '../../../shared/font.dart';
import '../../../shared/size.dart';
import '../../../utils/storage_util.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double width = 24.r;
  final List<Color> leftBarColor = [
    whitePure,
    whitePure,
  ];

  bool showAvg = false;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();

    final BarChartGroupData barGroup1 = makeGroupData(0, 65000);
    final BarChartGroupData barGroup2 = makeGroupData(1, 10000);
    final BarChartGroupData barGroup3 = makeGroupData(2, 45000);
    final BarChartGroupData barGroup4 = makeGroupData(3, 30000);
    final BarChartGroupData barGroup5 = makeGroupData(4, 50000);
    final BarChartGroupData barGroup6 = makeGroupData(5, 60000);
    final BarChartGroupData barGroup7 = makeGroupData(6, 75000);

    final List<BarChartGroupData> items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          /// SECTION: HEADER PROFILE
          Padding(
            padding: EdgeInsets.fromLTRB(
              defaultMargin,
              ScreenUtil().statusBarHeight + 8.r,
              defaultMargin,
              18.r,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hai, Petugas",
                      style: lightRobotoFont.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (_, state) {
                        if (state is UserLoaded) {
                          return Text(
                            state.user.name ?? "-",
                            style: boldRobotoFont.copyWith(
                              fontSize: 24.sp,
                            ),
                          );
                        } else {
                          return Text(
                            "Memuat...",
                            style: boldRobotoFont.copyWith(
                              fontSize: 24.sp,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/icon_toggle.png"),
                  ),
                  onTap: () async {
                    onLogoutPressed(context);

                    // Navigator.pushNamed(
                    //   context, 
                    //   MenuScreen.routeName,
                    // );
                  },
                ),
              ],
            ),
          ),

          /// SECTION: TRANSACTION RECORD
          Padding(
            padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Record Transaksi",
                  style: regularRobotoFont.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),

                /// WIDGET: GRAPHIC BAR
                Container(
                  width: defaultWidth(context),
                  height: 160.r,
                  padding: EdgeInsets.only(
                    left: 12.r,
                    right: 6.r,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            maxY: 100,
                            barGroups: showingBarGroups,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTitles: (double value) => getTitles(value),
                                getTextStyles: (_) => mediumRobotoFont.copyWith(
                                  color: whitePure,
                                  fontSize: 12.sp,
                                ),
                              ),
                              leftTitles: SideTitles(
                                showTitles: true,
                                margin: 20.r,
                                interval: 25,
                                reservedSize: 10,
                                getTitles: (value) => value.toInt().toString(),
                                getTextStyles: (_) => regularRobotoFont.copyWith(
                                  color: whitePure,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${
                        getDateTime().dayName
                      }, ${
                        getDateTime().day
                      } ${
                        getDateTime().monthName
                      } ${
                        getDateTime().year
                      }",
                      style: mediumRobotoFont,
                    ),
                  ],
                )
              ],
            ),
          ),

          /// SECTION: GARBAGE PRICE
          Padding(
            padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Harga Sampah",
                  style: regularRobotoFont.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                GarbageCard(
                  title: "Harga Jual",
                  textColor: yellowPure,
                ),
                SizedBox(
                  height: 16.h,
                ),
                GarbageCard(
                  title: "Harga Jual",
                  textColor: blueSky,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 92.h,
          ),
        ],
      ),
    );
  }

  /// Generate current user local daytime
  DateTime getDateTime() => DateTime.now();

  /// Generate short day name based on order number
  String getTitles(double value) {
    switch (value.toInt()) {
      case 0:
        return 'Min';
      case 1:
        return 'Sen';
      case 2:
        return 'Sel';
      case 3:
        return 'Rab';
      case 4:
        return 'Kam';
      case 5:
        return 'Jum';
      case 6:
        return 'Sab';
      default:
        return '';
    }
  }

  /// Generate bar chart group data widget
  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          y: y1 / 1000,
          colors: leftBarColor,
          width: width,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r),
          ),
        ),
      ],
    );
  }

  /// Method will be execute when logout button is pressed
  Future<void> onLogoutPressed(BuildContext context) async {
    // Get social authenticated provider value from storage
    String socialProvider = StorageUtil.readStorage("social_provider");

    // Check if social provider is 'google'
    if (socialProvider == "google") {
      await SocialServices.signOutGoogle().then((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      });
    }
    // Check if social provider is 'facebook'
    else if (socialProvider == "facebook") {
      await SocialServices.logoutFacebook().then((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      });
    }
    // Check if authenticated not from social provider
    else {
      await AuthServices.logOut().then((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      });
    }
  }
}
