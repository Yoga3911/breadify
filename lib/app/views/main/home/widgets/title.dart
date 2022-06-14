import 'package:flutter/material.dart';
import 'package:project/app/utils/currency.dart';
import 'package:provider/provider.dart';

import '../../../../constant/color.dart';
import '../../../../view_model/user_prodvider.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 45,
      padding: const EdgeInsets.only(
        left: 10,
      ),
      decoration: BoxDecoration(
        color: MyColor.yellow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Rp ${currency(context.read<UserProvider>().getUser.bmoney)}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Text(
            "Click to see transaction history",
            style: TextStyle(
              color: Color.fromARGB(255, 71, 71, 71),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
