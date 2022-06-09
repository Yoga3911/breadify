import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/models/cart_model.dart';
import 'package:project/app/models/store_model.dart';
import 'package:project/app/view_model/store_provider.dart';
import 'package:project/app/views/cart/widgets/inc_dec_btn.dart';
import 'package:provider/provider.dart';

import '../../../view_model/cart_provider.dart';
import '../../../utils/currency.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.storeId,
    required this.productQuantity,
    required this.productId,
  }) : super(key: key);
  final String productImage;
  final String productName;
  final int productPrice;
  final String storeId;
  final int productQuantity;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context, listen: false);
    final store = Provider.of<StoreProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<CartProvider>(
            builder: (_, notifier, __) => Consumer<CartModel>(
              builder: (_, value, __) => Checkbox(
                value: value.getChecked,
                onChanged: (tap) {
                  if (tap == true) {
                    notifier.cartData.add(value);
                  } else if (tap == false) {
                    notifier.cartData.remove(value);
                  }
                  value.setChecked = tap ?? false;
                  (tap == true) ? cart.setTotal = 1 : cart.setTotal = -1;
                },
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.15,
            width: size.height * 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: productImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder<StoreModel>(
                      future: store.getStoreById(storeId),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading ...");
                        }
                        return Text(
                          snapshot.data!.storeName,
                          style: const TextStyle(color: MyColor.grey),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rp ${currency(productPrice)}",
                      style: const TextStyle(
                          color: MyColor.yellow, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Stock: $productQuantity",
                            style: const TextStyle(color: MyColor.grey),
                          ),
                          Row(
                            children: [
                              IncDecBtn(
                                label: "-",
                                quantity: productQuantity,
                                price: productPrice,
                                productId: productId,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Consumer<CartModel>(
                                  builder: (_, value, __) => Text(
                                    value.getTotalItem.toString(),
                                  ),
                                ),
                              ),
                              IncDecBtn(
                                label: "+",
                                quantity: productQuantity,
                                price: productPrice,
                                productId: productId,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
