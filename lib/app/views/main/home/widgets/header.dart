import 'package:flutter/material.dart';

import '../../../../constant/color.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hello, Pakdhe!",
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
