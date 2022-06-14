import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/models/cart_model.dart';
import 'package:project/app/models/product_model.dart';
import 'package:project/app/models/store_model.dart';
import 'package:project/app/utils/currency.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:project/app/view_model/store_provider.dart';
import 'package:provider/provider.dart';

//memanggil kerangka notif :

class Checkout extends StatelessWidget {
  const Checkout({required this.cartModel, Key? key}) : super(key: key);
  final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    return FutureBuilder<ProductModel>(
        future: product.getById(cartModel.productId),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(),
            );
          }
          final productData = snapshot.data as ProductModel;
          return Container(
            margin: const EdgeInsets.fromLTRB(15, 10, 5, 10),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              children: <Widget>[
                //1) anak ke-1 : gambar produk
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: productData.image,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 12), //jarak

                //2) column : for text
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //2a) product name
                      Text(
                        productData.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),

                      //2b) bakery
                      FutureBuilder<StoreModel>(
                          future: context
                              .read<StoreProvider>()
                              .getStoreById(productData.storeId),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading ...");
                            }
                            return Text(snapshot.data!.storeName);
                          }),

                      const SizedBox(
                        height: 30, //jarak
                      ),

                      //2c) row : price & quantity
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //price
                            Text(
                              "Rp " + currency(productData.price),
                              style: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),

                            //quantity
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "${cartModel.getTotalItem}x",
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
