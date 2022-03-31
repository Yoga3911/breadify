import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/color.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: widget,
      baseColor: MyColor.grey2,
      highlightColor: MyColor.grey3,
      direction: ShimmerDirection.ltr,
    );
  }
}
