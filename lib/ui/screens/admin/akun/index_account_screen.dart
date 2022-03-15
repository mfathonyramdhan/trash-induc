import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/user.dart';
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
  TextEditingController searchController = TextEditingController();
  int dropDownValue = 10;
  List<int> items = [
    10,
    25,
    50,
  ];

  Future<List<User>>? _futureUsers;

  Future<List<User>> _filterUsers() async {
    var users = <User>[];

    if (searchController.text.trim() != '') {
      var searchQuery = searchController.text.trim().toLowerCase();
      var userName = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThan: searchQuery + 'z')
          .get();

      var data = [];
      data.addAll(userName.docs);
      users.addAll(
        data.map((e) => User.fromJson(e.data(), id: e.id)).toList(),
      );
    } else {
      var result = await FirebaseFirestore.instance.collection('users').get();
      users =
          result.docs.map((e) => User.fromJson(e.data(), id: e.id)).toList();
    }

    return users;
  }

  @override
  void initState() {
    super.initState();
    _futureUsers = _filterUsers();
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
          "Akun",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(children: [
        FutureBuilder<List<User>>(
          future: _futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PaginatedDataTable(
                rowsPerPage: dropDownValue,
                header: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        style: TextStyle(fontSize: 14.sp),
                        onChanged: (String? value) {
                          _futureUsers = _filterUsers();
                        },
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
                    label: Text("Membership"),
                  ),
                  DataColumn(
                    label: Text("Role"),
                  ),
                  // DataColumn(
                  //   label: Text("Aksi"),
                  // ),
                ],
                source: AdminDataAccount(
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

class AdminDataAccount extends DataTableSource {
  final BuildContext context;
  final List<User> data;

  AdminDataAccount({
    required this.context,
    required this.data,
  });

  detailPage(User user) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AdminDetailAccountScreen(user: user),
    ));
  }

  @override
  DataRow? getRow(int index) {
    User user = data[index];
    return DataRow(cells: [
      DataCell(
        Text((index + 1).toString()),
        onTap: () => detailPage(user),
      ),
      DataCell(
        Text(user.name!),
        onTap: () => detailPage(user),
      ),
      DataCell(
        Text(user.email!),
        onTap: () => detailPage(user),
      ),
      DataCell(
        Text(
          user.balance!.toString(),
        ),
        onTap: () => detailPage(user),
      ),
      DataCell(
        Text(
          user.exp!.toString(),
        ),
        onTap: () => detailPage(user),
      ),
      DataCell(
        Text(user.membership),
        onTap: () => detailPage(user),
      ),
      DataCell(
        Text(user.role),
        onTap: () => detailPage(user),
      ),
      // DataCell(
      //   Row(
      //     children: [
      //       IconButton(
      //           splashRadius: 15,
      //           constraints: BoxConstraints(),
      //           padding: EdgeInsets.zero,
      //           onPressed: () {
      //             Navigator.of(context).push(MaterialPageRoute(
      //               builder: (context) => AdminEditAccountScreen(),
      //             ));
      //           },
      //           icon: Icon(
      //             Icons.edit,
      //             color: darkGreen,
      //           )),
      //       IconButton(
      //           splashRadius: 15,
      //           constraints: BoxConstraints(),
      //           padding: EdgeInsets.zero,
      //           onPressed: () {
      //             showDialog(
      //                 context: context,
      //                 builder: (context) {
      //                   return AlertDialog(
      //                     content: RichText(
      //                       text: TextSpan(
      //                           text: "Anda yakin ingin menghapus ",
      //                           style: regularRobotoFont.copyWith(
      //                             fontSize: 14.sp,
      //                             color: darkGreen,
      //                           ),
      //                           children: [
      //                             TextSpan(
      //                               text: "Plastik",
      //                               style: boldRobotoFont.copyWith(
      //                                 fontSize: 14.sp,
      //                                 color: darkGreen,
      //                               ),
      //                             ),
      //                             TextSpan(
      //                                 text: "?",
      //                                 style: regularRobotoFont.copyWith(
      //                                   fontSize: 14.sp,
      //                                   color: darkGreen,
      //                                 ))
      //                           ]),
      //                     ),
      //                     actions: [
      //                       ElevatedButton(
      //                           style: ElevatedButton.styleFrom(
      //                               primary: whitePure,
      //                               side: BorderSide(
      //                                 color: darkGreen,
      //                               )),
      //                           onPressed: () {
      //                             Navigator.of(context).pop();
      //                           },
      //                           child: Text("Batal",
      //                               style: mediumRobotoFont.copyWith(
      //                                 fontSize: 12.sp,
      //                                 color: darkGreen,
      //                               ))),
      //                       ElevatedButton(
      //                           style: ElevatedButton.styleFrom(
      //                             primary: darkGreen,
      //                           ),
      //                           onPressed: () {},
      //                           child: Text("Ya, saya yakin",
      //                               style: mediumRobotoFont.copyWith(
      //                                 fontSize: 12.sp,
      //                               )))
      //                     ],
      //                   );
      //                 });
      //           },
      //           icon: Icon(
      //             Icons.delete,
      //             color: redDanger,
      //           ))
      //     ],
      //   ),
      // ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
