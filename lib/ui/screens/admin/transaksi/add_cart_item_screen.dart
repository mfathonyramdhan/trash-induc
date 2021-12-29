import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiloin/models/cart_item.dart';
import 'package:kiloin/models/item.dart';
import 'package:kiloin/repository/transaction_repository.dart';
import 'package:kiloin/shared/color.dart';
import 'package:kiloin/shared/font.dart';
import 'package:provider/provider.dart';

class CartItemFormScreen extends StatefulWidget {
  const CartItemFormScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartItemFormScreenState createState() => _CartItemFormScreenState();
}

class _CartItemFormScreenState extends State<CartItemFormScreen> {
  TextEditingController weightController = TextEditingController();
  Item? selectedItem;
  Future<List<Item>>? fetchItems;

  Future<List<Item>> _fetchItems() async {
    var items = await FirebaseFirestore.instance.collection('items').get();
    return items.docs.map((i) => Item.fromJson(i.data(), id: i.id)).toList();
  }

  @override
  void initState() {
    fetchItems = _fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Tambah item",
          style: boldRobotoFont.copyWith(
            fontSize: 18.sp,
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder<List<Item>>(
                  future: fetchItems,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    return DropdownButtonFormField<Item>(
                      onChanged: (newValue) {
                        if (newValue == null) {
                          return;
                        }

                        setState(() {
                          selectedItem = newValue;
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
                        "Jenis sampah",
                      ),
                      items: snapshot.hasData
                          ? snapshot.data!
                              .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value.name.toString() +
                                          " - " +
                                          value.sell.toString() +
                                          "/kg",
                                    ),
                                    value: value,
                                  ))
                              .toList()
                          : [],
                    );
                  }),
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
                  hintText: "Masukkan berat sampah(kg)",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final repository = Provider.of<TransactionRepository>(
                    context,
                    listen: false,
                  );
                  repository.addItem(
                    CartItem(
                      selectedItem!,
                      selectedItem!.name!,
                      double.tryParse(
                              weightController.text.replaceAll(',', '.'))!
                          .toDouble(),
                      selectedItem!.sell!.toDouble(),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: Text("Tambahkan data"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
