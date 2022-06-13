import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/utils/currency.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project/app/view_model/cart_provider.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

class BtmSheet extends StatelessWidget {
  const BtmSheet({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productId,
  }) : super(key: key);
  final String image;
  final String name;
  final int price;
  final int quantity;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        product.setCountItem = -product.getCountItem;
        return true;
      },
      child: Container(
        height: 210,
        decoration: const BoxDecoration(
          color: MyColor.yellow,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 120,
                          height: size.height,
                          child: CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 43, 43, 43),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        product.setCountItem =
                                            -product.getCountItem;
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.cancel_rounded,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Rp " + currency(price),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 78, 78, 78),
                                  ),
                                ),
                                Text(
                                  "Stock: $quantity",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 118, 118, 118),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 35,
                                  width: 85,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: FutureBuilder(
                                      future: MyCollection.product.get(),
                                      builder: (_, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox();
                                        }
                                        return Consumer<ProductProvider>(
                                          builder: (_, val, __) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (val.getCountItem > 0) {
                                                    val.setCountItem = -1;
                                                  }
                                                },
                                                child: const Icon(
                                                    Icons.remove_rounded),
                                              ),
                                              Text(val.getCountItem.toString()),
                                              GestureDetector(
                                                onTap: () {
                                                  if (val.getCountItem <
                                                      quantity) {
                                                    val.setCountItem = 1;
                                                  }
                                                },
                                                child: const Icon(
                                                    Icons.add_rounded),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (product.getCountItem == 0) {
                    product.setCountItem = -product.getCountItem;
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Jumlah produk tidak boleh 0"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  showDialog(
                    context: context,
                    builder: (_) => const CustomLoading(),
                  );

                  context
                      .read<CartProvider>()
                      .addToCart(
                        userId: context.read<UserProvider>().getUser.id,
                        productId: productId,
                        quantity: product.getCountItem,
                      )
                      .then((_) {
                    product.setCountItem = -product.getCountItem;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Produk berhasil ditambahkan ke keranjang"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  });
                },
                child: const Text(
                  "Add to cart",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(size.width, 40)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
