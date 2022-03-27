import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/view_model/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/color.dart';
import '../../models/product_model.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _args =
        (ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>);
    final String _productId = _args["product_id"];
    final ProductModel _product = _args["product_data"];
    final _todayCategory = _args["category"];
    final String _sellerId = _args["seller_id"];
    final Size _size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            heroTag: "home",
            onPressed: () {},
            label: Padding(
              padding: EdgeInsets.only(
                left: _size.width * 0.2,
                right: _size.width * 0.2,
              ),
              child: const Text(
                "Add to cart",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          body: Column(
            children: [
              Hero(
                tag: (_todayCategory == "Category")
                    ? _productId + "hero"
                    : (_todayCategory == "Popular")
                        ? _productId + "hero" + "popular"
                        : (_todayCategory == "Hot")
                            ? _productId + "hero" + "hot"
                            : _productId + "hero" + "discount",
                child: Stack(
                  children: [
                    SizedBox(
                        height: _size.height * 0.4,
                        width: _size.width,
                        child: CachedNetworkImage(
                          imageUrl: _product.image,
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                      top: 15,
                      left: 15,
                      child: Container(
                        height: _size.height * 0.05,
                        width: _size.height * 0.05,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: _size.height * 0.025,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: _size.height * 0.33,
                      left: _size.width * 0.83,
                      child: Image.asset(
                        "assets/images/heart.png",
                        scale: 1.2,
                      ),
                    )
                  ],
                ),
              ),
              FutureBuilder<DocumentSnapshot>(
                  future: MyCollection.user.doc(_sellerId).get(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                            ),
                            Container(
                              height: 30,
                              width: 100,
                            ),
                          ],
                        ),
                        baseColor: MyColor.grey,
                        highlightColor: MyColor.grey2,
                        direction: ShimmerDirection.ltr,
                      );
                    }
                    return Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage((snapshot.data!.data()
                                      as Map<String, dynamic>)["image_url"]))),
                        ),
                        Container(
                          height: 30,
                          width: 100,
                        ),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
