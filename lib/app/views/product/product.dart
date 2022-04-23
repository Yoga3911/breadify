import 'package:flutter/material.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:project/app/views/product/widgets/btm_sheet.dart';
import 'package:project/app/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

import '../../constant/glow.dart';
import '../../view_model/user_prodvider.dart';
import '../../views/product/widgets/content.dart';
import '../../views/product/widgets/header.dart';
import '../../models/product_model.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: 
            // (args["seller_id"] == user.getUser.id)
            //     ? Column(
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           FloatingActionButton(
            //             onPressed: () async {
            //               showDialog(
            //                 context: context,
            //                 builder: (_) => AlertDialog(
            //                   title: const Text("Alert"),
            //                   content: const Text(
            //                       "Apakah anda yakin ingin menghapus produk ini?"),
            //                   actions: [
            //                     ElevatedButton(
            //                         onPressed: () => Navigator.pop(context),
            //                         child: const Text("Batal")),
            //                     ElevatedButton(
            //                       onPressed: () async {
            //                         showDialog(
            //                           context: context,
            //                           builder: (_) => const CustomLoading(),
            //                         );
            //                         product.setDataProduct = [];
            //                         await product.deleteById(args["id"]).then(
            //                               (_) =>
            //                                   Navigator.pushNamedAndRemoveUntil(
            //                                 context,
            //                                 Routes.main,
            //                                 (route) => false,
            //                               ),
            //                             );
            //                         ScaffoldMessenger.of(context).showSnackBar(
            //                           const SnackBar(
            //                             duration: Duration(seconds: 3),
            //                             content: Text(
            //                               "Product successfully deleted",
            //                             ),
            //                             backgroundColor: Color(0xFFF9595F),
            //                           ),
            //                         );
            //                       },
            //                       child: const Text("Ya"),
            //                     ),
            //                   ],
            //                 ),
            //               );
            //             },
            //             heroTag: "delete",
            //             backgroundColor: Colors.red,
            //             child: const Icon(
            //               Icons.delete_rounded,
            //               color: Colors.white,
            //             ),
            //           ),
            //           const SizedBox(height: 10),
            //           FloatingActionButton(
            //             onPressed: () {},
            //             heroTag: "edit",
            //             child: const Icon(
            //               Icons.edit_rounded,
            //               color: Colors.white,
            //             ),
            //           ),
            //           const SizedBox(height: 10),
            //         ],
            //       )
                FloatingActionButton.extended(
                    heroTag: "home",
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        backgroundColor: Colors.transparent,
                        builder: (_) => BtmSheet(
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
                  ),
            body: FutureBuilder<ProductModel>(
              future: product.getById(args["id"]),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                return ChangeNotifierProvider(
                  create: (_) => snapshot.data,
                  child: ListView(
                    children: const [
                      HeaderProduct(),
                      ContentProduct(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
