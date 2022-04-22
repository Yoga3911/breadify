import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/views/product/widgets/store_header.dart';
import 'package:project/app/views/product/widgets/store_product.dart';
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
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.addProduct),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    backgroundColor: MyColor.red2,
                  )
                : null,
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<ProductModel>>(
                  future: productProvider.getByStoreId(args["id"]),
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
                    return StoreProduct(
                      productModel: snapshot.data ?? [],
                      storeName: args["name"],
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
