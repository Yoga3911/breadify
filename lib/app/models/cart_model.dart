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
  bool isChecked = false;

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
}
