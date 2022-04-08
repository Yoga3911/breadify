import 'dart:html';

import 'package:flutter/material.dart';

//memanggil kerangka feed
import '../feed.dart';

class AddFeedPage extends StatelessWidget {
  const AddFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.amber,
          title: const Text("Add Feed"),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(children: [
            //1) Description
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                color: Color(0xFF282828),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.amber, width: 2),
                ),
                //1) tampilan awal textfield
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.amber, width: 2),
                ),
                //2) tampilan ketika textfield ditekan
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.amber, width: 2),
                ),
                // labelText: "Description",
                // labelStyle: const TextStyle(color: Colors.orange),
                hintText: "Write something here ...",
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            //2) ROW : button "import from galery" & button "opencam"
            Row(
              children: <Widget>[
                //a) button "import from galery"
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.amber,
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
