import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/cart_provider.dart';

class ChooseAll extends StatelessWidget {
  const ChooseAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, notifier, __) => Checkbox(
        value: notifier.getSelectAll,
        onChanged: (tap) {
          notifier.setSelectAll = tap!;
          notifier.getCartData.then(
            (value) {
              for (var item in value) {
                if (tap && !item.getChecked) {
                  notifier.setTotal = 1;
                  item.setChecked = tap;
                } else if (!tap && item.getChecked) {
                  item.setChecked = !tap;
                  notifier.setTotal = -1;
                } else if (!tap && notifier.getTotal == 0) {
                  notifier.setTotal = 0;
                  notifier.setSelectAll = tap;
                } else if (tap && notifier.getTotal != 0) {
                  notifier.setTotal = 0;
                  notifier.setSelectAll = tap;
                }
                item.setChecked = notifier.getSelectAll;
              }
            },
          );
        },
      ),
    );
  }
}
