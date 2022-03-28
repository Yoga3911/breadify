import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.email,
        required this.id,
        required this.imageUrl,
        required this.name,
        required this.roleId,
        required this.provider,
        required this.storeName,
        required this.createAt,
        required this.updateAt,
    });

    final String email;
    final String id;
    final String imageUrl;
    final String name;
    final String roleId;
    final String provider;
    final String storeName;
    final Timestamp createAt;
    final Timestamp updateAt;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        id: json["id"],
        imageUrl: json["image_url"],
        name: json["name"],
        roleId: json["role_id"],
        provider: json["provider"],
        storeName: json["store_name"],
        createAt: json["create_at"],
        updateAt: json["update_at"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "image_url": imageUrl,
        "name": name,
        "role_id": roleId,
        "provider": provider,
        "store_name": storeName,
        "create_at": createAt,
        "update_at": updateAt,
    };
}
