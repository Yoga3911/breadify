import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.categoryId,
    required this.storeId,
    required this.createAt,
    required this.updateAt,
    required this.isChecked,
  });

  final String id;
  final String name;
  final int price;
  final int quantity;
  final String image;
  final String categoryId;
  final String storeId;
  final DateTime createAt;
  final DateTime updateAt;
  bool isChecked;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        image: json["image"],
        categoryId: json["category_id"],
        storeId: json["store_id"],
        createAt: (json["create_at"] as Timestamp).toDate(),
        updateAt: (json["update_at"] as Timestamp).toDate(),
        isChecked: json["is_checked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "category_id": categoryId,
        "image": image,
        "store_id": storeId,
        "create_at": createAt,
        "update_at": updateAt,
        "is_checked": isChecked,
      };

  int _total = 0;

  set setTotal(int val) {
    _total += val;
    notifyListeners();
  }

  int get getTotal => _total;

  set setChecked(bool value) {
    isChecked = value;
    notifyListeners();
  }
}
