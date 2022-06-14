import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
    UserModel({
        required this.id,
        required this.email,
        required this.password,
        required this.imageUrl,
        required this.name,
        required this.roleId,
        required this.provider,
        required this.fcmToken,
        required this.bmoney,
        required this.createAt,
        required this.updateAt,
        required this.isActive,
    });

    final String id;
    final String email;
    final String password;
    final String imageUrl;
    final String name;
    final String roleId;
    final String provider;
    final int bmoney;
    final String fcmToken;
    final DateTime createAt;
    final DateTime updateAt;
    final bool isActive;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        imageUrl: json["image_url"],
        name: json["name"],
        roleId: json["role_id"],
        provider: json["provider"],
        fcmToken: json["fcmToken"],
        bmoney: json["bmoney"],
        isActive: json["isActive"],
        createAt: (json["create_at"] as Timestamp).toDate(),
        updateAt: (json["update_at"] as Timestamp).toDate(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "image_url": imageUrl,
        "name": name,
        "role_id": roleId,
        "fcmToken": fcmToken,
        "provider": provider,
        "bmoney": bmoney,
        "isActive": isActive,
        "create_at": createAt,
        "update_at": updateAt,
    };
}
