import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {  
  Future<UserCredential> signIn() async {
    try {
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? auth = await user?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth?.accessToken,
        idToken: auth?.idToken,
      );

      log("Login success");

      return FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    log("Success log out from google account");
  }
}
