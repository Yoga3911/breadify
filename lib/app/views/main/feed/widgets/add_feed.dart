import 'package:flutter/material.dart';

//memanggil kerangka feed
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/view_model/feed_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

import '../../../../constant/collection.dart';

//memanggil kerangka feed

class AddFeedPage extends StatefulWidget {
  const AddFeedPage({Key? key}) : super(key: key);

  @override
  State<AddFeedPage> createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  File? _img;

  String? _imgUrl;

  String? _imgName;

  final DateTime _date = DateTime.now();

  Future<void> fromGallery() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      _img = File(result.path);
      _imgName = result.name;
    }
    setState(() {});
  }

  Future<void> fromCamera() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.camera);

    if (result != null) {
      _img = File(result.path);
      _imgName = result.name;
    }
    setState(() {});
  }

  Future<void> getImgUrl({String? imgName}) async {
    _imgUrl =
        await MyCollection.storage.ref("products/$imgName").getDownloadURL();
  }

  Future<void> uploadImg({String? imgName, File? imgFile}) async {
    try {
      await MyCollection.storage.ref("products/$imgName").putFile(imgFile!);
      log("Image uploaded");
    } on FirebaseException catch (e) {
      log(e.message!);
    }
  }

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feed = Provider.of<FeedProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: MyColor.yellow,
        title: const Text(
          "Add Feed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          //1) Description
          TextField(
            controller: _controller,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              color: Color(0xFF282828),
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: MyColor.yellow, width: 2),
              ),
              //a) tampilan awal textfield
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: MyColor.yellow, width: 2),
              ),
              //b) tampilan ketika textfield ditekan
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: MyColor.yellow, width: 2),
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
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Center(
                            child: Text(
                              "Import from\nGalery",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        fromGallery();
                      },
                    )),
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                  color: MyColor.yellow,
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
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Center(
                            child: Text(
                              "Open\nCamera",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        fromCamera();
                      },
                    )),
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                  color: MyColor.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),

          //3) blank image
          const SizedBox(height: 20), //jarak
          (_img != null)
              ? Center(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 50, right: 50),
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: FileImage(_img!), fit: BoxFit.cover),
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/blank.png"))),
                    margin: const EdgeInsets.only(left: 50, right: 50),
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                ),

          //4) button "add feed"
          const SizedBox(height: 30), //jarak
          Center(
            child: Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (_) => const CustomLoading(),
                    );
                    (_img != null)
                        ? await uploadImg(
                            imgFile: _img,
                            imgName: "$_imgName${_date.millisecond}")
                        : null;
                    (_img != null)
                        ? await getImgUrl(
                            imgName: "$_imgName${_date.millisecond}")
                        : null;
                    feed
                        .addData(
                      caption: _controller.text,
                      userId: user.getUser.id,
                      image: _imgUrl!,
                    )
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text(
                            "Feed berhasil ditambakan",
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Add Feed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                color: MyColor.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}