import 'package:flutter/material.dart';
import 'package:project/app/models/user_model.dart';
import 'package:project/app/services/storage_service.dart';
import 'package:project/app/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/collection.dart';
import '../routes/route.dart';

import 'user_prodvider.dart';

class AuthProvider with ChangeNotifier {
  void login(BuildContext context, UserProvider _user, Services social) {
    const String blank =
        "https://firebasestorage.googleapis.com/v0/b/breadify-a4a04.appspot.com/o/user.png?alt=media&token=30e27068-d2ff-4dcb-b734-c818c49863fd";
    social.signIn().then(
      (user) async {
        final pref = await SharedPreferences.getInstance();
        pref.setString("social", social.name);

        final account = await MyCollection.user
            .where("email", isEqualTo: user.user!.email)
            .get();
        if (account.docs.isEmpty) {
          MyCollection.user.add(
            UserModel(
              email: user.user!.email!,
              id: "",
              imageUrl: user.user!.photoURL ?? blank,
              name: user.user!.displayName!,
              roleId: "1",
              provider: social.name,
              createAt: DateTime.now(),
              updateAt: DateTime.now(),
            ).toJson(),
          );

          final data = await MyCollection.user
              .where("email", isEqualTo: user.user!.email)
              .get();
          final userData = UserModel.fromJson(
              data.docs.first.data() as Map<String, dynamic>);

          MyCollection.user.doc(userData.id).update(
            {
              "id": userData.id,
            },
          );
        }
        final data = await MyCollection.user
            .where("email", isEqualTo: user.user!.email)
            .get();
        
        await StorageService().saveUser(data.docs.first.data() as Map<String, dynamic>);
        _user.setUser = await StorageService().loadUser();
        await StorageService().saveId(data.docs.first["id"]);
        Navigator.pushReplacementNamed(context, Routes.main)
            .then((_) => Navigator.pop(context));
      },
    );
  }

  void logout(BuildContext context, Services social) {
    social.signOut().then(
      (value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        ).then(
          (_) => Navigator.pop(context),
        );
      },
    );
  }
}
