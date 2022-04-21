import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/routes/route.dart';
import 'package:project/app/view_model/product_provider.dart';
import 'package:project/app/widgets/custom_loading.dart';
import 'package:provider/provider.dart';

import '../../constant/collection.dart';
import '../../constant/glow.dart';
import '../../view_model/user_prodvider.dart';
import '../../views/product/widgets/dropdown.dart';
import '../../views/product/widgets/txt_field.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productQuantity = TextEditingController();

  File? img;
  String? imgUrl;
  String? imgName;
  bool isError = true;
  final DateTime date = DateTime.now();

  Future<void> fromGallery() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      img = File(result.path);
      imgName = result.name;
    }
    setState(() {});
  }

  Future<void> fromCamera() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.camera);

    if (result != null) {
      img = File(result.path);
      imgName = result.name;
    }
    setState(() {});
  }

  Future<void> getImgUrl({String? imgName}) async {
    imgUrl = await MyCollection.storage.ref(imgName).getDownloadURL();
  }

  Future<void> uploadImg({String? imgName, File? imgFile}) async {
    try {
      await MyCollection.storage.ref(imgName).putFile(imgFile!);
      log("Image uploaded");
    } on FirebaseException catch (e) {
      log(e.message!);
    }
  }

  String categoryId(String category) {
    switch (category) {
      case "Bread":
        return "1";
      case "Cookies":
        return "2";
      case "Cakes":
        return "3";
      case "Pastry":
        return "4";
      case "Brownies":
        return "5";
      default:
        return "1";
    }
  }

  @override
  void dispose() {
    _productName.dispose();
    _productPrice.dispose();
    _productQuantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);

    final Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        product.category = "Category";
        product.icon = "assets/icons/category.png";
        return true;
      },
      child: GestureDetector(
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
                    onTap: () {
                      product.category = "Category";
                      product.icon = "assets/icons/category.png";
                      Navigator.pop(context);
                    },
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
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  MyTxtField(
                    icon: "assets/icons/product.png",
                    controller: _productName,
                    hint: "Product name",
                    isNum: false,
                  ),
                  MyTxtField(
                    icon: "assets/icons/price.png",
                    controller: _productPrice,
                    hint: "Price",
                    isNum: true,
                  ),
                  MyTxtField(
                    icon: "assets/icons/quantity.png",
                    controller: _productQuantity,
                    hint: "Quantity",
                    isNum: true,
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
                  (img == null)
                      ? Container(
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
                        )
                      : Container(
                          height: _size.height * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: FileImage(img!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  Consumer<ProductProvider>(
                    builder: (_, val, __) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: product.isError
                          ? null
                          : (val.category == "Category")
                              ? null
                              : (img == null)
                                  ? null
                                  : () async {
                                      if (_productQuantity.text.isEmpty ||
                                          _productPrice.text.isEmpty ||
                                          _productName.text.isEmpty ||
                                          product.category == "Category" ||
                                          img == null) {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (_) => AlertDialog(
                                            title: const Text("Alert"),
                                            content: const Text(
                                                "Data tidak valid, silahkan periksa kembali"),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Ok"),
                                              )
                                            ],
                                          ),
                                        );
                                        return;
                                      }
                                      showDialog(
                                        context: context,
                                        builder: (_) => const CustomLoading(),
                                      );
                                      await uploadImg(
                                          imgFile: img,
                                          imgName:
                                              "$imgName${date.millisecond}");
                                      await getImgUrl(
                                          imgName:
                                              "$imgName${date.millisecond}");
                                      product
                                          .insertData(
                                        productName: _productName.text,
                                        quantity:
                                            int.parse(_productQuantity.text),
                                        price: int.parse(_productPrice.text),
                                        categoryId:
                                            categoryId(product.category),
                                        userId: user.getUser.id,
                                        imgUrl: imgUrl,
                                        date: date,
                                      )
                                          .then(
                                        (_) {
                                          product.category = "Category";
                                          product.icon =
                                              "assets/icons/category.png";
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routes.home,
                                            (route) => false,
                                          );
                                        },
                                      );
                                    },
                      child: const Text(
                        "Add Item",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
