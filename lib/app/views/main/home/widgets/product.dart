import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constant/collection.dart';
import '../../../../constant/color.dart';
import 'card.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return FutureBuilder<QuerySnapshot>(
      future: MyCollection.products.orderBy("create_at").get(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MasonryGridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 8,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: 2,
            itemBuilder: (_, index) {
              return Shimmer.fromColors(
                baseColor: MyColor.grey,
                highlightColor: MyColor.grey2,
                direction: ShimmerDirection.ltr,
                child: ProductCard(
                  size: _size,
                  index: index,
                ),
              );
            },
          );
        }
        return MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 8,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          itemBuilder: (_, index) {
            return ProductCard(
              size: _size,
              index: index,
            );
          },
        );
      },
    );
  }
}
