import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/models/product_model.dart';
import 'package:project/app/models/user_model.dart';
import 'package:project/app/routes/route.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/color.dart';
import '../../models/store_model.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserModel _seller = _args["seller"] as UserModel;
    final StoreModel _store = _args["store"] as StoreModel;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, Routes.addProduct),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: MyColor.red2,
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: _size.height * 0.08,
                          ),
                          height: _size.height * 0.3,
                          width: _size.width,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/sampul.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 15,
                          child: Container(
                            height: _size.height * 0.05,
                            width: _size.height * 0.05,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () => Navigator.pop(context),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: _size.height * 0.025,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            height: _size.height * 0.05,
                            width: _size.height * 0.05,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () => Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.main,
                                  (route) => false,
                                ),
                                child: Icon(
                                  Icons.home_rounded,
                                  size: _size.height * 0.025,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: _size.height * 0.22,
                          child: Hero(
                            tag: "profile",
                            child: CircleAvatar(
                              radius: _size.height * 0.08,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(_seller.imageUrl),
                                radius: _size.height * 0.075,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      _store.storeName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Alamat: " + _store.address,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Open: " + _store.open + " - " + _store.close,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "All products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder<QuerySnapshot>(
                  future: MyCollection.product
                      .where("user_id", isEqualTo: _seller.id)
                      .get(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: MasonryGridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          cacheExtent: 10000,
                          itemCount: 6,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (_, index) {
                            return Material(
                              elevation: 5,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? _size.height * 0.3
                                    : _size.height * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: MasonryGridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          cacheExtent: 10000,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (_, index) {
                            final ProductModel product = ProductModel.fromJson(
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>);
                            return Material(
                              elevation: 5,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? _size.height * 0.3
                                    : _size.height * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: CachedNetworkImage(
                                        key: ValueKey(product.image),
                                        cacheKey: product.image,
                                        imageUrl: product.image,
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
                                            ? _size.height * 0.21
                                            : _size.height * 0.4,
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
                                                alignment: index.isOdd
                                                    ? const Alignment(-1, 0.5)
                                                    : const Alignment(-1, 0.65),
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
                                                    Text(
                                                      product.storeName,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color.fromARGB(
                                                            255, 255, 204, 0),
                                                      ),
                                                    ),
                                                    Image.asset(
                                                        "assets/icons/fav1.png")
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
                            );
                          }),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
