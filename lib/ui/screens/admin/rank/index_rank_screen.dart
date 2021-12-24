import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/widgets/admin_drawer.dart';

class AdminIndexRankScreen extends StatefulWidget {
  const AdminIndexRankScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_index_rank";

  @override
  _AdminIndexRankScreenState createState() => _AdminIndexRankScreenState();
}

class _AdminIndexRankScreenState extends State<AdminIndexRankScreen> {
  int dropdownValue = 10;
  List<int> dropdownValues = [
    10,
    25,
    50,
  ];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Rank",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(children: [
        FutureBuilder(
          builder: (context, snapshot) {
            return PaginatedDataTable(
              header: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(fontSize: 14.sp),
                      onChanged: (String? value) {
                        setState(() {
                          // _futureTransactions = _filterTransactions();
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                            8.r,
                          )),
                          hintText: "Cari user",
                          prefixIcon: Icon(
                            Icons.search,
                            size: 28,
                            color: lightGreen,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 13.h,
                  ),
                  DropdownButton<int>(
                    elevation: 2,
                    value: dropdownValue,
                    icon: Icon(
                      Icons.visibility,
                      size: 18,
                    ),
                    items: dropdownValues.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          value.toString(),
                        ),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              columns: [
                DataColumn(
                  label: Text("No"),
                  numeric: true,
                ),
                DataColumn(
                  label: Text("Foto"),
                ),
                DataColumn(
                  label: Text("Nama"),
                ),
                DataColumn(
                  label: Text("Membership"),
                ),
                DataColumn(
                  label: Text("EXP"),
                  numeric: true,
                ),
                DataColumn(
                  label: Text("Balance"),
                  numeric: true,
                ),
              ],
              source: AdminDataRank(
                context: context,
              ),
            );
          },
        ),
      ]),
    );
  }
}

class AdminDataRank extends DataTableSource {
  final BuildContext context;

  AdminDataRank({
    required this.context,
  });

  final List<Map<String, dynamic>> _data = List.generate(
      100,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000),
            "p": Random().nextInt(10000),
            "pr": Random().nextInt(10000),
            "pri": Random().nextInt(10000),
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]["title"])),
      DataCell(Text(_data[index]["price"].toString())),
      DataCell(Text(_data[index]["p"].toString())),
      DataCell(Text(_data[index]["pr"].toString())),
      DataCell(Text(_data[index]["pri"].toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
