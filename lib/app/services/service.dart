import 'package:firebase_auth/firebase_auth.dart';

abstract class Services {
  String name = "";
  Future<UserCredential> signIn();
  Future<void> signOut();
}