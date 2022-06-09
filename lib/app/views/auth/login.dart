import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/services/facebook.dart';
import 'package:project/app/services/google.dart';
import 'package:project/app/view_model/auth_provider.dart';
import 'package:project/app/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../routes/route.dart';
import '../../services/email.dart';
import '../../utils/hash.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

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
                      "Welcome Back!",
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.height * 0.05,
                        MediaQuery.of(context).size.height * 0.55,
                        MediaQuery.of(context).size.height * 0.05,
                        MediaQuery.of(context).size.height * 0.05),
                    child: const AutoSizeText(
                      "Log In To Continue",
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
                  0,
                  MediaQuery.of(context).size.height * 0.05,
                  0),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                  // icon: Icon(Icons.account_box),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: MyColor.yellow,
                  ),
                  prefixStyle: const TextStyle(color: Colors.blue),
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: MyColor.yellow,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.05,
                  30,
                  MediaQuery.of(context).size.height * 0.05,
                  30),
              child: TextField(
                controller: _password,
                obscureText: _isHidden,
                decoration: InputDecoration(
                    // icon: Icon(Icons.account_box),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: MyColor.yellow,
                    ),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHidden ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    prefixStyle: const TextStyle(color: Colors.blue),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: MyColor.yellow,
                        ))),
              ),
            ),
            const Text(
              "Forgot Password?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: MyColor.yellow,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.1,
                  30,
                  MediaQuery.of(context).size.height * 0.1,
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
                  final isValid =  validator(context);
                  if (isValid){
                    showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => const CustomLoading(),
                  );
                  auth.login(
                    context: context,
                    email: _email.text,
                    password: hashPass(_password.text),
                    provider: "email",
                    social: EmailService(),
                  );
                  }
                },
                child: const Text(
                  "Log In",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("DON'T HAVE PASSWORD? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.register);
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
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => const CustomLoading());
                          auth.login(
                            context: context,
                            social: GoogleService(),
                            provider: "google",
                          );
                        },
                        iconSize: 40,
                        icon: const Image(
                          image: AssetImage("assets/images/google.png"),
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => const CustomLoading(),
                          );
                          auth.login(
                            context: context,
                            social: FacebookService(),
                            provider: "facebook",
                          );
                        },
                        iconSize: 40,
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

  bool validator(BuildContext context) {
    if (_email.text.isEmpty) {
      snackBar(context, 'Email Tidak Boleh Kosong');
      return false;
    } else if (_password.text.isEmpty) {
      snackBar(context, 'Password Tidak Boleh Kosong');
      return false;
    }
    return true;
  }

  void snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
