import 'package:flutter/material.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/cart_model.dart';
import '../../../view_model/cart_provider.dart';

class ChooseAll extends StatelessWidget {
  const ChooseAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    return Consumer<CartProvider>(
      builder: (_, notifier, __) => Checkbox(
        value: notifier.getSelectAll,
        onChanged: (tap) {
          notifier.setSelectAll = tap!;
          int loop = 0;
          for (var item in notifier.getCartData) {
            if (tap && !item.getChecked) {
              notifier.setTotal = 1;
              item.setChecked = tap;
              if (loop == 0) {
                for (CartModel cart in notifier.getCartData) {
                  notifier.cartData.add(cart);
                  for (var prod in product.getAllProduct) {
                    if (prod.id == cart.productId) {
                      notifier.setTotalMoney = cart.getTotalItem * prod.price;
                    }
                  }
                }
              }
            } else if (!tap && item.getChecked) {
              item.setChecked = !tap;
              notifier.setTotal = -1;
              if (loop == 0) {
                for (CartModel cart in notifier.getCartData) {
                  notifier.cartData.remove(cart);
                  for (var prod in product.getAllProduct) {
                    if (prod.id == cart.productId) {
                      notifier.setTotalMoney =
                          -(cart.getTotalItem * prod.price);
                    }
                  }
                }
              }
            } else if (!tap && notifier.getTotal == 0) {
              notifier.setTotal = 0;
              notifier.setSelectAll = tap;
            } else if (tap && notifier.getTotal != 0) {
              notifier.setTotal = 0;
              notifier.setSelectAll = tap;
            }
            item.setChecked = notifier.getSelectAll;
            loop += 1;
          }
        },
      ),
    );
  }
}
