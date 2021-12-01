import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/cart_item.dart';
import 'package:kiloin/models/mission.dart';
import 'package:kiloin/repository/cart_item_repository.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/ui/widgets/transaction_item.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

class InputTransactionScreen extends StatefulWidget {
  const InputTransactionScreen({Key? key}) : super(key: key);

  @override
  _InputTransactionScreenState createState() => _InputTransactionScreenState();
}

class _InputTransactionScreenState extends State<InputTransactionScreen> {
  GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();
  TextEditingController weightController = TextEditingController();
  String selectedUser = "";
  String selectedItem = "";
  // Future _futureAllUsers = userRef.where('role', 'user').get();

  List<String> items = [
    "Plastik",
    "Logam",
    "Kertas",
  ];

  List<String> users = [
    "A",
    "P",
    "C",
  ];

  static List<Mission> missions = [
    Mission(name: "Makan babi"),
    Mission(name: "Jadi islam"),
  ];

  List selectedMission = [];

  final itemsMission = missions
      .map((mission) => MultiSelectItem(mission, mission.name!))
      .toList();

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
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
              height: 15.h,
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
                FutureBuilder(
                    // future: _futureAllUsers,
                    builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // var listUsers =
                    //     snapshot.data!.data() as Map<String, dynamic>;
                  }

                  return Center(child: CircularProgressIndicator());
                }),
                DropdownButtonFormField(
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedUser = newValue!;
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            5.r,
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: grayPure,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            5.r,
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: lightGreen,
                          ))),
                  hint: Text(
                    "User",
                  ),
                  items: users
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                ),
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Add item",
                                  ),
                                  content: SizedBox(
                                    height: 200.h,
                                    child: Form(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          DropdownButtonFormField(
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedItem = newValue!;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                            ),
                                            decoration: InputDecoration(
                                                isDense: true,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          5.r,
                                                        ),
                                                        borderSide: BorderSide(
                                                          width: 2,
                                                          color: grayPure,
                                                        )),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          5.r,
                                                        ),
                                                        borderSide: BorderSide(
                                                          width: 2,
                                                          color: lightGreen,
                                                        ))),
                                            hint: Text(
                                              "Jenis sampah",
                                            ),
                                            items: items
                                                .map(
                                                    (value) => DropdownMenuItem(
                                                          child: Text(value),
                                                          value: value,
                                                        ))
                                                .toList(),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            "Berat:",
                                          ),
                                          TextFormField(
                                            controller: weightController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Masukkan berat sampah(kg)",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: redDanger,
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          "Batal",
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          final repository =
                                              Provider.of<CartItemRepository>(
                                                  context,
                                                  listen: false);
                                          repository.addItem(CartItem(
                                              selectedItem,
                                              int.parse(
                                                  weightController.text)));
                                          Navigator.of(context).pop();
                                          weightController.text = '';
                                        },
                                        child: Text(
                                          "Submit",
                                        ))
                                  ],
                                );
                              });
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
                          columnSpacing: 30,
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
                              : itemEmpty());
                    })),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Pilih misi yang tercapai",
                ),
                MultiSelectDialogField(
                  chipDisplay: MultiSelectChipDisplay(
                    scroll: true,
                    chipColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  items: itemsMission,
                  onConfirm: (value) {
                    selectedMission = value;
                  },
                  initialValue: selectedMission,
                ),
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
