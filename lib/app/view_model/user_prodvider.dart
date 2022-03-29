import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? _seller;

  get getUser => _user;
  get getSeller => _seller;

  set setUser(User userCredential) => _user = userCredential;
  set setSeller(User userCredential) => _seller = userCredential;
}