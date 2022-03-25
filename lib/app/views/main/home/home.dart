import 'package:flutter/material.dart';
import 'package:project/app/view_model/category_provider.dart';
import 'package:project/app/views/main/home/widgets/category.dart';
import 'package:project/app/views/main/home/widgets/header.dart';
import 'package:project/app/views/main/home/widgets/product.dart';
import 'package:project/app/views/main/home/widgets/search.dart';
import 'package:provider/provider.dart';

import '../../../constant/glow.dart';
import '../../../constant/color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              splashRadius: 1,
              onPressed: () {},
              icon: const CircleAvatar(
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            heroTag: "home",
            backgroundColor: MyColor.red2,
            child: Image.asset(
              "assets/icons/message.png",
              color: Colors.white,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: ListView(
              children: [
                const Header(),
                const SizedBox(height: 10),
                const SearchBar(),
                const SizedBox(height: 10),
                const ProductCategory(),
                const SizedBox(height: 10),
                if (categoryProvider.getCategory == "Popular")  
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Popular",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text("See more"),
                  ],
                ),
                const SizedBox(height: 10),
                const Product(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
