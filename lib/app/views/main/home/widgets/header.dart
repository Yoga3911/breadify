import 'package:flutter/material.dart';
import 'package:project/app/models/user_model.dart';
import 'package:provider/provider.dart';

import '../../../../constant/color.dart';
import '../../../../view_model/user_prodvider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final UserModel user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hello, Beatric",
            style: TextStyle(
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