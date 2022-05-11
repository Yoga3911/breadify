import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/routes/route.dart';

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

// final List<Address> address = [
//   Address(
//       nama: "Pakdhe",
//       telpon: "(+62)1331435366",
//       alamat: "Jalan Mawar no. 123",
//       kabupaten: "KAB. JEMBER, JAWA TIMUR, ID 66666")
// ];

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  // final int i;
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        floatingActionButton: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //1) Total transaksi
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const <Widget>[
                  Text("Total transactions"),
                  Text(
                    "Rp 192.000",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),

              const SizedBox(width: 10), //jarak
              //2) button "order"
              Container(
                height: 45,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Order",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
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
            //1) Container utk alamat
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(5),
              color: const Color(0xA0E5E5E5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //a) konten 1 : ROW() yg berisi icon gps & column for text
                  Row(
                    children: <Widget>[
                      //a1) icon GPS
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset("assets/icons/map2.png"),
                      ),

                      //jarak
                      const SizedBox(
                        width: 10,
                      ),

                      //a2) column for text
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          //judul : address
                          Text(
                            "Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                          //nama
                          Text(
                            "Beatric Stevany Zebua",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B8B8B),
                                fontSize: 12),
                          ),
                          //telpon
                          Text(
                            "(+62)1331435366",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B8B8B),
                                fontSize: 12),
                          ),
                          //alamat
                          Text(
                            "Perum. Pondok Permata Suci, Jl. Permata No. 90",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B8B8B),
                                fontSize: 12),
                          ),
                          //kabupaten
                          Text(
                            "KAB. JEMBER, JAWA TIMUR, ID 66666",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B8B8B),
                                fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                  //b) konten 2 : button ">" utk ke MAPS
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Transform.scale(
                      scale: 1,
                      child: IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.maps),
                        icon: const Icon(Icons.arrow_forward_ios),
                        color: const Color(0xFF727272),
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
