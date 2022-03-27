import 'package:flutter/material.dart';

import '../../../../constant/color.dart';
import 'product.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular",
                    style: TextStyle(
                      fontSize: 20,
                      color: MyColor.yellow,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: const [
                      Text("See more"),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Product(todayCategory: "Popular"),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hot",
                    style: TextStyle(
                      fontSize: 20,
                      color: MyColor.yellow,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: const [
                      Text("See more"),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Product(todayCategory: "Hot"),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 20,
                      color: MyColor.yellow,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: const [
                      Text("See more"),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Product(todayCategory: "Discount"),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
