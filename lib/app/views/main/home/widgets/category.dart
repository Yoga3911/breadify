import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant/color.dart';
import '../../../../models/category_model.dart';
import '../../../../view_model/category_provider.dart';
import '../../../../view_model/product_provider.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryData = <CategoryModel>[
      const CategoryModel(name: "Popular", asset: "assets/icons/fire.png"),
      const CategoryModel(name: "Bread", asset: "assets/icons/bread.png"),
      const CategoryModel(name: "Cookies", asset: "assets/icons/cookies.png"),
      const CategoryModel(name: "Cakes", asset: "assets/icons/cakes.png"),
      const CategoryModel(name: "Pastry", asset: "assets/icons/pastry.png"),
      const CategoryModel(name: "Brownies", asset: "assets/icons/brownie.png"),
    ];

    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final product = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? size.height * 0.11
            : size.height * 0.22,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 10,),
            for (var category in categoryData)
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        product.setStatus = state.loading;
                        categoryProvider.setCategory = category.name;
                        switch (categoryProvider.getCategory) {
                          case "Popular":
                            product.getDataProduct("Popular");
                            product.setStatus = state.done;
                            break;
                          case "Bread":
                            product.getDataProduct("1");
                            product.setStatus = state.done;
                            break;
                          case "Cookies":
                            product.getDataProduct("2");
                            product.setStatus = state.done;
                            break;
                          case "Cakes":
                            product.getDataProduct("3");
                            product.setStatus = state.done;
                            break;
                          case "Pastry":
                            product.getDataProduct("4");
                            product.setStatus = state.done;
                            break;
                          case "Brownies":
                            product.getDataProduct("5");
                            product.setStatus = state.done;
                            break;
                        }
                      },
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
