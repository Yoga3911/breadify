import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
    const UserModel({
        required this.id,
        required this.email,
        required this.imageUrl,
        required this.name,
        required this.roleId,
        required this.provider,
        required this.createAt,
        required this.updateAt,
    });

    final String id;
    final String email;
    final String imageUrl;
    final String name;
    final String roleId;
    final String provider;
    final DateTime createAt;
    final DateTime updateAt;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        imageUrl: json["image_url"],
        name: json["name"],
        roleId: json["role_id"],
        provider: json["provider"],
        createAt: (json["create_at"] as Timestamp).toDate(),
        updateAt: (json["update_at"] as Timestamp).toDate(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "image_url": imageUrl,
        "name": name,
        "role_id": roleId,
        "provider": provider,
        "create_at": createAt,
        "update_at": updateAt,
    };
}
