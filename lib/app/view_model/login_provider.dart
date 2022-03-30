import 'package:flutter/cupertino.dart';
import 'package:project/app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/collection.dart';
import '../routes/route.dart';
import '../services/facebook.dart';
import '../services/google.dart';
import 'user_prodvider.dart';

enum Social { google, facebook }

class LoginProvider with ChangeNotifier {
  Future<void> signIn(
      BuildContext context, UserProvider _user, Social social) async {
    const String _blank =
        "https://firebasestorage.googleapis.com/v0/b/breadify-a4a04.appspot.com/o/user.png?alt=media&token=30e27068-d2ff-4dcb-b734-c818c49863fd";
    switch (social) {
      case Social.google:
        GoogleService.signIn().then(
          (user) async {
            final pref = await SharedPreferences.getInstance();
            pref.setString("social", "google");
            _user.setUser = user.user!;
            final account = await MyCollection.user
                .where("email", isEqualTo: user.user!.email)
                .get();
            if (account.docs.isEmpty) {
              MyCollection.user.add(
                UserModel(
                  email: user.user!.email!,
                  id: "",
                  imageUrl: user.user!.photoURL ?? _blank,
                  name: user.user!.displayName!,
                  roleId: "1",
                  provider: "Google",
                  createAt: DateTime.now(),
                  updateAt: DateTime.now(),
                ).toMap(),
              );
              final data = await MyCollection.user
                  .where("email", isEqualTo: user.user!.email)
                  .get();
              MyCollection.user.doc(data.docs.first.id).update({
                "id": data.docs.first.id,
              });
            }
            Navigator.pushReplacementNamed(context, Routes.main)
                .then((_) => Navigator.pop(context));
          },
        );
        break;
      case Social.facebook:
        FacebookService.signIn().then(
          (user) async {
            final pref = await SharedPreferences.getInstance();
            pref.setString("social", "google");
            _user.setUser = user.user!;
            final account = await MyCollection.user
                .where("email", isEqualTo: user.user!.email)
                .get();
            if (account.docs.isEmpty) {
              MyCollection.user.add(
                {
                  "name": user.user!.displayName,
                  "email": user.user!.email,
                  "provider": "Facebook",
                  "image_url": user.user!.photoURL,
                },
              );
            }
            Navigator.pushReplacementNamed(context, Routes.main)
                .then((value) => Navigator.pop(context));
          },
        );
        break;
    }
  }
}
