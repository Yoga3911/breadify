import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            EasyLoading.show(status: "Loading ...");
            await Future.delayed(const Duration(seconds: 2));
            EasyLoading.dismiss();
            Navigator.pushNamed(context, "/home");
          },
          child: const Text("Click!"),
        ),
      ),
    );
  }
}
