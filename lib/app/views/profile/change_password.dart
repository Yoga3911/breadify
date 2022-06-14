import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';
import 'package:provider/provider.dart';

import '../../routes/route.dart';
import '../../view_model/user_prodvider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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

  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          title: const Text(
            'Change Password',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height * 0.05,
                30,
                MediaQuery.of(context).size.height * 0.05,
                0),
            child: TextField(
              controller: pass1,
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
              controller: pass2,
              obscureText: _isHidden2,
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                if (pass1.text != pass2.text) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Password Tidak Sama"),
                      backgroundColor: Colors.red));
                  return;
                } else if (pass1.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Password Minimal 6 Karakter"),
                      backgroundColor: Colors.red));
                  return;
                }

                context
                    .read<UserProvider>()
                    .changePassword(
                        userId: context.read<UserProvider>().getUser.id,
                        password: pass1.text)
                    .then((_) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.main, (route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Password Berhasil Diubah"),
                      backgroundColor: Colors.green));
                });
              },
              child: const Text(
                "Confirm Change",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
