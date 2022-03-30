import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/constant/glow.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Favorite"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
            )
          ],
        ),
        body: GridView(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2 / 3,
          ),
          children: [
            list_favorite(
              context,
              "https://img.qraved.co/v2/image/data/2016/05/16/12725205_1145755085435610_1979819820_n-x.jpg",
              "Cheese Toast",
              "Wina Bakery"),
            list_favorite(
              context,
              "https://www.elmundoeats.com/wp-content/uploads/2018/06/Yeasted-Sweet-Potato-Donuts.jpg",
              "Potato Doug...",
              "Vincii Bakery"),
            list_favorite(
              context,
              "https://selerasa.com/wp-content/uploads/2016/07/images_cupcake-cappuccino.jpg",
              "Cupcake",
              "Yahuu Bakery"),
            list_favorite(
              context,
              "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/3/17/fba8e141-4664-4137-a9ed-dc5d6908e3e3.jpg",
              "Red Velvet",
              "Wina Bakery"),
            list_favorite(
              context,
              "http://kampoengroti.com/data/product/207.jpg",
              "Roti Coklat",
              "Ahooy Bakery")
          ]
        ),
      ),
    );
  }

  Stack list_favorite(
      BuildContext context, String img, String text1, String text2) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              image: NetworkImage(img),
              fit: BoxFit.cover,
              )
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.28, 0, 0),
          child: Row(
            children: [
              Spacer(
                flex: 1,
              ),
              Column(
                children: [
                  Text(
                    text1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColor.yellow,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 40,
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
