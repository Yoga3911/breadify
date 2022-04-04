import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/models/cart_model.dart';
import 'package:project/app/models/product_model.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../view_model/cart_provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.productImage}) : super(key: key);
  final String productImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      width: size.width,
      height: size.height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<CartModel>(
            builder: (_, value, __) => Checkbox(
              value: value.isChecked,
              onChanged: (tap) {
                value.setChecked = tap ?? false;
                (tap == true) ? cart.setTotal = 1 : cart.setTotal = -1;
              },
            ),
          ),
          SizedBox(
            height: size.height,
            width: size.height * 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: productImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(""),
          Icon(Icons.home),
        ],
      ),
    );
  }
}
