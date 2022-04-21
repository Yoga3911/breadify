import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/app/models/notif_models.dart';

//memanggil kerangka notif :

class Notif extends StatelessWidget {
  const Notif({required this.notifModel, Key? key}) : super(key: key);

  final NotifModel notifModel;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        //biar bisa di klik :
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //1a) icon notif
                Transform.scale(
                  scale: 0.7,
                  child: Image.asset("assets/icons/checklist.png"),
                ),

                //1b) column for text : status, product, note
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //status transaksi
                      Text(
                        notifModel.message,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                      //product/menu
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notifModel.product,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                                fontSize: 15),
                          ),
                          Text(
                            notifModel.price,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10), //jarak
                      //note
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notifModel.note,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB4B4B4),
                                fontSize: 10),
                          ),
                          Text(
                            DateFormat("dd MMM yyyy").format(notifModel.date),
                            style: const TextStyle(
                                color: Color(0xFFB4B4B4),
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
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
