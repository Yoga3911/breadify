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

final List<Address> address = [
  Address(
      nama: "Pakdhe",
      telpon: "(+62)1331435366",
      alamat: "Jalan Mawar no. 123",
      kabupaten: "KAB. JEMBER, JAWA TIMUR, ID 66666")
];

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({required this.i, Key? key}) : super(key: key);

  final int i;
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        floatingActionButton: Container(
          height: 48,
          width: 130,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: FittedBox(
            child: FloatingActionButton(
              splashColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {},
              child: const Text(
                "Order",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Checkout",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: <Widget>[
            //1) utk alamat checkout
            Container(
              height: MediaQuery.of(context).size.width * 0.1,
              color: const Color(0xFFB4B4B4),
              child: Row(
                children: <Widget>[
                  //a) konten 1 : untuk icon gps & column for text
                  Row(
                    children: <Widget>[
                      //a1) icon GPS
                      Transform.scale(
                        scale: 0.7,
                        child: Image.asset("assets/icons/map.png"),
                      ),
                      //a2) column for text
                      Column(
                        children: <Widget>[
                          //judul : address
                          const Text(
                            "Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                          //nama
                          Text(
                            address[i].nama,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 15),
                          ),
                          //telpon
                          Text(
                            address[i].telpon,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 15),
                          ),
                          //alamat
                          Text(
                            address[i].alamat,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 15),
                          ),
                          //kabupaten
                          Text(
                            address[i].kabupaten,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                  //b) konten 2 : button "change"
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Transform.scale(
                      scale: 0.7,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //2) utk konten perulangan
            ListView.builder(
              itemCount: checkoutcontent.length,
              itemBuilder: (context, index) => Checkout(index: index),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
