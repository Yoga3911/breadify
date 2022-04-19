import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/collection.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get getUser => _user!;

  set setUser(UserModel userModel) => _user = userModel;

  Future<UserModel> getUserById(String userId) async {
    final data = await MyCollection.user.where("id", isEqualTo: userId).get();
    return UserModel.fromJson(data.docs.first.data() as Map<String, dynamic>);
  }

  Future<UserModel> getByDocId() async {
    final pref = await SharedPreferences.getInstance();
    final data = await MyCollection.user.doc(pref.getString("id")).get();
    return UserModel.fromJson(data.data() as Map<String, dynamic>);
  }

  Future<void> getUserByEmail({String? email}) async {
    final data = await MyCollection.user.where("email", isEqualTo: email).get();
    await StorageService()
        .saveUser(data.docs.first.data() as Map<String, dynamic>);

    await StorageService().saveId(data.docs.first["id"]);
    setUser =
        UserModel.fromJson(data.docs.first.data() as Map<String, dynamic>);
  }

  Future<void> insertUser(
      {String? email,
      String? password,
      String? img,
      String? name,
      String? provider}) async {
    QuerySnapshot<Object?> account =
        await MyCollection.user.where("email", isEqualTo: email).get();
    final collection = MyCollection.user.doc();
    if (account.docs.isEmpty) {
      await collection.set(
        UserModel(
          id: collection.id,
          email: email!,
          password: password ?? "-",
          imageUrl: img!,
          name: name!,
          roleId: "1",
          provider: provider!,
          createAt: DateTime.now(),
          updateAt: DateTime.now(),
        ).toJson(),
      );
    }
  }
}
