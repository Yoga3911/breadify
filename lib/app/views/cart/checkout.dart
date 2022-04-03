import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/views/cart/widgets_checkout/konten_checkout.dart';

//pemanggilan class
// import '../../models/notif_models.dart';

//utk konten Notif :
// import 'package:project/app/views/cart/widgets_notif/konten_notif.dart';

final List<CheckoutContent> checkoutcontent = [
  CheckoutContent(
      img: "img",
      productName: "Pain au Chocolate",
      bakery: "Vincii Bakery",
      price: "Rp 6.000",
      quantity: "10x"),
  CheckoutContent(
      img: "img",
      productName: "Cheese Toast",
      bakery: "Wina Bakery",
      price: "Rp 18.000",
      quantity: "6x"),
  CheckoutContent(
      img: "img",
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
            itemBuilder: (context, index) => Checkout(index: index)),
      ),
    );
  }
}

class CheckoutContent {
  final String img;
  final String productName;
  final String bakery;
  final String price;
  final String quantity;
  CheckoutContent(
      {required this.img,
      required this.productName,
      required this.bakery,
      required this.price,
      required this.quantity});
}
