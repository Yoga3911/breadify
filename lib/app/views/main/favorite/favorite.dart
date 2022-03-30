import 'package:flutter/material.dart';
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
              icon: Icon(Icons.shopping_cart,
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
                    Stack(
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
                            child: const Image(image: NetworkImage("https://img.qraved.co/v2/image/data/2016/05/16/12725205_1145755085435610_1979819820_n-x.jpg"),
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
                      ],
                    ),
                    Stack(
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
                            child: const Image(image: NetworkImage("https://www.elmundoeats.com/wp-content/uploads/2018/06/Yeasted-Sweet-Potato-Donuts.jpg"),
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
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}