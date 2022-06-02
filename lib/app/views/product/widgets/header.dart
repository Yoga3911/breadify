import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model.dart';
import '../../../routes/route.dart';

class HeaderProduct extends StatelessWidget {
  const HeaderProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    final product = Provider.of<ProductModel?>(context, listen: true);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onDoubleTap: () async {
            if (!product!.isChecked) {
              await player.play(
                  "https://firebasestorage.googleapis.com/v0/b/breadify-a4a04.appspot.com/o/ring.mp3?alt=media&token=470e2a49-1586-440d-abdf-51bb6fafa210");
              await Future.delayed(const Duration(milliseconds: 500));
              productProvider.updateFavorite(product.id, true);
              product.setChecked = true;
            } else if (product.isChecked) {
              productProvider.updateFavorite(product.id, false);
              product.setChecked = false;
            }
          },
          child: Hero(
            tag: (product?.id ?? "") + "hero",
            child: SizedBox(
              height: size.height * 0.4,
              width: size.width,
              child: CachedNetworkImage(
                imageUrl: product?.image ??
                    "https://firebasestorage.googleapis.com/v0/b/breadify-a4a04.appspot.com/o/products%2Fno-product.png?alt=media&token=28247cc4-d472-4aef-b1c7-517fd62f84d1",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Container(
            height: size.height * 0.05,
            width: size.height * 0.05,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: size.height * 0.025,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 15,
          right: 15,
          child: Container(
            height: size.height * 0.05,
            width: size.height * 0.05,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.main,
                  (route) => false,
                ),
                child: Icon(
                  Icons.home_rounded,
                  size: size.height * 0.025,
                ),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            right: 15,
            child: Consumer<ProductModel>(
              builder: (_, val, __) => val.isChecked
                  ? const Icon(
                      Icons.favorite_rounded,
                      color: Color(0xFFF9595F),
                      size: 40,
                    )
                  : const Icon(
                      Icons.favorite_border_rounded,
                      size: 40,
                    ),
            )),
      ],
    );
  }
}
