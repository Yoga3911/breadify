import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class HotProductPage extends StatelessWidget {
  const HotProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("Hot");
    final _args =
        (ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>);
    final String _productId = _args["product_id"];
    final ProductModel _product = _args["product_data"];
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
                tag: _productId + "hero" + "hot",
                child: Stack(
                  children: [
                    CachedNetworkImage(imageUrl: _product.image),
                    Positioned(
                      top: 15,
                      left: 15,
                      child: Container(
                        height: _size.height * 0.06,
                        width: _size.height * 0.06,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: _size.height * 0.03,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
