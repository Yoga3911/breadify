import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/models/user_model.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/views/product/widgets/store_header.dart';
import 'package:project/app/views/product/widgets/store_product.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/glow.dart';
import '../../models/product_model.dart';
import '../../routes/route.dart';
import '../../constant/color.dart';
import '../../../app/view_model/product_provider.dart';
import '../chat/room.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: Scaffold(
            floatingActionButton: (args["seller_id"] == user.getUser.id)
                ? FloatingActionButton(
                    heroTag: "home",
                    onPressed: () => Navigator.pushNamed(
                      context,
                      Routes.addProduct,
                      arguments: {
                        "action": "add",
                        "store_id": args["id"],
                      },
                    ).then((_) {
                      setState(() {});
                    }),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    backgroundColor: MyColor.yellow,
                  )
                : FutureBuilder<QuerySnapshot>(
                    future: MyCollection.user
                        .doc(user.getUser.id)
                        .collection("chats")
                        .get(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      return FutureBuilder<DocumentSnapshot>(
                          future:
                              MyCollection.user.doc(args["seller_id"]).get(),
                          builder: (_, snapshot2) {
                            if (snapshot2.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox();
                            }
                            final userModel = UserModel.fromJson(
                              snapshot2.data!.data() as Map<String, dynamic>,
                            );
                            return FloatingActionButton(
                              heroTag: "home",
                              onPressed: () {
                                for (var i in snapshot.data!.docs) {
                                  if ((i.data()
                                          as Map<String, dynamic>)["user_id"] ==
                                      userModel.id) {
                                    MyCollection.user
                                        .doc(userModel.id)
                                        .collection("chats")
                                        .doc(i.id)
                                        .update({
                                      "unread": 0,
                                      "onRoom": true,
                                    });
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RoomChat(
                                          userModel: userModel,
                                          docId: i.id,
                                          onRoom: true,
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                }
                                final doc = MyCollection.chat.doc();
                                doc.set({
                                  "members": [user.getUser.id, userModel.id]
                                });
                                MyCollection.user
                                    .doc(user.getUser.id)
                                    .collection("chats")
                                    .doc(doc.id)
                                    .set({
                                  "user_id": userModel.id,
                                  "unread": 0,
                                  "onRoom": false,
                                  "isTyping": false,
                                  "date": DateTime.now(),
                                });
                                MyCollection.user
                                    .doc(userModel.id)
                                    .collection("chats")
                                    .doc(doc.id)
                                    .set({
                                  "user_id": user.getUser.id,
                                  "unread": 0,
                                  "isTyping": false,
                                  "onRoom": true,
                                  "date": DateTime.now(),
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RoomChat(
                                      userModel: userModel,
                                      docId: doc.id,
                                      onRoom: true,
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.chat_rounded,
                                color: Colors.white,
                              ),
                              backgroundColor: MyColor.red2,
                            );
                          });
                    }),
            body: ListView(
              children: [
                StoreHeader(
                  address: args["address"],
                  close: args["close"],
                  open: args["open"],
                  storeName: args["name"],
                  sellerImg: args["seller_image"],
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "All products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 10),
                (args["seller_id"] == user.getUser.id)
                    ? FutureBuilder<List<ProductModel>>(
                        future: productProvider.getByStoreId(args["id"]),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: ListView.builder(
                                itemCount: 4,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) => Shimmer.fromColors(
                                  baseColor: MyColor.grey2,
                                  highlightColor: MyColor.grey3,
                                  direction: ShimmerDirection.ltr,
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    height: 55,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return StoreProduct(
                            productModel: snapshot.data ?? [],
                            storeName: args["name"],
                            sellerId: args["seller_id"],
                            storeId: args["id"],
                          );
                        },
                      )
                    : FutureBuilder<List<ProductModel>>(
                        future: productProvider.getByStoreId(args["id"]),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: MasonryGridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                itemCount: 4,
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (_, index) {
                                  return Shimmer.fromColors(
                                    baseColor: MyColor.grey2,
                                    highlightColor: MyColor.grey3,
                                    direction: ShimmerDirection.ltr,
                                    child: Container(
                                      height:
                                          (MediaQuery.of(context).orientation ==
                                                  Orientation.portrait)
                                              ? size.height * 0.3
                                              : size.height * 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return StoreProduct(
                            productModel: snapshot.data ?? [],
                            storeName: args["name"],
                            sellerId: args["seller_id"],
                            storeId: args["id"],
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}