import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password1.dispose();
    password2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 1,
                    child: const Image(
                      image: AssetImage(
                          "assets/images/login_register_reverse.jfif"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.height * 0.05,
                        MediaQuery.of(context).size.height * 0.46,
                        MediaQuery.of(context).size.height * 0.05,
                        MediaQuery.of(context).size.height * 0.05),
                    child: const AutoSizeText(
                      "Sign Up",
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.height * 0.05,
                        MediaQuery.of(context).size.height * 0.55,
                        MediaQuery.of(context).size.height * 0.05,
                        MediaQuery.of(context).size.height * 0.05),
                    child: const AutoSizeText(
                      "Create Your Breadify's Account",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 30,
                          color: MyColor.yellow,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.05,
                  30,
                  MediaQuery.of(context).size.height * 0.05,
                  0),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  // icon: Icon(Icons.account_box),
                  prefixIcon: const Icon(Icons.person),
                  prefixStyle: const TextStyle(color: Colors.blue),
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.05,
                  30,
                  MediaQuery.of(context).size.height * 0.05,
                  0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  // icon: Icon(Icons.account_box),
                  prefixIcon: const Icon(Icons.email_outlined),
                  prefixStyle: const TextStyle(color: Colors.blue),
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.05,
                  30,
                  MediaQuery.of(context).size.height * 0.05,
                  0),
              child: TextField(
                controller: password1,
                obscureText: true,
                decoration: InputDecoration(
                  // icon: Icon(Icons.account_box),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  prefixStyle: const TextStyle(color: Colors.blue),
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.05,
                  30,
                  MediaQuery.of(context).size.height * 0.05,
                  0),
              child: TextField(
                obscureText: true,
                controller: password2,
                decoration: InputDecoration(
                  // icon: Icon(Icons.account_box),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  prefixStyle: const TextStyle(color: Colors.blue),
                  hintText: "Confirm Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.05,
                  50,
                  MediaQuery.of(context).size.height * 0.05,
                  30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MyColor.yellow,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  auth.register(
                    context: context,
                    email: email.text,
                    name: username.text,
                    password: password1.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text("Sign Up",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("ALREADY HAVE ACCOUNT? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.login);
                      },
                      child: const Text(
                        "SIGN UP HERE!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: MyColor.yellow,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: 50,
                        decoration: const BoxDecoration(color: MyColor.grey2),
                      ),
                      const Text(
                        "OR    ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: MyColor.grey2,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 2,
                        width: 50,
                        decoration: const BoxDecoration(color: MyColor.grey2),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Row(
                    children: <Widget>[
                      const Spacer(
                        flex: 8,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage("assets/images/google.png"),
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage("assets/images/facebook.png"),
                        ),
                      ),
                      const Spacer(
                        flex: 8,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
