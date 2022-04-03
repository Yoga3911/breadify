import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';

//pemanggilan class
import '../../models/checkout_models.dart';

//utk konten Checkout :
import 'package:project/app/views/cart/widgets_checkout/konten_checkout.dart';

final List<CheckoutContent> checkoutcontent = [
  CheckoutContent(
      img:
          "https://images.unsplash.com/photo-1483695028939-5bb13f8648b0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
      productName: "Pain au Chocolate",
      bakery: "Vincii Bakery",
      price: "Rp 6.000",
      quantity: "10x"),
  CheckoutContent(
      img:
          "https://images.unsplash.com/photo-1608039858788-667850f129f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80",
      productName: "Cheese Toast",
      bakery: "Wina Bakery",
      price: "Rp 18.000",
      quantity: "6x"),
  CheckoutContent(
      img:
          "https://images.unsplash.com/photo-1563778084459-859099e48677?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
      productName: "Strawberry Cupcakes",
      bakery: "Vincii Bakery",
      price: "Rp 8.000",
      quantity: "3x"),
];

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          title: const Text(
            "Checkout",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          itemCount: checkoutcontent.length,
          itemBuilder: (context, index) => Checkout(index: index),
        ),
      ),
    );
  }
}
