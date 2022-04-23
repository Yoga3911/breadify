import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../views/product/widgets/product_category.dart';
import '../../../constant/color.dart';
import '../../../view_model/product_provider.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown({Key? key, this.category = ""}) : super(key: key);

  final String category;

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  void initState() {
    final product = Provider.of<ProductProvider>(context, listen: false);
    if (widget.category != "") {
      switch (widget.category) {
        case "1":
          product.category = "Bread";
          product.icon = "assets/icons/bread.png";
          break;
        case "2":
          product.category = "Cookies";
          product.icon = "assets/icons/cookies.png";
          break;
        case "3":
          product.category = "Cakes";
          product.icon = "assets/icons/cakes.png";
          break;
        case "4":
          product.category = "Pastry";
          product.icon = "assets/icons/pastry.png";
          break;
        case "5":
          product.category = "Brownies";
          product.icon = "assets/icons/brownie.png";
          break;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        GestureDetector(
          onTap: () => product.changeCategory(""),
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColor.yellow,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: MyColor.yellow,
                  width: 2,
                ),
              ),
              prefixIcon: Transform.scale(
                scale: 0.6,
                child: Image.asset(
                  product.icon,
                  fit: BoxFit.cover,
                ),
              ),
              suffixIcon: AnimatedRotation(
                turns: product.rotate,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 100),
                child: const Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.black,
                ),
              ),
              label: Text(
                product.category,
                style: const TextStyle(color: Colors.black),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        if (product.isShow)
          SizedBox(
            width: size.width,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: MyColor.yellow,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ProductCategory(
                      product: product,
                      category: "Bread",
                      icon: "assets/icons/bread.png",
                    ),
                    ProductCategory(
                      product: product,
                      category: "Cookies",
                      icon: "assets/icons/cookies.png",
                    ),
                    ProductCategory(
                      product: product,
                      category: "Cakes",
                      icon: "assets/icons/cakes.png",
                    ),
                    ProductCategory(
                      product: product,
                      category: "Pastry",
                      icon: "assets/icons/pastry.png",
                    ),
                    ProductCategory(
                      product: product,
                      category: "Brownies",
                      icon: "assets/icons/brownie.png",
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
