import 'package:flutter/material.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:provider/provider.dart';

import '../../constant/glow.dart';
import '../../routes/route.dart';

class topUp extends StatefulWidget {
  const topUp({Key? key}) : super(key: key);

  @override
  State<topUp> createState() => _topUPState();
}

class _topUPState extends State<topUp> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: NoGlow(),
        child: Scaffold(
          appBar: AppBar(
              leading:GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.all(9),
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
              title: Text(
                "Top Up",
                style: TextStyle(color: Colors.white),
              )),
          body: ListView(
            children: [
              topUpButton(100000, "Rp 100.000,00", context),
              topUpButton(50000, "Rp 50.000,00", context),
              topUpButton(20000, "Rp 20.000,00", context),
              topUpButton(10000, "Rp 10.000,00", context),
            ],
          ),
        ));
  }

  Container topUpButton(int addition, String number, BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.05,
            30, MediaQuery.of(context).size.height * 0.05, 0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              context.read<UserProvider>().topup(
                  userId: context.read<UserProvider>().getUser.id,
                  bmoney:
                      addition + context.read<UserProvider>().getUser.bmoney);
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.main, (route) => false);
            },
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )));
  }
}
