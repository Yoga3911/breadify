// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/models/cart_model.dart';
import 'package:project/app/models/product_model.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/cart_provider.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/views/cart/widgets/choose_all.dart';
import 'package:project/app/views/cart/widgets/item.dart';
import 'package:provider/provider.dart';

import '../../utils/currency.dart';
import '../../view_model/maps_provider.dart';
import 'widgets/cart_shimmer.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final location = Provider.of<MyLocation>(context, listen: false);

    final product = Provider.of<ProductProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: WillPopScope(
        onWillPop: () async {
          cart.setTotal = -cart.getTotal;
          cart.setSelectAll = false;
          cart.setTotalMoney = -cart.getTotalMoney;
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Cart",
              style: TextStyle(color: Colors.white),
            ),
            leading: GestureDetector(
              onTap: () {
                cart.setTotal = -cart.getTotal;
                cart.setSelectAll = false;
                cart.setTotalMoney = -cart.getTotalMoney;
                return Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
          ),
          floatingActionButton: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [ChooseAll(), Text("Choose all")],
                  ),
                  Row(
                    children: [
                      Consumer<CartProvider>(
                        builder: (_, value, __) {
                          return Text(
                            "Rp ${currency(value.getTotalMoney)}",
                            style: const TextStyle(
                              color: MyColor.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () {
                          location.getAddress().then((value) {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.maps);
                          });

                          Navigator.pushNamed(context, Routes.checkout);
                        },
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(primary: MyColor.red2),
                      )
                    ],
                  )
                ],
              ),
            ),
            // color: Colors.red,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<CartProvider>(
                          builder: (_, value, __) => Text(
                            "All (${value.getTotal})",
                            style: const TextStyle(
                              color: MyColor.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 2, bottom: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            "Change",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: cart.getById(user.getUser.id),
                    builder: (_, init) {
                      if (init.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      return Column(
                        children: [
                          for (CartModel item in cart.getCartData)
                            FutureBuilder<ProductModel>(
                              future: product.getById(item.productId),
                              builder: (_, snapshot2) {
                                if (snapshot2.connectionState ==
                                    ConnectionState.waiting) {
                                  return const ShimmerCart();
                                }
                                final prod = snapshot2.data!;
                                return ChangeNotifierProvider(
                                  create: (_) => item,
                                  child: CartItem(
                                    productId: prod.id,
                                    productName: prod.name,
                                    productImage: prod.image,
                                    productPrice: prod.price,
                                    productQuantity: prod.quantity,
                                    storeId: prod.storeId,
                                  ),
                                );
                              },
                            ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
