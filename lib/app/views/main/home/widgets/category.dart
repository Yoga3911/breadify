import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant/color.dart';
import '../../../../models/category_model.dart';
import '../../../../view_model/category_provider.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryData = <CategoryModel>[
      CategoryModel(name: "Popular", asset: "assets/icons/fire.png"),
      CategoryModel(name: "Bread", asset: "assets/icons/bread.png"),
      CategoryModel(name: "Cookies", asset: "assets/icons/cookies.png"),
      CategoryModel(name: "Cakes", asset: "assets/icons/cakes.png"),
      CategoryModel(name: "Pastry" , asset: "assets/icons/pastry.png"),
      CategoryModel(name: "Brownies", asset: "assets/icons/brownie.png"),
    ];

    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: SizedBox(
        height: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? size.height * 0.11
            : size.height * 0.22,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (var category in categoryData)
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => categoryProvider.setCategory = category.name,
                      child: Container(
                        height: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? size.height * 0.07
                            : size.width * 0.07,
                        width: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? size.height * 0.07
                            : size.width * 0.07,
                        decoration: BoxDecoration(
                          color: (categoryProvider.getCategory == category.name)
                              ? MyColor.yellow
                              : MyColor.grey3,
                          shape: BoxShape.circle,
                        ),
                        child: Transform.scale(
                          child: Image.asset(category.asset),
                          scale: 1,
                        ),
                      ),
                    ),
                    Text(category.name),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
