import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../routes/route.dart';
import '../../../constant/collection.dart';
import '../../../constant/color.dart';
import '../../../models/product_model.dart';
import '../../../models/user_model.dart';

class ContentProduct extends StatelessWidget {
  const ContentProduct({
    Key? key,
    required this.todayCategory,
    required this.productId,
    required this.size,
    required this.product,
    required this.currency,
    required this.sellerId,
  }) : super(key: key);
  final String todayCategory;
  final String productId;
  final Size size;
  final ProductModel product;
  final String currency;
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: MyCollection.user.doc(sellerId).get(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                ),
                Container(
                  color: Colors.white,
                  height: 30,
                  width: 100,
                ),
              ],
            ),
            baseColor: MyColor.grey,
            highlightColor: MyColor.grey2,
            direction: ShimmerDirection.ltr,
          );
        }
        final _seller =
            UserModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
        return Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.store),
                    child: Row(
                      children: [
                        Container(
                          height: size.height * 0.06,
                          width: size.height * 0.06,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                _seller.imageUrl,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _seller.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.store_mall_directory_rounded),
                                const SizedBox(width: 5),
                                Text(
                                  _seller.storeName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.yellow
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MyColor.cream,
                    ),
                    child: Center(
                      child: Text(
                        "Rp " + currency,
                        style: const TextStyle(color: MyColor.yellow),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum ut tristique et egestas quis ipsum suspendisse ultrices gravida. Sit amet consectetur adipiscing elit duis tristique sollicitudin. Iaculis nunc sed augue lacus viverra vitae congue eu. Sapien pellentesque habitant morbi tristique senectus et netus et. Leo duis ut diam quam nulla porttitor. Arcu non odio euismod lacinia. Nec feugiat nisl pretium",
                style: TextStyle(color: MyColor.grey),
              ),
              const SizedBox(height: 30),
              const Text(
                "fusce id velit ut tortor pretium. Nunc sed augue lacus viverra vitae congue eu consequat ac. Scelerisque felis imperdiet proin fermentum leo vel orci. Pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat vivamus at. Mauris rhoncus aenean vel elit. Eget aliquet nibh praesent tristique magna sit amet. Donec et odio pellentesque diam volutpat commodo sed egestas egestas. Vulputate mi sit amet mauris. Nulla pharetra diam sit amet. Nulla pharetra diam sit amet nisl. Eget felis eget nunc lobortis. Sagittis eu volutpat odio facilisis mauris sit. Id volutpat lacus laoreet non.",
                style: TextStyle(color: MyColor.grey),
              ),
              SizedBox(height: size.height * 0.1),
            ],
          ),
        );
      },
    );
  }
}
