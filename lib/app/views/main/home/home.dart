import 'package:flutter/material.dart';
import 'package:project/app/views/main/home/widgets/category.dart';
import 'package:project/app/views/main/home/widgets/header.dart';
import 'package:project/app/views/main/home/widgets/product.dart';
import 'package:project/app/views/main/home/widgets/search.dart';

import '../../../constant/glow.dart';
import '../../../constant/color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: const Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/superman.png"),
              ),
            ),
            title: Container(
              width: 170,
              height: 45,
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                color: MyColor.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Rp 100.000",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Click to see transaction history",
                    style: TextStyle(
                      color: MyColor.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                splashRadius: 25,
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.notifications_outlined,
                      size: 30,
                    ),
                    Positioned(
                      left: 15,
                      top: 5,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: MyColor.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 25,
                icon: Image.asset("assets/icons/cart.png"),
              ),
            ],
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: ListView(
              children: const [
                Header(),
                SizedBox(height: 10),
                SearchBar(),
                SizedBox(height: 10),
                ProductCategory(),
                SizedBox(height: 10),
                Product(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
