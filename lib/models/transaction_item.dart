import 'package:kiloin/models/item.dart';

class TransactionItem {
  final String? transaction_id;
  final Item? item;
  final double? qty;

  TransactionItem({
    this.transaction_id,
    this.item,
    this.qty,
  });

  TransactionItem.fromJson(Map<String, dynamic> json)
      : this(
          transaction_id: json["transaction_id"],
          item: Item.fromJson(json["item"]),
          qty: json["qty"],
        );
}
