import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class HeaderProduct extends StatelessWidget {
  const HeaderProduct({
    Key? key,
    // required this.todayCategory,
    // required this.productId,
    required this.size,
    required this.product,
  }) : super(key: key);

  // final String todayCategory;
  // final String productId;
  final Size size;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.id + "hero",
      child: Stack(
        children: [
          SizedBox(
            height: size.height * 0.4,
            width: size.width,
            child: CachedNetworkImage(
              imageUrl: product.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: Container(
              height: size.height * 0.05,
              width: size.height * 0.05,
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
                    size: size.height * 0.025,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              height: size.height * 0.05,
              width: size.height * 0.05,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  child: SizedBox(
                    height: size.height * 0.025,
                    child: Image.asset("assets/icons/more.png"),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 15,
            child: Image.asset(
              "assets/images/heart.png",
              scale: 1.2,
            ),
          )
        ],
      ),
    );
  }
}
