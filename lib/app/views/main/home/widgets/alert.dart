import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/services/email.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../view_model/auth_provider.dart';
import '../../../../widgets/custom_loading.dart';
import '../../../../services/facebook.dart';
import '../../../../services/google.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return AlertDialog(
      title: const Text(
        "Apakah kamu yakin ingin logout?",
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () async {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => const CustomLoading(),
            );
            final pref = await SharedPreferences.getInstance();
            log(pref.getString("social").toString());
            switch (pref.getString("social")) {
              case "google":
                auth.logout(context, GoogleService());
                break;
              case "facebook":
                auth.logout(context, FacebookService());
                break;
              case "email":
                auth.logout(context, EmailService());
                break;
            }
            MyCollection.user.doc(user.getUser.id).update({
              "isActive": false,
            });
            pref.remove("id");
          },
          child: const Text("Yakin"),
        ),
      ],
    );
  }
}
