import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/models/favorite_model.dart';
import 'package:project/app/models/store_model.dart';
import 'package:project/app/view_model/favorite_provider.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:project/app/view_model/store_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model.dart';
import '../../../routes/route.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Favorite",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<FavoriteModel>>(
              future: context
                  .read<FavoriteProvider>()
                  .getAllFav(userId: context.read<UserProvider>().getUser.id),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: SizedBox(),
                  );
                }
                final data = snapshot.data;
                return MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  itemCount: data!.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (_, index) {
                    return FutureBuilder<ProductModel>(
                        future: context
                            .read<ProductProvider>()
                            .getById(data[index].productId),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          }
                          final product = snapshot.data;
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.product,
                                arguments: {
                                  "id": product!.id,
                                  "name": product.name,
                                  "price": product.price,
                                  "quantity": product.quantity,
                                  "image": product.image,
                                  "store_id": product.storeId,
                                  "product": product
                                },
                              );
                            },
                            child: Material(
                              elevation: 5,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? size.height * 0.3
                                    : size.height * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl: product!.image,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: (MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait)
                                            ? size.height * 0.21
                                            : size.height * 0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromARGB(0, 255, 255, 255),
                                              Colors.white,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment:
                                                    const Alignment(-1, 0.55),
                                                child: Text(
                                                  product.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    const Alignment(-1, 0.95),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    FutureBuilder<StoreModel>(
                                                        future: context
                                                            .read<
                                                                StoreProvider>()
                                                            .getStoreById(
                                                                product
                                                                    .storeId),
                                                        builder: (_, snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const Text(
                                                                "Loading ...");
                                                          }
                                                          final store =
                                                              snapshot.data;
                                                          return Text(
                                                            store!.storeName,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  MyColor.red,
                                                            ),
                                                          );
                                                        }),
                                                    Image.asset(
                                                      "assets/icons/fav1.png",
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                );
              }),
        ),
      ),
    );
  }

  Material listFavorite(
      BuildContext context, String img, String text1, String text2) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: const Image(
                image: AssetImage("assets/images/sampul.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [Colors.transparent, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Align(
                  alignment: const Alignment(-1, 0.68),
                  child: AutoSizeText(
                    text1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0.97),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15,
                            color: MyColor.yellow,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
