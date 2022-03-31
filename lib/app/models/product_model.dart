import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "category_id": categoryId,
        "store_id": storeId,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
      };
}
