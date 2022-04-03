import 'package:flutter/material.dart';
import 'package:project/app/views/cart/checkout.dart';

import '../../routes/route.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
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
      body: Center(
          child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.checkout),
              child: const Text("tekan saya"))),
    );
  }
}
