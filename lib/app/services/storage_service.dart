import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _id = "id";
  static const _name = "name";
  static const _email = "email";
  static const _imageUrl = "image_url";
  static const _roleId = "role_id";
  static const _provider = "provider";
  static const _createAt = "create_at";
  static const _updateAt = "update_at";

  Future<void> saveUser(Map<String, dynamic> user) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(_id, user["id"]);
    pref.setString(_name, user["name"]);
    pref.setString(_email, user["email"]);
    pref.setString(_imageUrl, user["image_url"]);
    pref.setString(_roleId, user["role_id"]);
    pref.setString(_provider, user["provider"]);
    pref.setString(_createAt, (user["create_at"] as Timestamp).toDate().toString());
    pref.setString(_updateAt, (user["update_at"] as Timestamp).toDate().toString());
  }

  Future<UserModel> loadUser() async {
    final pref = await SharedPreferences.getInstance();

    return UserModel(
      id: pref.getString(_id)!,
      email: pref.getString(_email)!,
      imageUrl: pref.getString(_imageUrl)!,
      name: pref.getString(_name)!,
      roleId: pref.getString(_roleId)!,
      provider: _provider,
      createAt:  DateTime.parse(pref.getString(_createAt)!),
      updateAt: DateTime.parse(pref.getString(_updateAt)!),
    );
  }
}
