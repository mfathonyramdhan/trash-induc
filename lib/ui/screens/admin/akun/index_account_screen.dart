import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/widgets/admin_drawer.dart';

class AdminIndexAccountScreen extends StatefulWidget {
  const AdminIndexAccountScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_index_account";

  @override
  _AdminIndexAccountScreenState createState() =>
      _AdminIndexAccountScreenState();
}

class _AdminIndexAccountScreenState extends State<AdminIndexAccountScreen> {
  int dropDownValue = 10;
  List<int> items = [
    10,
    25,
    50,
  ];

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
          "Akun",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset("assets/image/buttonCreate.png"),
          )
        ],
      ),
      body: ListView(children: [
        PaginatedDataTable(
          rowsPerPage: dropDownValue,
          header: Row(
            children: [
              Flexible(
                child: TextField(
                  style: TextStyle(fontSize: 14.sp),
                  onChanged: (String? value) {},
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                        8.r,
                      )),
                      hintText: "Cari akun",
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
                value: dropDownValue,
                icon: Icon(
                  Icons.visibility,
                  size: 18,
                ),
                items: items.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                      value.toString(),
                    ),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    dropDownValue = value!;
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
              label: Text("P"),
            ),
            DataColumn(
              label: Text("P"),
            ),
            DataColumn(
              label: Text("P"),
            ),
          ],
          source: Data(),
        ),
      ]),
    );
  }
}

class Data extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      100,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000)
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]["title"])),
      DataCell(Text(_data[index]["price"].toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
