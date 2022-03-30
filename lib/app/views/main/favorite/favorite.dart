import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/constant/glow.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Favorite"),
          actions: [
            IconButton(
              onPressed: (){}, 
              icon: const Icon(Icons.shopping_cart,
              color:Colors.white),
            )
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    left_list(context,"https://www.elmundoeats.com/wp-content/uploads/2018/06/Yeasted-Sweet-Potato-Donuts.jpg", "Potato Doug...", "Vincii Bakery"),
                    right_list(context, "https://img.qraved.co/v2/image/data/2016/05/16/12725205_1145755085435610_1979819820_n-x.jpg", "Cheese Toast", "Wina Bakery"),                 
                  ],
                ),
                Row(
                  children: [
                    left_list(context,"https://selerasa.com/wp-content/uploads/2016/07/images_cupcake-cappuccino.jpg", "Cupcake", "Yahuu Bakery"),
                    right_list(context, "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/3/17/fba8e141-4664-4137-a9ed-dc5d6908e3e3.jpg", "Red Velvet", "Wina Bakery"),
                  ],
                ),
                Row(
                  children: [
                    left_list(context,"http://kampoengroti.com/data/product/207.jpg", "Roti Coklat", "Ahooy Bakery"),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Stack right_list(BuildContext context, String img, String text1, String text2) {
    return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width*0.0165, 
                          15, 
                          MediaQuery.of(context).size.width*0.0335, 
                          0),
                        height: MediaQuery.of(context).size.height*0.35,
                        width: MediaQuery.of(context).size.width*0.45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(image: NetworkImage(img),
                          fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width*0.0165, 
                          15, 
                          MediaQuery.of(context).size.width*0.0335, 
                          0),
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width*0.45,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.white],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width*0.0165, 
                          MediaQuery.of(context).size.height * 0.29, 
                          MediaQuery.of(context).size.width*0.0335, 
                          0),
                        width: MediaQuery.of(context).size.width*0.45,
                        child: Row(
                          children: [
                            Spacer(flex: 1,),
                            Column(
                              children: [
                                Text(text1, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Text(text2, style: TextStyle(fontSize: 15, color: MyColor.yellow, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Spacer(flex: 1,),
                            Icon(Icons.favorite, color: Colors.pink, size: 40,),
                            Spacer(flex: 1,)
                          ],
                        )
                      )
                    ],
                  );
  }

  Stack left_list(BuildContext context, String img, String text1, String text2) {
    return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width*0.0335, 
                          15, 
                          MediaQuery.of(context).size.width*0.0165, 
                          0),
                        height: MediaQuery.of(context).size.height*0.35,
                        width: MediaQuery.of(context).size.width*0.45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(image: NetworkImage(img),
                          fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width*0.0335, 
                          15, 
                          MediaQuery.of(context).size.width*0.0165, 
                          0),
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width*0.45,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.white],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width*0.0335, 
                          MediaQuery.of(context).size.height * 0.29, 
                          MediaQuery.of(context).size.width*0.0165, 
                          0),
                        width: MediaQuery.of(context).size.width*0.45,
                        child: Row(
                          children: [
                            Spacer(flex: 1,),
                            Column(
                              children: [
                                Text(text1, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Text(text2, style: TextStyle(fontSize: 15, color: MyColor.yellow, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Spacer(flex: 1,),
                            Icon(Icons.favorite, color: Colors.pink, size: 40,),
                            Spacer(flex: 1,)
                          ],
                        )
                      )
                    ],
                  );
  }
}