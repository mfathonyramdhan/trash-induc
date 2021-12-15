import 'package:flutter/material.dart';
import 'package:kiloin/models/cart_item.dart';
import 'package:kiloin/models/mission.dart';

class TransactionRepository extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  Future<List<Mission>>? _futureListMissions;

  List<CartItem> get cartItems => _cartItems;

  Future<List<Mission>>? get futureListMission => _futureListMissions;

  String? _selectedUserId;
  List<Mission> _missions = [];

  String? get userId => _selectedUserId;
  List<Mission> get missions => _missions;

  bool _isSampahChecked = false;
  bool get isSampahChecked => _isSampahChecked;

  void setFutureListMission(Future<List<Mission>> future) {
    _futureListMissions = future;
  }

  void addItem(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void updateItem(int index) {
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0;
    _cartItems.forEach((CartItem item) {
      total += item.qty * item.price;
    });
    return total;
  }

  double getTotalXp() {
    double totalExp = 0;
    _cartItems.forEach((CartItem item) {
      totalExp += item.qty * item.item.exp_point!;
    });
    return totalExp + (_isSampahChecked ? 5 : 0);
  }

  double getTotalBalance() {
    double totalBalance = 0;
    _cartItems.forEach((CartItem item) {
      totalBalance += item.qty * item.item.balance_point!;
    });
    return totalBalance + (_isSampahChecked ? 5 : 0);
  }

  void setUserId(String userId) {
    _selectedUserId = userId;
    notifyListeners();
  }

  void setMissions(List<Mission> missions) {
    _missions = missions;
    notifyListeners();
  }

  void setCheckBox(bool value) {
    _isSampahChecked = value;
    notifyListeners();
  }

  void removeAllItem() {
    _cartItems = [];
    _missions = [];
    _isSampahChecked = false;
    notifyListeners();
  }
}