import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/color.dart';

class ShimmerCart extends StatelessWidget {
  const ShimmerCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: false,
            onChanged: (tap) {},
          ),
          Shimmer.fromColors(
            baseColor: MyColor.grey2,
            highlightColor: MyColor.grey3,
            direction: ShimmerDirection.ltr,
            child: Container(
              height: size.height * 0.15,
              width: size.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
