import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant/collection.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? _seller;

  User get getUser => _user!;
  User get getSeller => _seller!;

  set setUser(User userCredential) => _user = userCredential;
  set setSeller(User userCredential) => _seller = userCredential;

  Future<UserModel> getUserById(String userId) async {
    final data = await MyCollection.user.doc(userId).get();
    return UserModel.fromJson(data.data() as Map<String, dynamic>);
  }
}
