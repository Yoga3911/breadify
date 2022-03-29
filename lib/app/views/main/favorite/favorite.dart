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
                            MediaQuery.of(context).size.width*0.025, 
                            MediaQuery.of(context).size.width*0.025, 
                            MediaQuery.of(context).size.width*0.025, 
                            MediaQuery.of(context).size.width*0.025),
                          height: MediaQuery.of(context).size.height*0.4,
                          width: MediaQuery.of(context).size.width*0.45,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width*0.025, 
                            MediaQuery.of(context).size.width*0.025, 
                            MediaQuery.of(context).size.width*0.025, 
                            MediaQuery.of(context).size.width*0.025),
                          height: MediaQuery.of(context).size.height*0.4,
                          width: MediaQuery.of(context).size.width*0.45,
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