import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project/app/models/store_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constant/color.dart';
import '../../../../view_model/store_provider.dart';
import 'card.dart';
import '../../../../view_model/product_provider.dart';
import '../../../../routes/route.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final store = Provider.of<StoreProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Consumer<ProductProvider>(
        builder: (_, val, __) => (val.getStatus == state.loading)
            ? MasonryGridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                cacheExtent: 10000,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? 2
                      : 3,
                ),
                itemBuilder: (_, index) {
                  return Shimmer.fromColors(
                    baseColor: MyColor.grey2,
                    highlightColor: MyColor.grey3,
                    direction: ShimmerDirection.ltr,
                    child: Container(
                      height:
                          index.isOdd ? size.height * 0.24 : size.height * 0.3,
                      decoration: BoxDecoration(
                        color: MyColor.yellow,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
              )
            : (val.getDataFilter.isEmpty)
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/not_found.png"),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Tidak ada data",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ))
                : MasonryGridView.builder(
                    cacheExtent: 10000,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productProvider.getDataFilter.length,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? 2
                          : 3,
                    ),
                    itemBuilder: (_, index) {
                      return FutureBuilder<StoreModel>(
                        future: store.getStoreById(
                            productProvider.getDataFilter[index].storeId),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Shimmer.fromColors(
                              baseColor: MyColor.grey2,
                              highlightColor: MyColor.grey3,
                              direction: ShimmerDirection.ltr,
                              child: Container(
                                height: index.isOdd
                                    ? size.height * 0.24
                                    : size.height * 0.3,
                                decoration: BoxDecoration(
                                  color: MyColor.yellow,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            );
                          }
                          return ChangeNotifierProvider(
                            create: (_) => productProvider.getDataFilter[index],
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.product,
                                  arguments: {
                                    "id":
                                        productProvider.getDataFilter[index].id,
                                    "name": productProvider
                                        .getDataFilter[index].name,
                                    "price": productProvider
                                        .getDataFilter[index].price,
                                    "quantity": productProvider
                                        .getDataFilter[index].quantity,
                                    "image": productProvider
                                        .getDataFilter[index].image,
                                    "store_id": productProvider
                                        .getDataFilter[index].storeId,
                                  },
                                );
                              },
                              child: Hero(
                                tag: productProvider.getDataFilter[index].id +
                                    "hero",
                                child: ProductCard(
                                  index: index,
                                  product: productProvider.getDataFilter[index],
                                  storeName: snapshot.data!.storeName,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
