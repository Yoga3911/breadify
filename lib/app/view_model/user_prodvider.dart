import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  get getUser => _user;

  set setUser(User userCredential) => _user = userCredential;
}