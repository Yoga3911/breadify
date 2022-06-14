import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/models/cart_model.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/utils/currency.dart';
import 'package:project/app/view_model/cart_provider.dart';
import 'package:project/app/view_model/notif_provider.dart';
import 'package:project/app/view_model/order_provider.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:project/app/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

//pemanggilan class
import '../../models/checkout_models.dart';

//utk konten Checkout :
import 'package:project/app/views/cart/widgets_checkout/konten_checkout.dart';

import '../../view_model/maps_provider.dart';
import '../../view_model/user_prodvider.dart';

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
    final user = Provider.of<UserProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final notif = Provider.of<NotifProvider>(context, listen: false);
    final location = Provider.of<MyLocation>(context);

    return WillPopScope(
      onWillPop: () async {
        context.read<CartProvider>().cartDataCheckout.clear();
        return true;
      },
      child: ScrollConfiguration(
        behavior: NoGlow(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.read<CartProvider>().cartDataCheckout.clear();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Checkout",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
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
                          Expanded(
                            child: Row(
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
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        user.getUser.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF8B8B8B),
                                            fontSize: 12),
                                      ),
                                      //alamat
                                      Text(
                                        location.getLocation,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF8B8B8B),
                                            fontSize: 12),
                                      ),
                                      //kabupaten
                                      Text(
                                        location.getPostCode,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF8B8B8B),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
                    Consumer<CartProvider>(
                      builder: (_, notifier, __) => ListView.builder(
                        itemCount: notifier.cartDataCheckout.length,
                        itemBuilder: (context, index) => Checkout(
                            cartModel: notifier.cartDataCheckout[index]),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //1) Total transaksi
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        const Text("Total transactions"),
                        Text(
                          "Rp " +
                              currency(
                                  context.read<CartProvider>().getTotalMoney),
                          style: const TextStyle(
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
                          onTap: () async {
                            if (user.getUser.bmoney <
                                context.read<CartProvider>().getTotalMoney) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "BMoney tidak cukup, silahkan isi ulang"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            showDialog(
                              context: context,
                              builder: (_) => const CustomLoading(),
                            );
                            List<String> dataProduct = [];
                            for (CartModel c in cart.cartDataCheckout) {
                              await context
                                  .read<ProductProvider>()
                                  .getById(c.productId)
                                  .then(
                                (product) {
                                  notif.sendNotif(
                                    message: "Transaction successful",
                                    note: "Your order will be delivered soon",
                                    price: product.price,
                                    productName: product.name,
                                  );
                                  dataProduct.add(product.id);
                                },
                              );
                              MyCollection.cart.doc(c.id).delete();
                            }

                            cart.cartDataCheckout.clear();
                            context.read<OrderProvider>().insertData(
                                  userId: user.getUser.id,
                                  address: location.getLocation,
                                  productId: dataProduct,
                                );
                            cart.setTotal = -cart.getTotal;
                            cart.setTotalMoney = -cart.getTotalMoney;

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.main,
                              (route) => false,
                            );
                          },
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
            ],
          ),
        ),
      ),
    );
  }
}