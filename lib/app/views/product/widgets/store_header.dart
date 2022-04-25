import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../routes/route.dart';

class StoreHeader extends StatelessWidget {
  const StoreHeader(
      {Key? key,
      required this.storeName,
      required this.address,
      required this.open,
      required this.close,
      required this.sellerImg})
      : super(key: key);

  final String storeName;
  final String address;
  final String sellerImg;
  final String open;
  final String close;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: size.height * 0.08,
              ),
              height: size.height * 0.3,
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/sampul.jpg"),
                  fit: BoxFit.cover,
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
                    onTap: () => Navigator.pop(context),
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
              top: size.height * 0.22,
              child: Hero(
                tag: "profile",
                child: CircleAvatar(
                  radius: size.height * 0.08,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: size.height * 0.075,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: sellerImg,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Text(
          storeName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "Alamat: " + address,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "Open: " + open + " - " + close,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
