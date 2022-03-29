import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/constant/glow.dart';
import 'package:project/app/views/product/widgets/dropdown.dart';
import 'package:project/app/views/product/widgets/txt_field.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  File? img;

  Future<void> fromGallery() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      img = File(result.path);
    } else {
      log("Canceled");
    }
    setState(() {});
  }

  Future<void> fromCamera() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.camera);

    if (result != null) {
      img = File(result.path);
    } else {
      log("Canceled");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _productName = TextEditingController();
    TextEditingController _productPrice = TextEditingController();
    TextEditingController _productQuantity = TextEditingController();
    final Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScrollConfiguration(
        behavior: NoGlow(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Add Item",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
            ),
            actions: [
              IconButton(
                splashRadius: 25,
                icon: const Icon(
                  Icons.shopping_cart_rounded,
                ),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {},
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListView(
              children: [
                MyTxtField(
                  icon: "assets/icons/product.png",
                  controller: _productName,
                  hint: "Product name",
                ),
                MyTxtField(
                  icon: "assets/icons/price.png",
                  controller: _productPrice,
                  hint: "Price",
                ),
                MyTxtField(
                  icon: "assets/icons/quantity.png",
                  controller: _productQuantity,
                  hint: "Quantity",
                ),
                const MyDropDown(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () => fromGallery(),
                      child: const Text(
                        "Import from Gallery",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () => fromCamera(),
                      child: const Text(
                        "Open Camera",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                (img == null)?
                Container(
                  height: _size.height * 0.25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/blank.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: _size.height * 0.1,
                      child: Image.asset("assets/images/camera.png"),
                    ),
                  ),
                ) : Container(
                  height: _size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: FileImage(img as File),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Add Item",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
