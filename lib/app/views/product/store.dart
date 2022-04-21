import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../constant/glow.dart';
import '../../models/product_model.dart';
import '../../routes/route.dart';
import '../../constant/color.dart';
import '../../../app/view_model/product_provider.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String sellerImg = args["seller_image"];
    final String storeName = args["name"];
    final String address = args["address"];
    final String open = args["open"];
    final String close = args["close"];
    final String id = args["id"];
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              heroTag: "home",
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
                            bottom: size.height * 0.08,
                          ),
                          height: size.height * 0.3,
                          width: size.width,
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
                            height: size.height * 0.05,
                            width: size.height * 0.05,
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
                                  size: size.height * 0.025,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            height: size.height * 0.05,
                            width: size.height * 0.05,
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
                                  size: size.height * 0.025,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: size.height * 0.22,
                          child: Hero(
                            tag: "profile",
                            child: CircleAvatar(
                              radius: size.height * 0.08,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(sellerImg),
                                radius: size.height * 0.075,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      storeName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Alamat: " + address,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Open: " + open + " - " + close,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
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
                FutureBuilder<List<ProductModel>>(
                  future: productProvider.getByStoreId(id),
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
                                    ? size.height * 0.3
                                    : size.height * 0.4,
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
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: MasonryGridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (_, index) {
                          final _product = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.product,
                                arguments: {
                                  "id": snapshot.data![index].id,
                                  "name": snapshot.data![index].name,
                                  "price": snapshot.data![index].price,
                                  "quantity": snapshot.data![index].quantity,
                                  "image": snapshot.data![index].image,
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
                                    Hero(
                                      tag: _product.id + "hero",
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl: _product.image,
                                          fit: BoxFit.cover,
                                          height: double.infinity,
                                          width: double.infinity,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
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
                                                  _product.name,
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
                                                      storeName,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color.fromARGB(
                                                            255, 255, 204, 0),
                                                      ),
                                                    ),
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
                        },
                      ),
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
