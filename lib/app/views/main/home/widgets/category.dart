import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final List<String> _categoryData = [
      "assets/icons/fire.png",
      "assets/icons/bread.png",
      "assets/icons/cookies.png",
      "assets/icons/cakes.png",
      "assets/icons/pastry.png",
    ];

    return SizedBox(
      height: _size.height * 0.1,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _categoryData
            .map(
              (e) => Container(
                margin: const EdgeInsets.only(right: 15),
                height: _size.height * 0.08,
                width: _size.height * 0.08,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 230, 230, 230),
                  shape: BoxShape.circle,
                ),
                child: Transform.scale(
                  child: Image.asset(e),
                  scale: 1,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
