import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
        required this.name,
        required this.price,
        required this.quantity,
        required this.image,
        required this.categoryId,
        required this.createAt,
        required this.updateAt,
        required this.sellerData,
    });

    final String name;
    final int price;
    final int quantity;
    final String categoryId;
    final String image;
    final Timestamp createAt;
    final Timestamp updateAt;
    final SellerData sellerData;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        categoryId: json["category_id"],
        image: json["image"],
        createAt: json["create_at"],
        updateAt: json["update_at"],
        sellerData: SellerData.fromJson(json["seller_data"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "quantity": quantity,
        "category_id": categoryId,
        "create_at": createAt,
        "update_at": updateAt,
        "seller_data": sellerData.toJson(),
    };
}

class SellerData {
    SellerData({
        required this.storeName,
        required this.userId,
    });

    final String storeName;
    final String userId;

    factory SellerData.fromJson(Map<String, dynamic> json) => SellerData(
        storeName: json["store_name"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "store_name": storeName,
        "user_id": userId,
    };
}
