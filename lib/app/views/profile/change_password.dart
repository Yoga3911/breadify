import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/constant/glow.dart';
import 'package:provider/provider.dart';

import '../../routes/route.dart';
import '../../view_model/user_prodvider.dart';
import '../../widgets/custom_loading.dart';

class changePassword extends StatefulWidget {
  const changePassword({Key? key}) : super(key: key);

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
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

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: NoGlow(),
        child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pushNamed(context, Routes.profile),
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
              ),
              title: Text('Change Password', style: TextStyle(color: Colors.white),),),
              body: ListView(
                children: [
                  Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.05,
                  30,
                  MediaQuery.of(context).size.height * 0.05,
                  0),
              child: TextField(
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
            Padding(
              padding: EdgeInsets.all(50),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    
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
            ]),
                
              ),
        );
      
  }
}
