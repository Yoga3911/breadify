import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/models/orders_models.dart';
import 'package:project/app/view_model/order_provider.dart';
import 'package:provider/provider.dart';

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
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: orderModel.data
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
                          const Text("Apakah pesanan sudah diterima?")
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: MyColor.yellow),
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: const Text("Belum")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: MyColor.yellow),
                            onPressed: () {
                              context
                                  .read<OrderProvider>()
                                  .updateOrder(orderId: orderModel.id);
                              Navigator.pop(ctx);
                            },
                            child: const Text("Ya")),
                      ],
                      title: const Text("Detail Order"),
                    ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //anak 1 : Row utk icon (1) dan text (2)
              Expanded(
                child: Row(
                  children: <Widget>[
                    //1) icon motor
                    Transform.scale(
                      scale: 0.7,
                      child: Image.asset("assets/icons/motor.png"),
                    ),

                    //2) text : address, status, date
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //2a)address
                          Text(
                            orderModel.address,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
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
                                fontSize: 11),
                          ),

                          const SizedBox(
                            //jarak
                            height: 6,
                          ),

                          //2c)date
                          Text(
                            DateFormat("dd MMM yyyy")
                                .format(orderModel.orderDate),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 92, 92, 92),
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //anak 2 : utk button
              //3) button "cancel"
              IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => AlertDialog(
                            content: const Text(
                                "Apakah anda yakin ingin menghapus data ini?"),
                            title: const Text("Perhatian!"),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: MyColor.yellow),
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: const Text("Tidak"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: MyColor.yellow),
                                onPressed: () {
                                  context
                                      .read<OrderProvider>()
                                      .deleteOrder(orderId: orderModel.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Data pesanan berhasil dihapus"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  Navigator.pop(ctx);
                                },
                                child: const Text("Ya"),
                              ),
                            ],
                          ));
                },
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
