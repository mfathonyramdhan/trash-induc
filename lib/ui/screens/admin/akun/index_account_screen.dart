import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/screens/admin/akun/add_account_screen.dart';
import 'package:kiloin/ui/screens/admin/akun/detail_account_screen.dart';
import 'package:kiloin/ui/screens/admin/akun/edit_account_screen.dart';
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
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AdminAddAccountScreen(),
              ));
            },
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
              label: Text("No"),
            ),
            DataColumn(
              label: Text("Nama"),
            ),
            DataColumn(
              label: Text("Email"),
            ),
            DataColumn(
              label: Text("Balance"),
              numeric: true,
            ),
            DataColumn(
              label: Text("Exp"),
              numeric: true,
            ),
            DataColumn(
              label: Text("Aksi"),
            ),
          ],
          source: AdminDataAccount(context: context),
        ),
      ]),
    );
  }
}

class AdminDataAccount extends DataTableSource {
  final BuildContext context;

  AdminDataAccount({
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
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString()), onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdminDetailAccountScreen(),
        ));
      }),
      DataCell(Text(_data[index]["title"])),
      DataCell(Text(_data[index]["price"].toString())),
      DataCell(Text(_data[index]["p"].toString())),
      DataCell(Text(_data[index]["pr"].toString())),
      DataCell(
        Row(
          children: [
            IconButton(
                splashRadius: 15,
                constraints: BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AdminEditAccountScreen(),
                  ));
                },
                icon: Icon(
                  Icons.edit,
                  color: darkGreen,
                )),
            IconButton(
                splashRadius: 15,
                constraints: BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: redDanger,
                ))
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
