import 'package:flutter/material.dart';

import '../../routes/route.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.home);
          },
          child: const Text("Click!"),
        ),
      ),
    );
  }
}
