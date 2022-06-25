import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/app/models/orders_models.dart';
import 'package:project/app/view_model/order_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constant/collection.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({required this.orderModel, Key? key}) : super(key: key);

  final OrderModel orderModel;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 10, right: 10),
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
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            context.read<OrderProvider>().deleteOrder(
                                  orderId: widget.orderModel.id,
                                );
                            Navigator.pop(ctx);
                          },
                          child: const Text("Delete History"),
                        )
                      ],
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: widget.orderModel.data
                                .map((e) => FutureBuilder<QuerySnapshot>(
                                    future: MyCollection.product
                                        .where("id", isEqualTo: e)
                                        .get(),
                                    builder: (_, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const SizedBox();
                                      }
                                      var data = "";
                                      for (var i in snapshot.data!.docs) {
                                        data += "• " +
                                            (i.data()! as Map<String, dynamic>)[
                                                "name"];
                                      }
                                      return Text(data);
                                    }))
                                .toList(),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                "Roti telah diterima",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      title: const Text("Detail Order"),
                    )).then((value) {
              setState(() {});
            });
          },
          child: Row(
            children: <Widget>[
              //1) icon motor
              Transform.scale(
                scale: 0.7,
                child: Image.asset("assets/icons/motor.png"),
              ),

              //2) text : address, status, date
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //2a)address
                    Flexible(
                      child: Text(
                        widget.orderModel.address,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),

                    //2b)status
                    Text(
                      widget.orderModel.message,
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
                      DateFormat("dd MMM yyyy")
                          .format(widget.orderModel.orderDate),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 10),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}