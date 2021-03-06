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
import '../../widgets/custom_loading.dart';
import 'widgets/cart_shimmer.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isChange = false;
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
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
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
                              GestureDetector(
                                onTap: () {
                                  context.read<CartProvider>().setIsChange =
                                      !context.read<CartProvider>().isChange;
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Text(
                                    "Change",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: cart.getById(user.getUser.id),
                          builder: (_, init) {
                            if (init.connectionState ==
                                ConnectionState.waiting) {
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
                                      return ChangeNotifierProvider.value(
                                        value: item,
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
              Padding(
                padding: const EdgeInsets.only(right: 10),
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
                        Consumer<CartProvider>(
                            builder: (_, notifier, __) => (notifier.isChange)
                                ? ElevatedButton(
                                    onPressed: () {
                                      if (cart.getTotalMoney == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Tidak ada item yang dipilih"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }
                                      showDialog(
                                        context: context,
                                        builder: (_) => const CustomLoading(),
                                      ).then((value) {
                                        for (CartModel item in cart.cartData) {
                                          cart.cartDataCheckout.add(item);
                                        }

                                        for (var element
                                            in cart.cartDataCheckout) {
                                          context
                                              .read<CartProvider>()
                                              .deleteItem(cartId: element.id);
                                        }
                                      });
                                      Navigator.pop(context);
                                      context.read<CartProvider>().setTotal =
                                          -context
                                              .read<CartProvider>()
                                              .getTotal;
                                      context.read<CartProvider>().setIsChange =
                                          false;
                                      setState(() {});
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: MyColor.red2),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      if (cart.getTotalMoney == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Tidak ada item yang dipilih"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }
                                      showDialog(
                                        context: context,
                                        builder: (_) => const CustomLoading(),
                                      );
                                      for (CartModel item in cart.cartData) {
                                        cart.cartDataCheckout.add(item);
                                      }
                                      location.getAddress().then((value) {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, Routes.checkout);
                                      });
                                    },
                                    child: const Text(
                                      "Checkout",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: MyColor.red2),
                                  ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}