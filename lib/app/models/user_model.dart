import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
    UserModel({
        required this.email,
        required this.id,
        required this.imageUrl,
        required this.name,
        required this.roleId,
        required this.provider,
        required this.createAt,
        required this.updateAt,
    });

    final String email;
    final String id;
    final String imageUrl;
    final String name;
    final String roleId;
    final String provider;
    final DateTime createAt;
    final DateTime updateAt;

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        id: json["id"],
        imageUrl: json["image_url"],
        name: json["name"],
        roleId: json["role_id"],
        provider: json["provider"],
        createAt: (json["create_at"] as Timestamp).toDate(),
        updateAt: (json["update_at"] as Timestamp).toDate(),
    );

    Map<String, dynamic> toMap() => {
        "email": email,
        "id": id,
        "image_url": imageUrl,
        "name": name,
        "role_id": roleId,
        "provider": provider,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
    };
}
