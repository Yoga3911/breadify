import 'package:flutter/material.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/view_model/notif_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';

//utk konten Notif :
import 'package:project/app/views/cart/widgets_notif/konten_notif.dart';

// final List<NotifContent> notifcontent = [
//   NotifContent(
//       status: "Transaction successful",
//       product: "Pain au Cholate",
//       note: "Your order will be delivered soon.\nPlease be patient",
//       price: "Rp 60.000",
//       date: "18-03-2022 10.00 AM"),
//   NotifContent(
//       status: "Transaction successful",
//       product: "Cheese Toast",
//       note: "Your order will be delivered soon.\nPlease be patient",
//       price: "Rp 108.000",
//       date: "16-03-2022 10.30 AM"),
//   NotifContent(
//       status: "Transaction successful",
//       product: "Strawberry Cupcakes",
//       note: "Your order will be delivered soon.\nPlease be patient",
//       price: "Rp 24.000",
//       date: "8-03-2022 06.00 PM"),
// ];

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notif = Provider.of<NotifProvider>(context);
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              return Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          title: const Text(
            "Notifications",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          future:
              notif.getAllNotif("3", context.read<UserProvider>().getUser.id),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            return ListView.builder(
              itemCount: notif.getNotif.length,
              itemBuilder: (context, index) => Notif(
                notifModel: notif.getNotif[index],
              ),
            );
          },
        ),
      ),
    );
  }
}