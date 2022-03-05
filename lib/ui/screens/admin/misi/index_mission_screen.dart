import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/mission.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/screens/admin/misi/add_mission_screen.dart';
import 'package:kiloin/ui/screens/admin/misi/detail_mission_screen.dart';
import 'package:kiloin/ui/screens/admin/misi/edit_mission_screen.dart';
import 'package:kiloin/ui/widgets/admin_drawer.dart';
import 'package:kiloin/ui/widgets/snackbar.dart';

class AdminIndexMissionScreen extends StatefulWidget {
  const AdminIndexMissionScreen({Key? key}) : super(key: key);
  static String routeName = "/admin_index_mission";

  @override
  _AdminIndexMissionScreenState createState() =>
      _AdminIndexMissionScreenState();
}

class _AdminIndexMissionScreenState extends State<AdminIndexMissionScreen> {
  int dropdownValue = 10;
  TextEditingController searchController = TextEditingController();
  List<int> dropdownValues = [
    10,
    25,
    50,
  ];

  Future<List<Mission>>? _futureMissions;

  Future<List<Mission>> _filterMissions() async {
    var missions = <Mission>[];

    if (searchController.text.trim() != '') {
      var searchQuery = searchController.text.trim().toLowerCase();
      var missionName = await FirebaseFirestore.instance
          .collection('missions')
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThan: searchQuery + 'z')
          .get();

      var data = [];
      data.addAll(missionName.docs);
      missions.addAll(
        data.map((e) => Mission.fromJson(e.data(), id: e.id)).toList(),
      );
    } else {
      var result =
          await FirebaseFirestore.instance.collection('missions').get();
      missions =
          result.docs.map((e) => Mission.fromJson(e.data(), id: e.id)).toList();
    }

    return missions;
  }

  @override
  void initState() {
    super.initState();
    _futureMissions = _filterMissions();
  }

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
          "Misi",
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
                builder: (context) => AdminAddMissionScreen(),
              ));
            },
            icon: Image.asset("assets/image/buttonCreate.png"),
          )
        ],
      ),
      body: ListView(children: [
        FutureBuilder<List<Mission>>(
          future: _futureMissions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PaginatedDataTable(
                header: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(fontSize: 14.sp),
                        onChanged: (String? value) {
                          setState(() {
                            _futureMissions = _filterMissions();
                          });
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                              8.r,
                            )),
                            hintText: "Cari misi",
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
                    label: Text("Nama"),
                  ),
                  DataColumn(
                    label: Text("Exp"),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text("Balance"),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text("Status aktif"),
                  ),
                  DataColumn(
                    label: Text("Sembunyikan"),
                  ),
                  DataColumn(
                    label: Text("Aksi"),
                  ),
                ],
                rowsPerPage: dropdownValue,
                source: AdminDataMission(
                  context: context,
                  data: snapshot.data!,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ]),
    );
  }
}

class AdminDataMission extends DataTableSource {
  final List<Mission> data;
  final BuildContext context;

  AdminDataMission({
    required this.data,
    required this.context,
  });

  detailPage(Mission mission) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AdminDetailMissionScreen(
        mission: mission,
      ),
    ));
  }

  deleteMission(Mission mission, BuildContext context) async {
    final missionRef = FirebaseFirestore.instance.collection("missions");
    try {
      await missionRef.doc(mission.id).delete();
      Navigator.of(context).pop();
      CustomSnackbar.buildSnackbar(
        context,
        "Sukses menghapus " + mission.name!,
        1,
      );
    } catch (e) {
      CustomSnackbar.buildSnackbar(
        context,
        "Gagal menghapus karena " + e.toString(),
        0,
      );
    }
  }

  @override
  DataRow? getRow(int index) {
    Mission mission = data[index];
    return DataRow(cells: [
      DataCell(
        Text(
          (index + 1).toString(),
        ),
        onTap: () => detailPage(mission),
      ),
      DataCell(
        Text(
          mission.name.toString(),
        ),
        onTap: () => detailPage(mission),
      ),
      DataCell(
        Text(
          mission.exp.toString(),
        ),
        onTap: () => detailPage(mission),
      ),
      DataCell(
          Text(
            mission.balance.toString(),
          ),
          onTap: () => detailPage(mission)),
      DataCell(
          Text(
            mission.is_active == true ? "Ya" : "Tidak",
          ),
          onTap: () => detailPage(mission)),
      DataCell(
          Text(
            mission.hidden == true ? "Ya" : "Tidak",
          ),
          onTap: () => detailPage(mission)),
      DataCell(
        Row(
          children: [
            IconButton(
                splashRadius: 15,
                constraints: BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AdminEditMissionScreen(
                      mission: mission,
                    ),
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
                                    text: mission.name,
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
                                onPressed: () {
                                  deleteMission(
                                    mission,
                                    context,
                                  );
                                },
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
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
