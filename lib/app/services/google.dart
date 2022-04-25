import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/app/services/service.dart';

class GoogleService extends SocialService {
  @override
  Future<UserCredential> signIn() async {
    try {
      final GoogleSignInAccount? _user = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? _auth = await _user?.authentication;
      final _credential = GoogleAuthProvider.credential(
        accessToken: _auth?.accessToken,
        idToken: _auth?.idToken,
      );
      log("Login success!");

      return FirebaseAuth.instance.signInWithCredential(_credential);
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    log("Success logout from google account!");
  }
}
