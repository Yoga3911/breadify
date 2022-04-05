import 'package:flutter/material.dart';

import '../../../view_model/product_provider.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory(
      {Key? key,
      required this.product,
      required this.category,
      required this.icon})
      : super(key: key);
  final ProductProvider product;
  final String category;
  final String icon;
  
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ListTile(
        visualDensity: VisualDensity.comfortable,
        onTap: () {
          product.changeCategory(category);
        },
        leading: Transform.scale(
          scale: 0.7,
          child: Image.asset(
            icon,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          category,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
