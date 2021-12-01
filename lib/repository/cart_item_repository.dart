import 'package:flutter/cupertino.dart';
import 'package:kiloin/models/cart_item.dart';

class CartItemRepository extends ChangeNotifier {
  List<CartItem> items = [];

  List<CartItem> getAllCartItem() {
    return items;
  }

  void addItem(CartItem item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  void updateItem(int index) {}
}
