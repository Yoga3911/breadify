import 'package:flutter/material.dart';
import 'package:project/app/models/cart_model.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';

class IncDecBtn extends StatelessWidget {
  const IncDecBtn({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context, listen: false);
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        color: MyColor.grey3,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (label == "+") {
              cartModel.setTotalItem = 1;
            } else if (label == "-") {
              cartModel.setTotalItem = -1;
            }
          },
          borderRadius: BorderRadius.circular(3),
          child: Center(child: Text(label)),
        ),
      ),
    );
  }
}
