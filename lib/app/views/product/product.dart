import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/views/product/widgets/btm_sheet.dart';
import 'package:project/app/widgets/currency.dart';

import '../../constant/glow.dart';
import '../../views/product/widgets/content.dart';
import '../../views/product/widgets/header.dart';
import '../../models/product_model.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final ProductModel product = args["product"];

    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              heroTag: "home",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  backgroundColor: Colors.transparent,
                  builder: (_) => BtmSheet(product: product),
                );
              },
              label: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.2,
                  right: size.width * 0.2,
                ),
                child: const Text(
                  "Add to cart",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            body: ListView(
              children: [
                HeaderProduct(
                  product: product,
                ),
                ContentProduct(
                  product: product,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
