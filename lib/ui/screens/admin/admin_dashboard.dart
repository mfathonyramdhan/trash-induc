import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/extension/date_time_extension.dart';
import 'package:kiloin/models/item.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/ui/widgets/admin_drawer.dart';
import 'package:kiloin/ui/widgets/app_bar.dart';
import 'package:kiloin/ui/widgets/price_card.dart';

import '../../../shared/font.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_dashboard";

  @override
  AdminDashboardScreenState createState() => AdminDashboardScreenState();
}

class AdminDashboardScreenState extends State<AdminDashboardScreen> {
  Future<List<Item>> fetchItem() async {
    var items = await FirebaseFirestore.instance.collection("items").get();
    return items.docs.map((e) => Item.fromJson(e.data(), id: e.id)).toList();
  }

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

  String getTitles(double value) {
    switch (value.toInt()) {
      case 0:
        return 'Sen';
      case 1:
        return 'Sel';
      case 2:
        return 'Rab';
      case 3:
        return 'Kam';
      case 4:
        return 'Jum';
      case 5:
        return 'Sab';
      case 6:
        return 'Min';
      default:
        return '';
    }
  }

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
            "Dashboard",
            style: boldRobotoFont.copyWith(
              fontSize: 18.sp,
            ),
          ),
          titleSpacing: 0,
          centerTitle: true,
        ),
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
                child: BarChart(BarChartData(
                    minY: 0,
                    maxY: 100,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTitles: (value) => getTitles(value),
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
                    ))),
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
              FutureBuilder<List<Item>>(
                future: fetchItem(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PriceCard(
                          title: "Jual",
                          color: [
                            yellow,
                            lightYellow,
                          ],
                          data: snapshot.data!,
                        ),
                        PriceCard(
                          title: "Beli",
                          color: [
                            blue,
                            lightBlue,
                          ],
                          data: snapshot.data!,
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: whitePure,
                    ),
                  );
                },
              )
            ]),
      ),
    );
  }
}
