import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  int _total = 0;

  set setTotal(int val) {
    _total += val;
    notifyListeners();
  }

  int get getTotal => _total;

  Future<List<CartModel>> getById(String userId) async {
    final data =
        await MyCollection.cart.where("user_id", isEqualTo: userId).get();

    return <CartModel>[
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        CartModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }
}
