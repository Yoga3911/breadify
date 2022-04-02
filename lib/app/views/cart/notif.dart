import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';

final List<NotifContent> notifcontent = [
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
            }, tooltip: "Back",
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
      ),
    );
  }
}

class NotifContent {
  final String status;
  final String product;
  final String note;
  final String price;
  final String date;

  NotifContent(
      {required this.status,
      required this.product,
      required this.note,
      required this.price,
      required this.date});
}
