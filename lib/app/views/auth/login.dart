import 'package:flutter/material.dart';

import '../../routes/route.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.main);
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}
