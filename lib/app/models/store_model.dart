import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

StoreModel storeModelFromJson(String str) => StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
    StoreModel({
        required this.address,
        required this.open,
        required this.close,
        required this.storeName,
        required this.userId,
        required this.createAt,
        required this.updateAt,
    });

    final String address;
    final String open;
    final String close;
    final String storeName;
    final String userId;
    final Timestamp createAt;
    final Timestamp updateAt;

    factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        address: json["address"],
        open: json["open"],
        close: json["close"],
        storeName: json["store_name"],
        userId: json["user_id"],
        createAt: json["create_at"],
        updateAt: json["update_at"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "open": open,
        "close": close,
        "store_name": storeName,
        "user_id": userId,
        "create_at": createAt,
        "update_at": updateAt,
    };
}
