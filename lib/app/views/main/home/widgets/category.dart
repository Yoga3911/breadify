import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/models/category.dart';
import 'package:project/app/view_model/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({Key? key}) : super(key: key);

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  String selected = "Popular";
  List<Map<String, String>> categoryData = [
    {
      "asset": "assets/icons/fire.png",
      "name": "Popular",
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
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvier>(context);
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
                    onTap: () => setState(() => selected = category.name),
                    child: Container(
                      height: _size.height * 0.08,
                      width: _size.height * 0.08,
                      decoration: BoxDecoration(
                        color: (selected == category.name)
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
