import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  int _total = 0;
  bool _isSelectAll = false;
  int _totalMoney = 0;
  bool isChange = false;

  List<CartModel> cartData = [];
  List<CartModel> cartDataCheckout = [];

  set setTotal(int val) {
    _total += val;
    notifyListeners();
  }

  set setIsChange(bool val) {
    isChange = val;
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

  Future<void> addToCart({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    checkCartExist(productId: productId, userId: userId).then((isExist) async {
      if (isExist.isNotEmpty) {
        MyCollection.cart.doc(isExist["id"]).update(
          {
            "quantity": quantity + isExist["quantity"] as int,
          },
        );
        return;
      }
      final cart = MyCollection.cart.doc();
      await cart.set(
        CartModel(
          id: cart.id,
          userId: userId,
          productId: productId,
          quantity: quantity,
        ).toJson(),
      );
    });
  }

  Future<Map<String, dynamic>> checkCartExist({
    required String productId,
    required String userId,
  }) async {
    final data = await MyCollection.cart
        .where("product_id", isEqualTo: productId)
        .where("user_id", isEqualTo: userId)
        .get();

    if (data.docs.isEmpty) {
      return {};
    }
    return {
      "id": data.docs.first.id,
      "quantity": data.docs.first["quantity"],
    };
  }

  Future<void> deleteItem({required String cartId}) async {
    await MyCollection.cart.doc(cartId).delete();
  }
}