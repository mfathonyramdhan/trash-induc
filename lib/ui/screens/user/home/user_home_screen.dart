import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/item.dart';

import '../../../../models/user.dart' as UserModel;
import '../../../../shared/color.dart';
import '../../../../shared/font.dart';
import '../../../../shared/size.dart';
import 'user_menu_screen.dart';
import '../../../widgets/garbage_card.dart';
import '../../../../extension/date_time_extension.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final double width = 24.r;
  final List<Color> leftBarColor = [
    whitePure,
    whitePure,
  ];

  bool showAvg = false;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  var currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  var itemRef = FirebaseFirestore.instance.collection("items").get();

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
      body: Center(
        child: FutureBuilder(
          future: userRef.doc(currentUserId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              UserModel.User user = UserModel.User.fromJson(
                snapshot.data!.data() as Map<String, dynamic>,
              );
              return ListView(
                children: [
                  /// SECTION: HEADER PROFILE
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      defaultMargin,
                      18.r,
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
                              "Hai,",
                              style: lightRobotoFont.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              user.name == "" ? "user" : user.name!,
                              style: boldRobotoFont.copyWith(
                                fontSize: 20.sp,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/image/icon_toggle.png"),
                          ),
                          onTap: () async {
                            Navigator.pushNamed(
                              context,
                              UserMenuScreen.routeName,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  /// SECTION: TRANSACTION RECORD
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        defaultMargin, 0, defaultMargin, 12.r),
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
                                    minY: 0,
                                    maxY: 100,
                                    barGroups: showingBarGroups,
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    titlesData: FlTitlesData(
                                        show: true,
                                        bottomTitles: SideTitles(
                                          showTitles: true,
                                          getTitles: (value) =>
                                              getTitles(value),
                                          getTextStyles: (context, value) =>
                                              mediumRobotoFont.copyWith(
                                            color: whitePure,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        leftTitles: SideTitles(
                                          showTitles: true,
                                          margin: 5.r,
                                          interval: 25,
                                          reservedSize: 25,
                                          getTextStyles: (context, value) =>
                                              regularRobotoFont.copyWith(
                                            color: whitePure,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        topTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                        rightTitles: SideTitles(
                                          showTitles: false,
                                        )),
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
                              "${getDateTime().dayName}, ${getDateTime().day} ${getDateTime().monthName} ${getDateTime().year}",
                              style: mediumRobotoFont,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  /// SECTION: GARBAGE PRICE
                  FutureBuilder<QuerySnapshot<Object?>>(
                      future: itemRef,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Item> items = [];
                          for (var i in snapshot.data!.docs) {
                            items.add(Item.fromJson(
                                i.data() as Map<String, dynamic>));
                          }
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 12.r),
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
                                  title: "Jual",
                                  textColor: yellowPure,
                                  items: items,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                GarbageCard(
                                  title: "Beli",
                                  textColor: blueSky,
                                  items: items,
                                ),
                              ],
                            ),
                          );
                        }
                        return CircularProgressIndicator(
                          color: lightGreen,
                        );
                      }),
                  SizedBox(
                    height: 80.h,
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator(
              color: darkGreen,
            );
          },
        ),
      ),
    );
  }

  /// Generate current user local daytime
  DateTime getDateTime() => DateTime.now();

  String getSideTitles(double value) {
    switch (value.toInt()) {
      case 1:
        return '0';
      case 2:
        return '25';
      case 3:
        return '50';
      case 4:
        return '75';
      case 5:
        return '100';
    }
    return '';
  }

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
}
