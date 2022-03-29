import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/color.dart';
import '../../../../routes/route.dart';
import '../../../../services/facebook.dart';
import '../../../../services/google.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _spinkit = SpinKitCircle(
      itemBuilder: (BuildContext context, int index) => DecoratedBox(
        decoration:
            BoxDecoration(color: index.isEven ? MyColor.yellow : Colors.black),
      ),
    );
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
              builder: (_) => Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: _size.height * 0.15,
                    height: _size.height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _spinkit,
                        const Text(
                          "Loading ...",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
            await Future.delayed(
              const Duration(seconds: 3),
            );
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (route) => false,
            );
          },
          child: const Text("Yakin"),
        ),
      ],
    );
  }
}
