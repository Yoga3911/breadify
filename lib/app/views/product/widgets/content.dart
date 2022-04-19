import 'package:flutter/material.dart';
import 'package:project/app/widgets/currency.dart';
import 'package:provider/provider.dart';

import '../../../view_model/store_provider.dart';
import '../../../view_model/user_prodvider.dart';
import '../../../widgets/shimmer.dart';
import '../../../routes/route.dart';
import '../../../constant/color.dart';
import '../../../models/product_model.dart';
import '../../../models/user_model.dart';

class ContentProduct extends StatelessWidget {
  const ContentProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final product = Provider.of<ProductModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: FutureBuilder(
        future: storeProvider.getById(product.storeId),
        builder: (_, store) {
          if (store.connectionState == ConnectionState.waiting) {
            return Row(
              children: [
                CustomShimmer(
                  widget: Container(
                    margin: const EdgeInsets.only(right: 20),
                    height: size.height * 0.06,
                    width: size.height * 0.06,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                CustomShimmer(
                  widget: Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 100,
                  ),
                ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<UserModel>(
                    future: userProvider.getUserById(storeProvider.getStore.userId),
                    builder: (_, user) {
                      if (user.connectionState == ConnectionState.waiting) {
                        return Row(
                          children: [
                            CustomShimmer(
                              widget: Container(
                                margin: const EdgeInsets.only(right: 20),
                                height: size.height * 0.06,
                                width: size.height * 0.06,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            CustomShimmer(
                              widget: Container(
                                margin: const EdgeInsets.only(top: 10),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 100,
                              ),
                            ),
                          ],
                        );
                      }
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.store,
                          arguments: {
                            "seller": user.data,
                            "store": store.data,
                          },
                        ),
                        child: Row(
                          children: [
                            Hero(
                              tag: "profile",
                              child: Container(
                                height: size.height * 0.06,
                                width: size.height * 0.06,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      user.data!.imageUrl,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.data!.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                        Icons.store_mall_directory_rounded),
                                    const SizedBox(width: 5),
                                    Text(
                                      storeProvider.getStore.storeName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyColor.yellow,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      right: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MyColor.cream,
                    ),
                    child: Center(
                      child: Text(
                        "Rp " + currency(product.price),
                        style: const TextStyle(
                            color: MyColor.yellow, fontWeight: FontWeight.bold),
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
          );
        },
      ),
    );
  }
}
