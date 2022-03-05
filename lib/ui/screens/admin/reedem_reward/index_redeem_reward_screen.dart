import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kiloin/models/reedemed_reward.dart';
import 'package:kiloin/ui/screens/admin/reedem_reward/detail_reedem_reward_screen.dart';
import 'package:kiloin/ui/screens/admin/reedem_reward/edit_redeem_reward.dart';
import 'package:kiloin/ui/widgets/snackbar.dart';

import '../../../../models/user.dart' as UserModel;
import '../../../../shared/color.dart';
import '../../../../shared/font.dart';
import '../../../widgets/admin_drawer.dart';

class AdminIndexRedeemRewardScreen extends StatefulWidget {
  const AdminIndexRedeemRewardScreen({Key? key}) : super(key: key);

  @override
  _AdminIndexRedeemRewardScreenState createState() =>
      _AdminIndexRedeemRewardScreenState();
}

class _AdminIndexRedeemRewardScreenState
    extends State<AdminIndexRedeemRewardScreen> {
  int dropdownValue = 10;
  TextEditingController searchController = TextEditingController();
  List<int> dropdownValues = [
    10,
    25,
    50,
  ];

  Future<List<RedeemedReward>>? _futureItems;

  Future<List<RedeemedReward>> _filterItems() async {
    var rewards = <RedeemedReward>[];

    if (searchController.text.trim() != '') {
      var searchQuery = searchController.text.trim().toLowerCase();
      var rewardName = await FirebaseFirestore.instance
          .collection('user_redeemed_rewards')
          .where('user.name', isGreaterThanOrEqualTo: searchQuery)
          .where('user.name', isLessThan: searchQuery + 'z')
          .get();

      var data = [];
      data.addAll(rewardName.docs);
      rewards.addAll(
        data.map((e) => RedeemedReward.fromJson(e.data(), id: e.id)).toList(),
      );
    } else {
      var result = await FirebaseFirestore.instance
          .collection('user_redeemed_rewards')
          .get();
      rewards = result.docs
          .map((e) => RedeemedReward.fromJson(e.data(), id: e.id))
          .toList();
    }

    return rewards;
  }

  @override
  void initState() {
    super.initState();
    _futureItems = _filterItems();
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
          "Redeem Reward",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ListView(children: [
        FutureBuilder<List<RedeemedReward>>(
          future: _futureItems,
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
                            _futureItems = _filterItems();
                          });
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                              8.r,
                            )),
                            hintText: "Cari redeem",
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
                  ),
                  DataColumn(
                    label: Text("Nama user"),
                  ),
                  DataColumn(
                    label: Text("Hadiah"),
                  ),
                  DataColumn(
                    label: Text("Petugas"),
                  ),
                  DataColumn(
                    label: Text("Status"),
                  ),
                  DataColumn(
                    label: Text("Dibuat pada"),
                  ),
                  DataColumn(
                    label: Text("Update pada"),
                  ),
                  DataColumn(
                    label: Text("Aksi"),
                  ),
                ],
                source: AdminDataItem(
                  context: context,
                  data: snapshot.data!,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: darkGreen,
              ),
            );
          },
        ),
      ]),
    );
  }
}

class AdminDataItem extends DataTableSource {
  final List<RedeemedReward> data;
  final BuildContext context;

  AdminDataItem({
    required this.data,
    required this.context,
  });

  detailPage(RedeemedReward redeemedReward) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AdminDetailRedeemRewardScreen(
        redeemedReward: redeemedReward,
      ),
    ));
  }

  confirmFunc(RedeemedReward redeemedReward, BuildContext context) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      var petugasId = FirebaseAuth.instance.currentUser!.uid;
      var redeemRef = FirebaseFirestore.instance
          .collection("user_redeemed_rewards")
          .doc(redeemedReward.id);
      var petugasRef = await FirebaseFirestore.instance
          .collection("users")
          .doc(petugasId)
          .get();
      var petugasData = UserModel.User.fromJson(
        petugasRef.data()!,
        id: petugasId,
      );

      await redeemRef.update({
        "status": "done",
        "updated_at": DateTime.now(),
        "petugas": petugasData.toJson(),
      });

      return true;
    }).then((value) {
      Navigator.of(context).pop();
      CustomSnackbar.buildSnackbar(context, "Sukses mengonfirmasi", 1);
    }).catchError((error) {
      Navigator.of(context).pop();
      CustomSnackbar.buildSnackbar(
          context, "Gagal karena " + error.toString(), 0);
    });
  }

  @override
  DataRow? getRow(int index) {
    RedeemedReward redeemedReward = data[index];
    return DataRow(cells: [
      DataCell(
        Text((index + 1).toString()),
        onTap: () => detailPage(redeemedReward),
      ),
      DataCell(
        Text(
          redeemedReward.user!.name!,
        ),
        onTap: () => detailPage(redeemedReward),
      ),
      DataCell(
        Text(
          redeemedReward.reward!.name!,
        ),
        onTap: () => detailPage(redeemedReward),
      ),
      DataCell(
        Text(
          (redeemedReward.petugas!.name) == ""
              ? "-"
              : redeemedReward.petugas!.name!,
        ),
        onTap: () => detailPage(redeemedReward),
      ),
      DataCell(
        Text(
          redeemedReward.status!,
        ),
        onTap: () => detailPage(redeemedReward),
      ),
      DataCell(
        Text(
          DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(
              redeemedReward.created_at!.microsecondsSinceEpoch)),
        ),
        onTap: () => detailPage(redeemedReward),
      ),
      DataCell(
        Text(
          DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(
              redeemedReward.updated_at!.microsecondsSinceEpoch)),
        ),
        onTap: () => detailPage(redeemedReward),
      ),
      DataCell(
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
                            text: "Anda yakin ingin mengonfirmasi reward ",
                            style: regularRobotoFont.copyWith(
                              fontSize: 14.sp,
                              color: darkGreen,
                            ),
                            children: [
                              TextSpan(
                                text: redeemedReward.reward!.name,
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
                              confirmFunc(
                                redeemedReward,
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
              Icons.edit,
              color: darkGreen,
            )),
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
