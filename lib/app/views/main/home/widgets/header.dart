import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/user_prodvider.dart';
import '../../../../constant/color.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User _user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, " + _user.displayName.toString() + "!",
            style: const TextStyle(
              color: MyColor.grey,
              fontSize: 12,
            ),
          ),
          const Text(
            "Aku menyebutnya",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Tampan dan ",
                  style: TextStyle(
                    color: MyColor.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: "Pemberani",
                  style: TextStyle(
                    color: MyColor.yellow,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
