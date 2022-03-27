import 'package:flutter/material.dart';

//memanggil kerangka orders :
import '../order.dart';

class OngoingPage extends StatelessWidget {
  const OngoingPage({required this.index, Key? key}) : super(key: key);

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

      //biar bisa di klik :
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: <Widget>[
              //1) icon motor
              Transform.scale(
                  scale: 0.7, child: Image.asset("assets/icons/motor.jpeg")),

              //2) text : address, status, date
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //2a)address
                  Text(
                    ordercontentongoing[index].address,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15),
                  ),

                  //2b)status
                  Text(
                    ordercontentongoing[index].status,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 10),
                  ),

                  const SizedBox(
                    //jarak
                    height: 6,
                  ),

                  //2c)date
                  Text(
                    ordercontentongoing[index].date,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 10),
                  ),
                ],
              ),

              //3) button "cancel"
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.amber,
                ),
                tooltip: "cancel",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
