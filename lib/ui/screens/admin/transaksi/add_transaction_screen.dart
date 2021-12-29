import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/cart_item.dart';
import 'package:kiloin/models/mission.dart';
import 'package:kiloin/models/user.dart';
import 'package:kiloin/repository/transaction_repository.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:kiloin/ui/screens/admin/transaksi/add_cart_item_screen.dart';
import 'package:kiloin/ui/screens/admin/transaksi/edit_cart_item_screen.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class AdminAddTransactionScreen extends StatefulWidget {
  const AdminAddTransactionScreen({Key? key}) : super(key: key);
  static String routeName = "/officer_add_transaction";

  @override
  _AdminAddTransactionScreenState createState() =>
      _AdminAddTransactionScreenState();
}

class _AdminAddTransactionScreenState extends State<AdminAddTransactionScreen> {
  GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();
  TextEditingController weightController = TextEditingController();

  Future<List<User>>? fetchUsers;
  Future<Map<String, Mission>>? fetchMissions;

  Future<List<User>> _fetchUsers() async {
    var users = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'user')
        .limit(10)
        .get();
    return users.docs.map((e) => User.fromJson(e.data())).toList();
  }

  Future<List<Mission>> _fetchMissions(String userId) async {
    var completedMissionsByUser = await FirebaseFirestore.instance
        .collection('user_completed_missions')
        .where('user_id', isEqualTo: userId)
        .where('role', isEqualTo: 'user')
        .get();
    var completedMissionIds = completedMissionsByUser.docs
        .map((e) => e.exists ? e.data()['mission_id'] : null)
        .whereType<String>()
        .toList();
    QuerySnapshot<Map<String, dynamic>> missions;
    if (completedMissionIds.isNotEmpty) {
      missions = await FirebaseFirestore.instance
          .collection('missions')
          .where('is_active', isEqualTo: true)
          .where('hidden', isEqualTo: false)
          .where(FieldPath.documentId, whereNotIn: completedMissionIds)
          .get();
    } else {
      missions = await FirebaseFirestore.instance
          .collection('missions')
          .where('is_active', isEqualTo: true)
          .where('hidden', isEqualTo: false)
          .get();
    }

    return missions.docs
        .map((e) => Mission.fromJson(e.data(), id: e.id))
        .toList();
  }

  @override
  void initState() {
    fetchUsers = _fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        leading: IconButton(
            onPressed: () {
              final repository = Provider.of<TransactionRepository>(
                context,
                listen: false,
              );
              repository.removeAllItem();
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
            )),
        automaticallyImplyLeading: false,
        title: Text(
          "Input transaksi",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: 100.h,
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
                Consumer<TransactionRepository>(
                    builder: (context, repository, child) {
                  return Text(
                    repository.getTotalPrice().toString(),
                  );
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Exp yg didapat:"),
                Consumer<TransactionRepository>(
                    builder: (context, repository, child) {
                  return Text(
                    repository.getTotalXp().toString(),
                  );
                })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Balance yg didapat:"),
                Consumer<TransactionRepository>(
                    builder: (context, repository, child) {
                  return Text(
                    repository.getTotalBalance().toString(),
                  );
                })
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  await submitData();
                },
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
                                .where('role', isEqualTo: 'user')
                                .limit(10)
                                .get();
                            return users.docs
                                .map((e) => User.fromJson(e.data(), id: e.id))
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
                              .map((e) => User.fromJson(e.data(), id: e.id))
                              .toList();
                        },
                        label: "Cari user",
                        itemAsString: (User? user) => user!.email.toString(),
                        showSearchBox: true,
                        onChanged: (User? user) {
                          if (user == null) {
                            return;
                          }

                          final repository = Provider.of<TransactionRepository>(
                              context,
                              listen: false);
                          repository.setFutureListMission(
                              _fetchMissions(user.id.toString()));
                          repository.setUserId(user.id.toString());
                        },
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
                    child: Consumer<TransactionRepository>(
                        builder: (context, repository, child) {
                      List<CartItem> items = repository.cartItems;
                      return DataTable(
                        columns: [
                          DataColumn(
                              label: SizedBox(
                            width: 60.w,
                            child: Text(
                              "Jenis",
                            ),
                          )),
                          DataColumn(
                              numeric: true,
                              label: SizedBox(
                                width: 60.w,
                                child: Text(
                                  "Berat(kg)",
                                ),
                              )),
                          DataColumn(
                              numeric: true,
                              label: SizedBox(
                                width: 60.w,
                                child: Text(
                                  "Harga",
                                ),
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
                Consumer<TransactionRepository>(
                    builder: (context, repository, child) {
                  if (repository.userId == null) {
                    return Text('Kosong');
                  }
                  return FutureBuilder<List<Mission>>(
                      future: repository.futureListMission,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasData) {
                          final repository = Provider.of<TransactionRepository>(
                              context,
                              listen: false);

                          if (snapshot.data!.length > 0) {
                            return MultiSelectDialogField(
                                chipDisplay: MultiSelectChipDisplay(
                                  scroll: true,
                                  chipColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                items: snapshot.data!
                                    .map(
                                      (e) => MultiSelectItem(
                                        e,
                                        e.name.toString(),
                                      ),
                                    )
                                    .toList(),
                                onConfirm: (value) {
                                  repository.setMissions(value.cast<Mission>());
                                });
                          } else {
                            return Text(
                                'Tidak ada misi yang bisa diselesaikan');
                          }
                        }

                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return SizedBox();
                      });
                }),
                Consumer(builder: (context, repository, child) {
                  final repository =
                      Provider.of<TransactionRepository>(context);
                  return ListTile(
                    title: Text("Sampah sudah dipisah berdasarkan jenis"),
                    leading: Checkbox(
                        value: repository.isSampahChecked,
                        onChanged: (bool) {
                          repository.setCheckBox(bool!);
                        }),
                  );
                })
              ],
            )),
      ),
    );
  }

  Future<dynamic> submitData() async {
    FirebaseFirestore.instance
        .runTransaction((transaction) async {
          final repository =
              Provider.of<TransactionRepository>(context, listen: false);
          var userRef = FirebaseFirestore.instance
              .collection('users')
              .doc(repository.userId);
          var user = await userRef.get();
          var userData = User.fromJson(user.data()!, id: user.id);
          var pegawaiRef = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
          var pegawaiData =
              User.fromJson(pegawaiRef.data()!, id: pegawaiRef.id);

          if (!user.exists) {
            throw Exception('User tidak ditemukan');
          }

          double totalExp = 0;
          double totalBalance = 0;

          var transaction =
              await FirebaseFirestore.instance.collection('transactions').add({
            'created_at': DateTime.now(),
            'user': userData.toJson(),
            'petugas': pegawaiData.toJson()
          });

          repository.cartItems.forEach((cart) async {
            await FirebaseFirestore.instance
                .collection('transaction_items')
                .add({
              'transaction_id': transaction.id,
              'item': cart.item.toJson(),
              'qty': cart.qty
            });
            totalExp += cart.item.exp_point! * cart.qty;
            totalBalance += cart.item.balance_point! * cart.qty;
          });

          if (repository.missions.isNotEmpty) {
            var listMissions = await FirebaseFirestore.instance
                .collection('missions')
                .where(FieldPath.documentId,
                    whereIn: repository.missions.map((m) => m.id).toList())
                .get();

            if (listMissions.docs.length != repository.missions.length) {
              throw Exception(
                  'Data misi tidak valid Silahkan coba buka ulang fitur tambah transaksi');
            }

            for (var mission in repository.missions) {
              await FirebaseFirestore.instance
                  .collection('user_completed_missions')
                  .add({
                "created_at": DateTime.now(),
                "user_id": repository.userId,
                "transaction_id": transaction.id
              });
              totalExp += mission.exp!;
              totalBalance += mission.balance!;
            }
          }

          if (repository.isSampahChecked) {
            var bonusMilahSampah = await FirebaseFirestore.instance
                .collection('missions')
                .doc('bonus-milah-sampah')
                .get();

            if (bonusMilahSampah.exists) {
              var bonusData = Mission.fromJson(bonusMilahSampah.data()!);
              totalBalance += bonusData.balance!;
              totalExp += bonusData.exp!;
            }
          }

          userRef.update({
            'exp': totalExp + userData.exp!,
            'balance': totalBalance + userData.balance!,
          });

          return true;
        })
        .then((v) => print("apakah mari? " + v.toString()))
        .catchError((error) => print(error.toString() + " ini eror"));
    // check mission
    // check user
    // insert transactions
    // insert transaction_items
    // insert user_completed_missions
    // update balance user
    // update exp user
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
    final repoTrans =
        Provider.of<TransactionRepository>(context, listen: false);
    items.forEach((CartItem item) => dataRows.add(DataRow(cells: [
          DataCell(
            Text(item.item.name.toString()),
          ),
          DataCell(Text(
            item.qty.toString(),
          )),
          DataCell(Text(
            item.getTotalPrice().toString(),
          )),
          DataCell(Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditCartItemFormScreen(item),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: darkGreen,
                  )),
              IconButton(
                  onPressed: () {
                    repoTrans.removeItem(item);
                  },
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
