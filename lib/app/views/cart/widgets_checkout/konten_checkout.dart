import 'package:flutter/material.dart';

//memanggil kerangka notif :
import '../checkout.dart';

class Checkout extends StatelessWidget {
  const Checkout({required this.index, Key? key}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: Row(
        children: <Widget>[
          //1) anak ke-1 : gambar produk
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            color: Colors.green,
          ),

          const SizedBox(width: 12), //jarak

          //2) column : for text
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //2a) product name
              Text(
                checkoutcontent[index].productName,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),

              //2b) bakery
              Text(checkoutcontent[index].bakery),

            

              //2c) row : price & quantity
              Row(
                children: <Widget>[
                  //price
                  Text(checkoutcontent[index].price),
                  const SizedBox(
                    width: 120,
                  ),
                  //quantity
                  Text(checkoutcontent[index].quantity),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
