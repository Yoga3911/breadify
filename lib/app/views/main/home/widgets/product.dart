import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../routes/route.dart';
import '../../../../view_model/category_provider.dart';
import '../../../../models/product_model.dart';
import '../../../../constant/collection.dart';
import '../../../../constant/color.dart';
import 'card.dart';

class Product extends StatefulWidget {
  const Product({Key? key, required this.todayCategory}) : super(key: key);
  final String todayCategory;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  // String? store;

  // Future<void> getStoreName(String storeId) async {
  //   final storeName =
  //       await MyCollection.product.where("store_id", isEqualTo: storeId).get();
  //   store = await storeName.docs.first["store_name"];
  //   // log(store)
  //   // setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return FutureBuilder<QuerySnapshot>(
      future: (categoryProvider.getCategory == "Popular")
          ? MyCollection.product.orderBy("category_id").get()
          : (categoryProvider.getCategory == "Bread")
              ? MyCollection.product.where("category_id", isEqualTo: "1").get()
              : (categoryProvider.getCategory == "Cookies")
                  ? MyCollection.product
                      .where("category_id", isEqualTo: "3")
                      .get()
                  : (categoryProvider.getCategory == "Cakes")
                      ? MyCollection.product
                          .where("category_id", isEqualTo: "4")
                          .get()
                      : (categoryProvider.getCategory == "Pastry")
                          ? MyCollection.product
                              .where("category_id", isEqualTo: "5")
                              .get()
                          : MyCollection.product
                              .where("category_id", isEqualTo: "6")
                              .get(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MasonryGridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 2
                      : 3,
            ),
            itemBuilder: (_, index) {
              return Shimmer.fromColors(
                baseColor: MyColor.grey2,
                highlightColor: MyColor.grey3,
                direction: ShimmerDirection.ltr,
                child: Container(
                  height:
                      index.isOdd ? _size.height * 0.24 : _size.height * 0.3,
                  decoration: BoxDecoration(
                    color: MyColor.yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              );
            },
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/not_found.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Tidak ada data",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        }
        return MasonryGridView.builder(
          cacheExtent: 10000,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? 2
                    : 3,
          ),
          itemBuilder: (_, index) {
            final product = ProductModel.fromJson(
                snapshot.data!.docs[index].data() as Map<String, dynamic>);
            // final seller = SellerData.fromJson(snapshot.data!.docs[index]
            //     ["seller_data"] as Map<String, dynamic>);
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.product,
                  arguments: {
                    "product_id": snapshot.data!.docs[index].id,
                    "product_data": product,
                    "category": widget.todayCategory,
                    // "seller_id": seller.userId,
                  },
                );
              },
              child: Hero(
                tag: snapshot.data!.docs[index].id + "hero",
                child: ProductCard(
                  size: _size,
                  index: index,
                  product: product,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
