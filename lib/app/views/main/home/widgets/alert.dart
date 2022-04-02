import 'package:flutter/material.dart';
import 'package:project/app/view_model/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../widgets/custom_loading.dart';
import '../../../../routes/route.dart';
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
            showDialog(context: context, builder: (_) => const CustomLoading());
            final pref = await SharedPreferences.getInstance();
            switch (pref.getString("social")) {
              case "Google":
                auth.logout(context, GoogleService());
                break;
              case "Facebook":
                auth.logout(context, FacebookService());
                break;
            }
          },
          child: const Text("Yakin"),
        ),
      ],
    );
  }
}
