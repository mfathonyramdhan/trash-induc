import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/screens/admin/reward/add_reward_screen.dart';
import 'package:kiloin/ui/screens/admin/reward/detail_reward_screen.dart';
import 'package:kiloin/ui/screens/admin/reward/edit_reward_screen.dart';
import 'package:kiloin/ui/widgets/admin_drawer.dart';

class AdminIndexRewardScreen extends StatefulWidget {
  const AdminIndexRewardScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_index_reward";

  @override
  _AdminIndexRewardScreenState createState() => _AdminIndexRewardScreenState();
}

class _AdminIndexRewardScreenState extends State<AdminIndexRewardScreen> {
  int dropdownValue = 10;
  TextEditingController searchController = TextEditingController();
  List<int> dropdownValues = [
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
          "Reward",
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
                builder: (context) => AdminAddRewardScreen(),
              ));
            },
            icon: Image.asset("assets/image/buttonCreate.png"),
          )
        ],
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
                          hintText: "Cari reward",
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
                  label: Text("Harga"),
                  numeric: true,
                ),
                DataColumn(
                  label: Text("Expired"),
                ),
                DataColumn(
                  label: Text("Aksi"),
                ),
              ],
              source: AdminDataReward(
                context: context,
              ),
            );
          },
        ),
      ]),
    );
  }
}

class AdminDataReward extends DataTableSource {
  // final List<Item> item;
  final BuildContext context;

  AdminDataReward({
    //   required this.item,
    required this.context,
  });

  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000)
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString()), onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdminDetailRewardScreen(),
        ));
      }),
      DataCell(Text(_data[index]["title"])),
      DataCell(Text(_data[index]["price"].toString())),
      DataCell(Text(_data[index]["title"])),
      DataCell(Text(_data[index]["price"].toString())),
      DataCell(
        Row(
          children: [
            IconButton(
                splashRadius: 15,
                constraints: BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AdminEditRewardScreen(),
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
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: RichText(
                            text: TextSpan(
                                text: "Anda yakin ingin menghapus ",
                                style: regularRobotoFont.copyWith(
                                  fontSize: 14.sp,
                                  color: darkGreen,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Plastik",
                                    style: boldRobotoFont.copyWith(
                                      fontSize: 14.sp,
                                      color: darkGreen,
                                    ),
                                  ),
                                  TextSpan(
                                      text: "?",
                                      style: regularRobotoFont.copyWith(
                                        fontSize: 14.sp,
                                        color: darkGreen,
                                      ))
                                ]),
                          ),
                          actions: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: whitePure,
                                    side: BorderSide(
                                      color: darkGreen,
                                    )),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Batal",
                                    style: mediumRobotoFont.copyWith(
                                      fontSize: 12.sp,
                                      color: darkGreen,
                                    ))),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: darkGreen,
                                ),
                                onPressed: () {},
                                child: Text("Ya, saya yakin",
                                    style: mediumRobotoFont.copyWith(
                                      fontSize: 12.sp,
                                    )))
                          ],
                        );
                      });
                },
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
