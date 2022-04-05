import 'package:flutter/material.dart';

//memanggil kerangka notif :
import '../notif.dart';

class Notif extends StatelessWidget {
  const Notif({required this.index, Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.1,
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //status transaksi
                        Text(
                          notifcontent[index].status,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                        ),
                        //product/menu
                        Text(
                          notifcontent[index].product,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                              fontSize: 15),
                        ),
                        const SizedBox(height: 10), //jarak
                        //note
                        Text(
                          notifcontent[index].note,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB4B4B4),
                              fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),

                //2) anak ke-2 : column for text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    //2a) price
                    Text(
                      notifcontent[index].price,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(height: 25),

                    //2b) icon jam & date
                    Row(
                      children: [
                        //icon jam
                        const Icon(
                          Icons.watch_later_outlined,
                          color: Color(0xFFB4B4B4),
                          size: 12,
                        ),
                        const SizedBox(width: 3), //jarak
                        //date
                        Text(
                          notifcontent[index].date,
                          style: const TextStyle(
                              color: Color(0xFFB4B4B4),
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
