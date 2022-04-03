import 'package:flutter/material.dart';

//memanggil kerangka notif :
import '../checkout.dart';

class Checkout extends StatelessWidget {
  const Checkout({required this.index, Key? key}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.08,
      color: Colors.amber,
    );
  }
}
