import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/models/cart_model.dart';
import 'package:project/app/models/product_model.dart';
import 'package:project/app/services/storage_service.dart';
import 'package:project/app/view_model/cart_provider.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/views/cart/widgets/item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final product = Provider.of<ProductProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: WillPopScope(
        onWillPop: () async {
          cart.setTotal = -cart.getTotal;
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
                  FutureBuilder<List<CartModel>>(
                    future: cart.getById(user.getUser.id),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return Column(
                        children: [
                          for (CartModel item in snapshot.data!)
                            FutureBuilder<ProductModel>(
                              future: product.getById(item.productId),
                              builder: (_, snapshot2) {
                                if (snapshot2.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 1,
                                  itemBuilder: (_, index) =>
                                      ChangeNotifierProvider(
                                    create: (_) => item,
                                    child: CartItem(
                                      productImage: snapshot2.data!.image,
                                    ),
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
