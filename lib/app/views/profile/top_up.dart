import 'package:flutter/material.dart';

import '../../constant/glow.dart';

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
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              title: Text(
                "Top Up",
                style: TextStyle(color: Colors.white),
              )),
          body: ListView(
            children: [
              topUpButton(100000, "Rp 100.000,00"),
              topUpButton(50000, "Rp 50.000,00"),
              topUpButton(20000, "Rp 20.000,00"),
              topUpButton(10000, "Rp 10.000,00"),
            ],
          ),
        ));
  }

  Container topUpButton(int addition , String number) => Container(
      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.05, 30,
          MediaQuery.of(context).size.height * 0.05, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          onPressed: () {},
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          )));
}
