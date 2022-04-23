import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project/app/models/product_model.dart';

import '../../../routes/route.dart';

class StoreProduct extends StatelessWidget {
  const StoreProduct({
    Key? key,
    required this.productModel,
    required this.storeName,
    required this.sellerId,
  }) : super(key: key);

  final List<ProductModel> productModel;
  final String storeName;
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: MasonryGridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        itemCount: productModel.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (_, index) {
          final product = productModel[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.product,
                arguments: {
                  "id": product.id,
                  "name": product.name,
                  "price": product.price,
                  "quantity": product.quantity,
                  "image": product.image,
                  "seller_id": sellerId,
                },
              );
            },
            child: Material(
              elevation: 5,
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height:
                    (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? size.height * 0.3
                        : size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Hero(
                      tag: product.id + "hero",
                      child: ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? size.height * 0.21
                            : size.height * 0.4,
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
                                alignment: const Alignment(-1, 0.55),
                                child: Text(
                                  productModel[index].name,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      storeName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 255, 204, 0),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/icons/fav1.png",
                                    )
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
            ),
          );
        },
      ),
    );
  }
}
