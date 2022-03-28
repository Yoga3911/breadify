import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../../routes/route.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    image:
                        AssetImage("assets/images/login_register_reverse.jfif"),
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
                    style: TextStyle(
                      fontSize: 50, 
                      fontWeight: FontWeight.w700),
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
                MediaQuery.of(context).size.height * 0.1,
                0,
                MediaQuery.of(context).size.height * 0.1,
                0),
            child: TextField(
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
                      ))),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height * 0.1,
                30,
                MediaQuery.of(context).size.height * 0.1,
                30),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  // icon: Icon(Icons.account_box),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: MyColor.yellow,
                  ),
                  suffixIcon: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: MyColor.yellow,
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
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.main);
              },
              child: const Text("Log In",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("DON'T HAVE PASSWORD? ",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
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
                      onPressed: (){},
                      // onPressed: () => _login.signIn(context, _user, Social.google),
                      iconSize: 40,
                      icon: const Image(
                        image: AssetImage("assets/images/google.png"),
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    IconButton(
                      onPressed: (){},
                      // onPressed: () => _login.signIn(context, _user, Social.facebook),
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
    );
  }
}
