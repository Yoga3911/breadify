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
      date: "18-03-2022 10.00 AM"),
  NotifContent(
      status: "Transaction successful",
      product: "Cheese Toast",
      note: "Your order will be delivered soon.\nPlease be patient",
      price: "Rp 108.000",
      date: "16-03-2022 10.30 AM"),
  NotifContent(
      status: "Transaction successful",
      product: "Strawberry Cupcakes",
      note: "Your order will be delivered soon.\nPlease be patient",
      price: "Rp 24.000",
      date: "8-03-2022 06.00 PM"),

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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
