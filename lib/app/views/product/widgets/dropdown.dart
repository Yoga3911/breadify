import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/view_model/add_prod_provider.dart';
import 'package:provider/provider.dart';

import '../components/custom_dropdown.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dropDown = Provider.of<AddProductProvider>(context);
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () => dropDown.changeCategory(""),
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
                  dropDown.icon,
                  fit: BoxFit.cover,
                ),
              ),
              suffixIcon: AnimatedRotation(
                turns: dropDown.rotate,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 100),
                child: const Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.black,
                ),
              ),
              label: Text(
                dropDown.category,
                style: const TextStyle(color: Colors.black),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        if (dropDown.isShow)
          SizedBox(
            width: _size.width,
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
                      dropDown: dropDown,
                      category: "Bread",
                      icon: "assets/icons/bread.png",
                    ),
                    ProductCategory(
                      dropDown: dropDown,
                      category: "Cookies",
                      icon: "assets/icons/cookies.png",
                    ),
                    ProductCategory(
                      dropDown: dropDown,
                      category: "Cakes",
                      icon: "assets/icons/cakes.png",
                    ),
                    ProductCategory(
                      dropDown: dropDown,
                      category: "Pastry",
                      icon: "assets/icons/pastry.png",
                    ),
                    ProductCategory(
                      dropDown: dropDown,
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

class ProductCategory extends StatelessWidget {
  const ProductCategory(
      {Key? key,
      required this.dropDown,
      required this.category,
      required this.icon})
      : super(key: key);
  final AddProductProvider dropDown;
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
          dropDown.changeCategory(category);
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
