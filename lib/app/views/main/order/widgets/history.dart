import 'package:flutter/material.dart';

//memanggil kerangka orders
import '../order.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({required this.index, Key? key}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      // color: Colors.amber,

      child: Material(
        color: Colors.transparent, //biar bisa di klik
        child: InkWell(
          onTap: () {},
          child: Row(
            children: <Widget>[
              //1) icon motor
              Transform.scale(
                  scale: 0.7, child: Image.asset("assets/icons/motor.jpeg")),

              //2) text
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //2a)address
                  Text(
                    orderscontenthistory[index].address,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15),
                  ),

                  //2b)status
                  Text(
                    orderscontenthistory[index].status,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 10),
                  ),

                  //2c)date
                  Text(
                    orderscontenthistory[index].date,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
