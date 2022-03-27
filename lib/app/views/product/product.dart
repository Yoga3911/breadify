import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/views/product/widgets/content.dart';
import 'package:project/app/views/product/widgets/header.dart';

import '../../models/product_model.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _args =
        (ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>);
    final String _productId = _args["product_id"];
    final ProductModel _product = _args["product_data"];
    final _todayCategory = _args["category"];
    final String _sellerId = _args["seller_id"];

    final Size _size = MediaQuery.of(context).size;

    final String _reversed =
        _product.price.toString().split("").reversed.join();
    String _reverseC = "";
    int _step = 0;

    for (int i = 0; i < _reversed.length; i++) {
      _reverseC += _reversed[i];
      if (_reversed.length > 3) {
        if (_step == 2) {
          _reverseC += ".";
        }
        _step += 1;
        if (_step == 3) {
          _step = 0;
        }
      }
    }
    final String _currency = _reverseC.split("").reversed.join();

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
              onPressed: () {},
              label: Padding(
                padding: EdgeInsets.only(
                  left: _size.width * 0.2,
                  right: _size.width * 0.2,
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
                  todayCategory: _todayCategory,
                  productId: _productId,
                  size: _size,
                  product: _product,
                ),
                ContentProduct(
                  todayCategory: _todayCategory,
                  productId: _productId,
                  size: _size,
                  product: _product,
                  currency: _currency,
                  sellerId: _sellerId,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
