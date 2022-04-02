import 'dart:html';

import 'package:flutter/material.dart';

//memanggil kerangka notif :
import '../notif.dart';

class Notif extends StatelessWidget {
  const Notif({required this.index, Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //1) anak ke-1 : row yang berisi icon & column for text
          Row(
            children: <Widget>[
              //1a) icon notif
              Transform.scale(
                scale: 0.7,
                child: Image.asset("assets/icons/checklist.png"),
              ),

              //1b) column for text : status, product, note
              Column(
                children: <Widget>[
                  //status transaksi
                  Text(notifcontent[index].status),
                  //product/menu
                  Text(notifcontent[index].product),
                  //note
                  Text(notifcontent[index].note),
                ],
              )
            ],
          )

          //2) anak ke-2 : column for text
        ],
      ),
    );
  }
}
