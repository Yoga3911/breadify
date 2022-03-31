import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? _seller;

  get getUser => _user;
  get getSeller => _seller;

  set setUser(User userCredential) => _user = userCredential;
  set setSeller(User userCredential) => _seller = userCredential;

  Future<UserModel> getUserById(String userId) async {
    final data = await MyCollection.user.doc(userId).get();
    return UserModel.fromJson(data.data() as Map<String, dynamic>);
  }
}
