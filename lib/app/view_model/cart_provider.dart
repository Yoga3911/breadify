import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Future<List<CartModel>> getAll(String userId) async {
    final data =
        await MyCollection.cart.where("user_id", isEqualTo: userId).get();

    return <CartModel>[
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        CartModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }
}
