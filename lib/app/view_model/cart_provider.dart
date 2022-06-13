import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  int _total = 0;
  bool _isSelectAll = false;
  int _totalMoney = 0;

  List<CartModel> cartData = [];
  List<CartModel> cartDataCheckout = [];

  set setTotal(int val) {
    _total += val;
    notifyListeners();
  }

  int get getTotal => _total;

  List<CartModel> _cartData = [];

  Future<void> getById(String userId) async {
    final data =
        await MyCollection.cart.where("user_id", isEqualTo: userId).get();

    _cartData = <CartModel>[
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        CartModel.fromJson(item.data() as Map<String, dynamic>)
    ];

    for (CartModel model in _cartData) {
      model.setTotalItem = model.quantity;
    }
    notifyListeners();
  }

  List<CartModel> get getCartData => _cartData;

  set setSelectAll(bool val) => _isSelectAll = val;
  bool get getSelectAll => _isSelectAll;

  set setTotalMoney(int val) {
    _totalMoney += val;
    notifyListeners();
  }

  int get getTotalMoney => _totalMoney;
}
