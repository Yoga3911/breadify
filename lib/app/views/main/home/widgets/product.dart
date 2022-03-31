import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'card.dart';
import '../../../../view_model/product_provider.dart';
import '../../../../routes/route.dart';
import '../../../../view_model/category_provider.dart';
import '../../../../models/product_model.dart';
import '../../../../constant/color.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);
  final String _todayCategory = "Category";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: FutureBuilder<List<ProductModel>>(
        future: productProvider.getDataByCategory(categoryProvider.getCategory),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MasonryGridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 8,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              cacheExtent: 10000,
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
                        index.isOdd ? size.height * 0.24 : size.height * 0.3,
                    decoration: BoxDecoration(
                      color: MyColor.yellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            );
          }
          if (snapshot.data!.isEmpty) {
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
            itemCount: snapshot.data!.length,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 2
                      : 3,
            ),
            itemBuilder: (_, index) {
              final product = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.product,
                    arguments: {
                      "product": product,
                      "category": _todayCategory,
                      // "seller_id": seller.userId,
                    },
                  );
                },
                child: Hero(
                  tag: product.id + "hero",
                  child: ProductCard(
                    size: size,
                    index: index,
                    product: product,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
