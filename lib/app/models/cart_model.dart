import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  CartModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  final String id;
  final String userId;
  final String productId;
  final int quantity;
  bool _isChecked = false;
  int _totalItem = 0;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
      };

  set setChecked(bool val) {
    _isChecked = val;
    notifyListeners();
  }

  bool get getChecked => _isChecked;

  set setTotalItem(int val) {
    _totalItem += val;
    notifyListeners();
  }

  int get getTotalItem => _totalItem;
}
