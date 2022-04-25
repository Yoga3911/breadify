import 'package:firebase_auth/firebase_auth.dart';

abstract class SocialService {
  String name = "";
  Future<UserCredential> signIn();
  Future<void> signOut();
}