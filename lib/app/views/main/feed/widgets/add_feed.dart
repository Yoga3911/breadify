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
                //a) tampilan awal textfield
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.amber, width: 2),
                ),
                //b) tampilan ketika textfield ditekan
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
            const SizedBox(height: 50), //jarak
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //a) button "import from galery"
                Container(
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Import from\nGalery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        onTap: () {},
                      )),
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Text(
                  "OR",
                  style: TextStyle(
                      color: Color(0xFF585858),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                //b) button "open camera"
                Container(
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Open\nCamera",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        onTap: () {},
                      )),
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),

            //3) blank image
            const SizedBox(height: 20), //jarak
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                height: MediaQuery.of(context).size.height * 0.45,
                color: Colors.amber,
              ),
            ),

            //4) button "add feed"
            const SizedBox(height: 20),
            Center(
              child: Container(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Import from\nGalery",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      onTap: () {},
                    )),
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
