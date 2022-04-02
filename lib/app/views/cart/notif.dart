import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';

//pemanggilan class
import '../../models/notif_models.dart';

//utk konten Notif :
import 'package:project/app/views/cart/widgets_notif/konten_notif.dart';

final List<NotifContent> notifcontent = [
  NotifContent(
      status: "Transaction successful",
      product: "Pain au Cholate",
      note: "Your order will be delivered soon.\nPlease be patient",
      price: "Rp 60.000",
      date: "08-03-2022 10.00 AM"),
  NotifContent(
      status: "status",
      product: "product",
      note: "note",
      price: "price",
      date: "date"),
  NotifContent(
      status: "status",
      product: "product",
      note: "note",
      price: "price",
      date: "date"),
];

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: "Back",
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Notifications",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: notifcontent.length,
          itemBuilder: (context, index) => Notif(index: index),
        ),
      ),
    );
  }
}
