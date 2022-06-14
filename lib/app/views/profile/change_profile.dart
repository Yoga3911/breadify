import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/constant/glow.dart';
import 'package:provider/provider.dart';

import '../../routes/route.dart';
import '../../view_model/user_prodvider.dart';
import '../../widgets/custom_loading.dart';

class changeProfile extends StatefulWidget {
  const changeProfile({Key? key, required this.name, required this.id})
      : super(key: key);
  final String name;
  final String id;
  @override
  State<changeProfile> createState() => _changeProfileState();
}

class _changeProfileState extends State<changeProfile> {
  late TextEditingController _nama;
  @override
  void initState() {
    _nama = TextEditingController();
    _nama.text = widget.name;
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return ScrollConfiguration(
        behavior: NoGlow(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (_) => const CustomLoading(),
              );
              (_img != null)
                  ? await uploadImg(
                      imgFile: _img, imgName: "$_imgName${_date.millisecond}")
                  : null;
              (_img != null)
                  ? await getImgUrl(imgName: "$_imgName${_date.millisecond}")
                  : null;
              MyCollection.user
                  .doc(widget.id)
                  .update({'name': _nama.text, 'image_url': _imgUrl});
              await user.getByDocId();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pushNamed(context, Routes.profile),
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.white,
            ),
            title: const Text("Profile", style: TextStyle(color: Colors.white)),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: (_img == null)
                    ? CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: user.getUser.imageUrl,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 40,
                        backgroundImage: FileImage(_img!),
                      ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        fromGallery();
                      },
                      child: const Text('Import From Galery')),
                  ElevatedButton(
                      onPressed: () {
                        fromCamera();
                      },
                      child: const Text('Take From Camera')),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.06,
                  0,
                  MediaQuery.of(context).size.height * 0.05,
                  0),
                child: Text(
                  "Nama",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.05,
                  10,
                  MediaQuery.of(context).size.height * 0.05,
                  0),
                child: TextField(
                  controller: _nama,
                  decoration: const InputDecoration(
                    hintText: "Nama",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
