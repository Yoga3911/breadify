import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.size,
    required this.index,
    required this.product,
    required this.storeName,
  }) : super(key: key);

  final Size size;
  final int index;
  final ProductModel product;
  final String storeName;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: (MediaQuery.of(context).orientation == Orientation.portrait)? index.isOdd ? size.height * 0.24 : size.height * 0.3 : size.height * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: (MediaQuery.of(context).orientation == Orientation.portrait)? index.isOdd ? size.height * 0.15 : size.height * 0.21 : size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(0, 255, 255, 255),
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: index.isOdd
                            ? const Alignment(-1, 0.5)
                            : const Alignment(-1, 0.65),
                        child: Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-1, 0.95),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              storeName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 204, 0),
                              ),
                            ),
                            Image.asset("assets/icons/fav1.png")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
