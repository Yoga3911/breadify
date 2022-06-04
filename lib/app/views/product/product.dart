import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/views/product/widgets/btm_sheet.dart';
import 'package:provider/provider.dart';

import '../../constant/glow.dart';
import '../../views/product/widgets/content.dart';
import '../../views/product/widgets/header.dart';
import '../../models/product_model.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final ProductModel productModel = args["product"];
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FutureBuilder<DocumentSnapshot>(
                future: MyCollection.store.doc(args["store_id"]).get(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return FloatingActionButton.extended(
                      heroTag: "home",
                      onPressed: () {},
                      label: Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.2,
                          right: size.width * 0.2,
                        ),
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    );
                  }
                  return ((snapshot.data!.data()
                              as Map<String, dynamic>)["user_id"] ==
                          user.getUser.id)
                      ? const SizedBox()
                      : FloatingActionButton.extended(
                          heroTag: "home",
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isDismissible: false,
                              backgroundColor: Colors.transparent,
                              builder: (_) => BtmSheet(
                                productId: args["id"],
                                name: args["name"],
                                price: args["price"],
                                quantity: args["quantity"],
                                image: args["image"],
                              ),
                            );
                          },
                          label: Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.2,
                              right: size.width * 0.2,
                            ),
                            child: const Text(
                              "Add to cart",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 16),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        );
                },
              ),
              body: ChangeNotifierProvider.value(
                value: productModel,
                child: ListView(
                  children: const [
                    HeaderProduct(),
                    ContentProduct(),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
