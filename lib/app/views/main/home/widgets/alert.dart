import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../widgets/custom_loading.dart';
import '../../../../routes/route.dart';
import '../../../../services/facebook.dart';
import '../../../../services/google.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            final pref = await SharedPreferences.getInstance();
            switch (pref.getString("social")) {
              case "google":
                await GoogleService.signOut();
                break;
              case "facebook":
                await FacebookService.signOut();
                break;
            }
            showDialog(
              context: context,
              builder: (_) => const CustomLoading(),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (route) => false,
            ).then(
              (_) => Navigator.pop(context),
            );
          },
          child: const Text("Yakin"),
        ),
      ],
    );
  }
}
