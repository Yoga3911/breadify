import 'package:flutter/material.dart';

//memanggil kerangka orders
import '../order.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({required this.index, Key? key}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.1,
        color: Colors.blue,
        child: Row(children: <Widget>[
          //icon motor
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/motor.jpeg"),
                    fit: BoxFit.cover)),
            // height: 30,
          )
        ]),
      ),
    );
  }
}
