import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'card.dart';
import '../../../../view_model/product_provider.dart';
import '../../../../routes/route.dart';
import '../../../../view_model/category_provider.dart';
import '../../../../constant/color.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    final product = Provider.of<ProductProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: FutureBuilder(
        future: product.getByCategory(categoryProvider.getCategory),
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
          if (product.getProduct.isEmpty) {
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
            itemCount: product.getProduct.length,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 2
                      : 3,
            ),
            itemBuilder: (_, index) {
              return ChangeNotifierProvider(
                create: (_) => product.getProduct[index],
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.product,
                      arguments: {
                        "product": product.getProduct[index],
                      },
                    );
                  },
                  child: Hero(
                    tag: product.getProduct[index].id + "hero",
                    child: ProductCard(
                      index: index,
                      product: product.getProduct[index],
                    ),
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
