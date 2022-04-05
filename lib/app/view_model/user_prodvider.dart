import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/collection.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get getUser => _user!;

  set setUser(UserModel userModel) => _user = userModel;

  Future<UserModel> getUserById(String userId) async {
    final data = await MyCollection.user.doc(userId).get();
    return UserModel.fromJson(data.data() as Map<String, dynamic>);
  }

  Future<UserModel> getByDocId() async {
    final pref = await SharedPreferences.getInstance();
    final data = await MyCollection.user.doc(pref.getString("id")).get();
    return UserModel.fromJson(data.data() as Map<String, dynamic>);
  }
}
