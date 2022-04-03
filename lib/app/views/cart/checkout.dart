import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';

//pemanggilan class
// import '../../models/notif_models.dart';

//utk konten Notif :
// import 'package:project/app/views/cart/widgets_notif/konten_notif.dart';

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
        // body: ListView.builder(itemBuilder: (context, index) => ),
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
