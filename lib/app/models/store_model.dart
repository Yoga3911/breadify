import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  const StoreModel({
    required this.id,
    required this.address,
    required this.open,
    required this.close,
    required this.storeName,
    required this.userId,
    required this.createAt,
    required this.updateAt,
  });

  final String id;
  final String address;
  final String open;
  final String close;
  final String storeName;
  final String userId;
  final DateTime createAt;
  final DateTime updateAt;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json["id"],
        address: json["address"],
        open: json["open"],
        close: json["close"],
        storeName: json["store_name"],
        userId: json["user_id"],
        createAt: (json["create_at"] as Timestamp).toDate(),
        updateAt: (json["update_at"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "open": open,
        "close": close,
        "store_name": storeName,
        "user_id": userId,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
      };
}
