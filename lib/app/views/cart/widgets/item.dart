import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/models/product_model.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cart = Provider.of<ProductProvider>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      width: size.width,
      height: size.height * 0.15,
      child: Consumer<ProductModel>(
        builder: (_, value, __) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: false,
              onChanged: (tap) {
                // value.setChecked = tap ?? false;
                // (tap == true)? cart.setTotal = 1 : cart.setTotal = -1;
              },
            ),
            SizedBox(
              height: size.height,
              width: size.height * 0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: value.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(value.name),
            Icon(Icons.home),
          ],
        ),
      ),
    );
  }
}
