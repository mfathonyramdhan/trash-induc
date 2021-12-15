import 'package:kiloin/models/item.dart';

class CartItem {
  Item item;
  String type;
  double qty;
  double price;

  CartItem(
    this.item,
    this.type,
    this.qty,
    this.price,
  );
}
