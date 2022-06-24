import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/collection.dart';
import '../models/user_model.dart';
import '../utils/hash.dart';

class UserProvider with ChangeNotifier {
  String? _userId;

  set setId(String val) => _userId = val;

  String? get getId => _userId;

  UserModel? _user;

  UserModel get getUser => _user!;

  set setUser(UserModel userModel) => _user = userModel;

  Future<UserModel> getUserById(String userId) async {
    final data = await MyCollection.user.where("id", isEqualTo: userId).get();
    return UserModel.fromJson(data.docs.first.data() as Map<String, dynamic>);
  }

  Future<void> getByDocId() async {
    final pref = await SharedPreferences.getInstance();
    final data = await MyCollection.user.doc(pref.getString("id")).get();
    final userD = MyCollection.user.doc(pref.getString("id"));
    userD.update({
      "isActive": true,
    });
    setUser = UserModel.fromJson(data.data() as Map<String, dynamic>);
  }

  Future<void> getUserByEmail({String? email}) async {
    final data = await MyCollection.user.where("email", isEqualTo: email).get();
    final pref = await SharedPreferences.getInstance();
    MyCollection.user
        .doc(data.docs.first.id)
        .update({"fcmToken": pref.getString("fcmToken")});
    await pref.setString("id", data.docs.first["id"]);
    setUser =
        UserModel.fromJson(data.docs.first.data() as Map<String, dynamic>);
  }

  Future<void> insertUser(
      {String? email,
      String? password,
      String? img,
      String? fcmToken,
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
          fcmToken: fcmToken!,
          isActive: false,
          storeId: "-",
          provider: provider!,
          bmoney: 100000,
          createAt: DateTime.now(),
          updateAt: DateTime.now(),
        ).toJson(),
      );
    }
  }

  Future<void> changeRole({required String userId}) async {
    await MyCollection.user.doc(userId).update({"role_id": '2'});
  }

  Future<bool> checkPassword(
      {required String userId, required String password}) async {
    final plainPass = hashPass(password);
    final data = await MyCollection.user.doc(userId).get();
    final userPass = (data.data() as Map<String, dynamic>)["password"];

    if (userPass == plainPass) {
      return true;
    }
    return false;
  }

  Future<void> changePassword(
      {required String userId, required String password}) async {
    await MyCollection.user
        .doc(userId)
        .update({"password": hashPass(password)});
  }

  Future<void> topup({required String userId, required int bmoney}) async {
    await MyCollection.user.doc(userId).update({"bmoney": bmoney});
  }

  Future<void> updateSaldo(
      {required String userId, required int bmoney}) async {
    log(bmoney.toString());
    await MyCollection.user.doc(userId).update({"bmoney": bmoney});
    log("Saldo dipotong");
  }

  Future<bool> login({required String email, required String password}) async {
    final data = await MyCollection.user
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();

    if (data.docs.first.id.isEmpty) {
      return false;
    }
    return true;
  }
}
