import 'dart:developer';

import 'package:flutter/material.dart';
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
    final auth = Provider.of<AuthProvider>(context);
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
            }
            pref.remove("id");
            
          },
          child: const Text("Yakin"),
        ),
      ],
    );
  }
}
