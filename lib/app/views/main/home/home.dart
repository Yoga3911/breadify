import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/glow.dart';
import '../../../constant/color.dart';
import '../../../constant/collection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlow(),
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
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            children: [
              const Text(
                "Hello, Pakdhe!",
                style: TextStyle(color: MyColor.grey, fontSize: 12),
              ),
              const Text(
                "Aku menyebutnya",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Tampan dan ",
                      style: TextStyle(color: MyColor.black, fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text: "Pemberani",
                      style: TextStyle(color: MyColor.yellow, fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<QuerySnapshot>(
                future: MyCollection.products.orderBy("create_at").get(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return MasonryGridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 8,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      crossAxisCount: 2,
                      itemBuilder: (_, index) {
                        return Shimmer.fromColors(
                          baseColor: MyColor.grey,
                          highlightColor: MyColor.grey2,
                          direction: ShimmerDirection.ltr,
                          child: Container(
                            height: index.isOdd ? 250 : 300,
                            decoration: BoxDecoration(
                              color: MyColor.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return MasonryGridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 8,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    crossAxisCount: 2,
                    itemBuilder: (_, index) {
                      return Container(
                        height: index.isOdd ? 250 : 300,
                        decoration: BoxDecoration(
                          color: MyColor.yellow,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
