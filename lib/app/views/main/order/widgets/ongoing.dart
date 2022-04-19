import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/app/models/orders_models.dart';

//memanggil kerangka orders :
import '../order.dart';

class OngoingPage extends StatelessWidget {
  const OngoingPage({required this.orderModel, Key? key}) : super(key: key);

  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: const BoxDecoration(
        // color: Colors.blue,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //anak 1 : Row utk icon (1) dan text (2)
              Row(
                children: <Widget>[
                  //1) icon motor
                  Transform.scale(
                    scale: 0.7,
                    child: Image.asset("assets/icons/motor.png"),
                  ),

                  //2) text : address, status, date
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //2a)address
                      Text(
                        orderModel.address,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      ),

                      //2b)status
                      Text(
                        orderModel.message,
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
                        DateFormat("dd MMM yyyy").format(orderModel.orderDate),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),

              //anak 2 : utk button
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
