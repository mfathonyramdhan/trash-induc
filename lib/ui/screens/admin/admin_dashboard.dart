import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/extension/date_time_extension.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/ui/widgets/admin_drawer.dart';
import 'package:kiloin/ui/widgets/app_bar.dart';

import '../../../shared/font.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_dashboard";

  @override
  AdminDashboardScreenState createState() => AdminDashboardScreenState();
}

class AdminDashboardScreenState extends State<AdminDashboardScreen> {
  DateTime getDateTime() => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF527D46),
            Color(0xFF7EB044),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: AdminDrawer(),
        appBar: CustomAppBar(title: "Dashboard"),
        body: ListView(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            children: [
              Text(
                "Record Transaksi",
                style: boldRobotoFont.copyWith(
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 1.sw,
                height: 0.4.sh,
                child: BarChart(BarChartData()),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${getDateTime().dayName}, ${getDateTime().day} ${getDateTime().monthName} ${getDateTime().year}",
                  style: mediumRobotoFont,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Harga Sampah",
                style: boldRobotoFont.copyWith(
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 0.25.sh,
                        width: 0.45.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.r,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [
                              0,
                              0.7,
                              1,
                            ],
                            colors: [
                              yellow,
                              lightYellow,
                              yellow,
                            ],
                          ),
                        ),
                        child: Opacity(
                          opacity: 0.3,
                          child: Image.asset(
                            "assets/image/bg_jual_sampah.png",
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Harga\nJual",
                            textAlign: TextAlign.center,
                            style: boldRobotoFont.copyWith(
                              fontSize: 11.sp,
                              color: Color(0xff92840F),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                              height: 0.2.sh,
                              width: 0.3.sw,
                              child: ListView.builder(
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: 5.w,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Jenis sampah $index",
                                          style: mediumRobotoFont.copyWith(
                                            color: Color(0xff92840F),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: 7.w,
                                          ),
                                          child: Text(
                                            "Rp",
                                            style: regularRobotoFont.copyWith(
                                              color: blackPure,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "600$index",
                                          style: boldRobotoFont.copyWith(
                                            color: blackPure,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 7.w,
                                          ),
                                          child: Text(
                                            "kg",
                                            style: regularRobotoFont.copyWith(
                                              color: blackPure,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ))
                        ],
                      )
                    ],
                  )
                ],
              )
            ]),
      ),
    );
  }
}
