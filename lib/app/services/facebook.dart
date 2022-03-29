import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookService {
  FacebookService._();

  static Future<UserCredential> signIn() async {
    try {
      final LoginResult _user = await FacebookAuth.instance.login();
      final OAuthCredential _credential =
          FacebookAuthProvider.credential(_user.accessToken!.token);
      log("Login success!");

      return FirebaseAuth.instance.signInWithCredential(_credential);
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
    log("Success logout from facebook account!");
  }
}
