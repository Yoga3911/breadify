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
          automaticallyImplyLeading: false,
          title: const Text(
            "Favorite",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
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
              listFavorite(
                  context,
                  "https://img.qraved.co/v2/image/data/2016/05/16/12725205_1145755085435610_1979819820_n-x.jpg",
                  "Cheese Toast",
                  "Wina Bakery"),
              listFavorite(
                  context,
                  "https://www.elmundoeats.com/wp-content/uploads/2018/06/Yeasted-Sweet-Potato-Donuts.jpg",
                  "Potato Doughnout",
                  "Vincii Bakery"),
              listFavorite(
                  context,
                  "https://selerasa.com/wp-content/uploads/2016/07/images_cupcake-cappuccino.jpg",
                  "Cupcake",
                  "Yahuu Bakery"),
              listFavorite(
                  context,
                  "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/3/17/fba8e141-4664-4137-a9ed-dc5d6908e3e3.jpg",
                  "Red Velvet",
                  "Wina Bakery"),
              listFavorite(
                  context,
                  "http://kampoengroti.com/data/product/207.jpg",
                  "Roti Coklat",
                  "Ahooy Bakery"),
              listFavorite(
                  context,
                  "https://1.bp.blogspot.com/-pidi3vMShyk/VuEgoD1BAyI/AAAAAAAAA1w/tG_YkRt_ahw/s640/Cara-Membuat-Roti-Manis-Lembut.jpg",
                  "Roti Manis",
                  "Kampret Bakery"),
              listFavorite(
                  context,
                  "https://img-global.cpcdn.com/recipes/e1d0575715abd80e/751x532cq70/roti-abon-foto-resep-utama.jpg",
                  "Roti Abon",
                  "Mooo Bakery"),
            ]),
      ),
    );
  }

  Material listFavorite(
      BuildContext context, String img, String text1, String text2) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: const Image(
                image: AssetImage("assets/images/sampul.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [Colors.transparent, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Align(
                  alignment: const Alignment(-1, 0.68),
                  child: AutoSizeText(
                    text1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0.97),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15,
                            color: MyColor.yellow,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
