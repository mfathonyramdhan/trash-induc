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
          actions: [
            Text("data"),
          ],
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
