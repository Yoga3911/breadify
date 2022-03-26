import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ProductModel productFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
        required this.name,
        required this.price,
        required this.quantity,
        required this.categoryId,
        required this.image,
        required this.createAt,
        required this.updateAt,
    });

    final String name;
    final int price;
    final int quantity;
    final String categoryId;
    final String image;
    final Timestamp createAt;
    final Timestamp updateAt;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        categoryId: json["category_id"],
        image: json["image"],
        createAt: json["create_at"],
        updateAt: json["update_at"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "quantity": quantity,
        "category_id": categoryId,
        "image": image,
        "create_at": createAt,
        "update_at": updateAt,
    };
}
