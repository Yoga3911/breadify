import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/utils/hash.dart';
import 'package:project/app/view_model/auth_provider.dart';
import 'package:project/app/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../services/facebook.dart';
import '../../services/google.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isHidden1 = true;
  void _togglePasswordView1() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }

  bool _isHidden2 = true;
  void _togglePasswordView2() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  late TextEditingController _username;
  late TextEditingController _email;
  late TextEditingController _password1;
  late TextEditingController _password2;

  @override
  void initState() {
    _username = TextEditingController();
    _password1 = TextEditingController();
    _password2 = TextEditingController();
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password1.dispose();
    _password2.dispose();
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
                controller: _username,
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
                controller: _email,
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
                controller: _password1,
                obscureText: _isHidden1,
                decoration: InputDecoration(
                  // icon: Icon(Icons.account_box),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: InkWell(
                    onTap: _togglePasswordView1,
                    child: Icon(
                      _isHidden1 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
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
                obscureText: _isHidden2,
                controller: _password2,
                decoration: InputDecoration(
                  // icon: Icon(Icons.account_box),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: InkWell(
                    onTap: _togglePasswordView2,
                    child: Icon(
                      _isHidden2 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
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
                  final isValid = validator(context);
                  if (isValid) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => const CustomLoading(),
                    );
                    auth.register(
                      context: context,
                      email: _email.text,
                      name: _username.text,
                      password: hashPass(_password1.text),
                    );
                  }
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
                        "SIGN IN HERE!",
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
    if (_username.text.isEmpty) {
      snackBar(context, 'Username Tidak Boleh Kosong');
      return false;
    } else if (_email.text.isEmpty) {
      snackBar(context, 'Email Tidak Boleh Kosong');
      return false;
    } else if (_password1.text.isEmpty) {
      snackBar(context, 'Password Tidak Boleh Kosong');
      return false;
    } else if (_password2.text.isEmpty) {
      snackBar(context, 'Konfirmasi Password Tidak Boleh Kosong');
      return false;
    } else if (_password1.text != _password2.text) {
      snackBar(context, 'Password dan Konfirmasi Password Tidak Sama');
      return false;
    }else if (_password1.text.length < 6) {
      snackBar(context, 'Password Minimal 6 Karakter');
      return false;
    }return true;
  }

  void snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
