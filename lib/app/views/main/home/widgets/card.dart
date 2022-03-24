import 'package:flutter/material.dart';

import '../../../../constant/color.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.size,
    required this.index,
  }) : super(key: key);

  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: index.isOdd ? size.height * 0.24 : size.height * 0.3,
      decoration: BoxDecoration(
        color: MyColor.yellow,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
