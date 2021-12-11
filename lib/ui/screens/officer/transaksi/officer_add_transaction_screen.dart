import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/cart_item.dart';
import 'package:kiloin/models/item.dart';
import 'package:kiloin/models/mission.dart';
import 'package:kiloin/models/user.dart';
import 'package:kiloin/repository/cart_item_repository.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/ui/screens/officer/cart_item_form.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class OfficerAddTransactionScreen extends StatefulWidget {
  const OfficerAddTransactionScreen({Key? key}) : super(key: key);

  @override
  _OfficerAddTransactionScreenState createState() =>
      _OfficerAddTransactionScreenState();
}

class _OfficerAddTransactionScreenState
    extends State<OfficerAddTransactionScreen> {
  GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();
  TextEditingController weightController = TextEditingController();
  User? selectedUser;
  Item? selectedItem;

  List selectedMission = [];

  Future<List<User>>? fetchUsers;
  Future<Map<String, Mission>>? fetchMissions;
  Future<List<Item>>? fetchItems;

  Future<List<User>> _fetchUsers() async {
    var users =
        await FirebaseFirestore.instance.collection('users').limit(10).get();
    return users.docs.map((e) => User.fromJson(e.data())).toList();
  }

  Future<Map<String, Mission>> _fetchMissions() async {
    var missions = await FirebaseFirestore.instance
        .collection('missions')
        .where('isActive', isEqualTo: true)
        .get();
    Map<String, Mission> mapMissions = {};
    missions.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> e) {
      mapMissions[e.id] = Mission.fromJson(e.data());
    });

    return mapMissions;
  }

  Future<List<Item>> _fetchItems() async {
    var items = await FirebaseFirestore.instance.collection('items').get();

    return items.docs.map((i) => Item.fromJson(i.data())).toList();
  }

  @override
  void initState() {
    fetchUsers = _fetchUsers();
    fetchMissions = _fetchMissions();
    fetchItems = _fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input transaksi"),
        titleSpacing: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: 70.h,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  15.r,
                ),
                topRight: Radius.circular(
                  15.r,
                ))),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                ),
                Text(
                  10000.toString(),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Tambah Data",
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        child: Form(
            key: key,
            child: Column(
              children: [
                FutureBuilder<List<User>>(
                    future: fetchUsers,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      return DropdownSearch<User>(
                        mode: Mode.MENU,
                        onFind: (String? filter) async {
                          if (filter == null || filter == '') {
                            var users = await FirebaseFirestore.instance
                                .collection('users')
                                .limit(10)
                                .get();
                            return users.docs
                                .map((e) => User.fromJson(e.data()))
                                .toList();
                          }

                          var getUsersByEmail = await FirebaseFirestore.instance
                              .collection("users")
                              .where("role", isEqualTo: "user")
                              // .orderBy('email')
                              // .startAt([filter]).endAt([filter + '\uf8ff'])
                              .where('email', isGreaterThanOrEqualTo: filter)
                              .where('email', isLessThan: filter + 'z')
                              .limit(50)
                              .get();
                          // var getUsersByName = await FirebaseFirestore.instance
                          //     .collection('users')
                          //     .where('role', isEqualTo: 'user')
                          //     .orderBy('name')
                          //     .startAt([filter])
                          //     .endAt([filter + '\uf8ff'])
                          //     // .where('name', isGreaterThanOrEqualTo: filter)
                          //     // .where('name', isLessThan: filter + 'z')
                          //     .get();

                          var users = getUsersByEmail.docs;
                          // users.addAll(getUsersByName.docs);

                          return users
                              .map((e) => User.fromJson(e.data()))
                              .toList();
                        },
                        label: "Select user",
                        hint: "Test hint",
                        itemAsString: (User? user) => user!.email.toString(),
                        // items: snapshot.hasData ? snapshot.data : [],
                        showSearchBox: true,
                        showClearButton: true,
                      );
                    }),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Items:",
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartItemFormScreen(),
                          ));
                        },
                        child: Icon(
                          Icons.add,
                        ))
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<CartItemRepository>(
                        builder: (context, repository, child) {
                      List<CartItem> items = repository.getAllCartItem();
                      return DataTable(
                        // columnSpacing: 30,
                        columns: [
                          DataColumn(
                              label: Text(
                            "Jenis",
                          )),
                          DataColumn(
                              numeric: true,
                              label: Text(
                                "Berat(kg)",
                              )),
                          DataColumn(
                              numeric: true,
                              label: Text(
                                "Harga",
                              )),
                          DataColumn(
                              label: Text(
                            "",
                          ))
                        ],
                        rows: items.isNotEmpty
                            ? itemNotEmpty(items)
                            : itemEmpty(),
                      );
                    })),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Pilih misi yang tercapai",
                ),
                FutureBuilder<Map<String, Mission>>(
                    future: fetchMissions,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      return MultiSelectDialogField(
                        chipDisplay: MultiSelectChipDisplay(
                          scroll: true,
                          chipColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        items: snapshot.hasData
                            ? snapshot.data!.entries
                                .toList()
                                .map(
                                  (e) => MultiSelectItem(
                                    e.key,
                                    e.value.name.toString(),
                                  ),
                                )
                                .toList()
                            : <MultiSelectItem>[],
                        onConfirm: (value) {
                          selectedMission = value;
                        },
                        initialValue: selectedMission,
                      );
                    }),
              ],
            )),
      ),
    );
  }

  List<DataRow> itemEmpty() {
    return [
      DataRow(cells: [
        DataCell(Text(
          "-",
        )),
        DataCell(Text(
          "-",
        )),
        DataCell(Text(
          "-",
        )),
        DataCell(Row(
          children: [
            IconButton(onPressed: null, icon: SizedBox()),
            IconButton(onPressed: null, icon: SizedBox())
          ],
        ))
      ])
    ];
  }

  List<DataRow> itemNotEmpty(List<CartItem> items) {
    List<DataRow> dataRows = [];
    items.forEach((CartItem item) => dataRows.add(DataRow(cells: [
          DataCell(
            Text(item.type),
          ),
          DataCell(Text(item.qty.toString())),
          DataCell(Text('-')),
          DataCell(Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: darkGreen,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: redDanger,
                  ))
            ],
          ))
        ])));

    return dataRows;
  }
}
