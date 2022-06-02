import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/constant/color.dart';
import 'package:project/app/models/feeds_models.dart';
import 'package:project/app/view_model/feed_provider.dart';
import 'package:project/app/view_model/user_prodvider.dart';
import 'package:project/app/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

import '../../../../constant/collection.dart';

//memanggil kerangka feed

class EditFeedPage extends StatefulWidget {
  const EditFeedPage({Key? key}) : super(key: key);

  @override
  State<EditFeedPage> createState() => _EditFeedPageState();
}

class _EditFeedPageState extends State<EditFeedPage> {
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
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final feedModel = args["feed"] as FeedModel;
    if (_controller.text.isEmpty) {
      _controller.text = feedModel.caption;
      _imgUrl = feedModel.image;
    }
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
          "Edit Feed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                      margin: const EdgeInsets.only(left: 50, right: 50),
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: FileImage(_img!), fit: BoxFit.cover),
                      ),
                    ),
                  )
                : (_imgUrl != null)
                    ? Center(
                        child: Container(
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: _imgUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/blank.png"))),
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
                          .editData(
                        feedId: feedModel.idFeed,
                        caption: _controller.text,
                        userId: user.getUser.id,
                        image: _imgUrl!,
                      )
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 3),
                            content: Text(
                              "Feed berhasil diupdate",
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
                        "Save",
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
          ],
        ),
      ),
    );
  }
}