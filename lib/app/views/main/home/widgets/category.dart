import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/models/category_model.dart';
import 'package:project/app/view_model/category_provider.dart';
import 'package:provider/provider.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categoryData = [
      {
        "asset": "assets/icons/fire.png",
        "name": "Today",
      },
      {
        "asset": "assets/icons/bread.png",
        "name": "Bread",
      },
      {
        "asset": "assets/icons/cookies.png",
        "name": "Cookies",
      },
      {
        "asset": "assets/icons/cakes.png",
        "name": "Cakes",
      },
      {
        "asset": "assets/icons/pastry.png",
        "name": "Pastry",
      },
      {
        "asset": "assets/icons/brownie.png",
        "name": "Brownies",
      },
    ];
    
    final Size _size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    
    return SizedBox(
      height: _size.height * 0.11,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categoryData.map(
          (e) {
            CategoryModel category =
                CategoryModel(name: e["name"]!, asset: e["asset"]!);
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => categoryProvider.setCategory = category.name,
                    child: Container(
                      height: _size.height * 0.08,
                      width: _size.height * 0.08,
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
            );
          },
        ).toList(),
      ),
    );
  }
}
