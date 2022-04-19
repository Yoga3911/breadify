import 'package:flutter/material.dart';
import 'package:project/app/models/cart_model.dart';
import 'package:project/app/view_model/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';

class IncDecBtn extends StatelessWidget {
  const IncDecBtn({
    Key? key,
    required this.label,
    required this.quantity,
    required this.price,
    required this.productId
  }) : super(key: key);
  final String label;
  final int quantity;
  final int price;
  final String productId;

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
        child: Consumer<CartProvider>(
          builder: (_, notifier, __) => InkWell(
            onTap: () {
              if (label == "+" && cartModel.getTotalItem < quantity) {
                cartModel.setTotalItem = 1;
                notifier.setTotalMoney = price;
              } else if (label == "-" && cartModel.getTotalItem > 0) {
                cartModel.setTotalItem = -1;
                notifier.setTotalMoney = -price;
              }
            },
            borderRadius: BorderRadius.circular(3),
            child: Center(child: Text(label)),
          ),
        ),
      ),
    );
  }
}
