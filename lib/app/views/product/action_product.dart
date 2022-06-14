import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project/app/constant/color.dart';
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
  late TextEditingController _productName;
  late TextEditingController _productPrice;
  late TextEditingController _productQuantity;

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

  late TextEditingController dateCtrl;
  DateTime dateTime = DateTime.now().add(const Duration(days: 3));
  Future<void> selectDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 3)),
      firstDate: DateTime.now().add(const Duration(days: 3)),
      lastDate: DateTime(2090),
    );

    if (date != null && date != dateTime) {
      dateTime = date;
      dateCtrl.text =
          DateFormat('EEEE, dd/MMMM/yyyy', "in_ID").format(dateTime);
      setState(() {});
    }
  }

  @override
  void initState() {
    _productName = TextEditingController();
    _productQuantity = TextEditingController();
    _productPrice = TextEditingController();
    dateCtrl = TextEditingController();
    dateCtrl.text = DateFormat('EEEE, dd/MMMM/yyyy', "in_ID").format(dateTime);
    super.initState();
  }

  @override
  void dispose() {
    dateCtrl.dispose();
    _productName.dispose();
    _productPrice.dispose();
    _productQuantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
            floatingActionButton: (args["action"] == "update")
                ? FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Alert"),
                          content: const Text(
                              "Apakah anda yakin ingin menghapus produk ini?"),
                          actions: [
                            ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Batal")),
                            ElevatedButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (_) => const CustomLoading(),
                                );
                                product.setDataProduct = [];
                                await product
                                    .deleteById(args["product_id"])
                                    .then(
                                  (_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text(
                                          "Produk berhasil dihapus",
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 74, 80),
                                      ),
                                    );
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      Routes.main,
                                      (route) => false,
                                    );
                                  },
                                );
                              },
                              child: const Text("Ya"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    ),
                    backgroundColor: MyColor.red2,
                  )
                : null,
            appBar: AppBar(
              title: (args["action"] == "add")
                  ? const Text(
                      "Add Item",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    )
                  : const Text(
                      "Updte Item",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
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
                    name: args["name"] ?? "",
                  ),
                  MyTxtField(
                    icon: "assets/icons/price.png",
                    controller: _productPrice,
                    hint: "Price",
                    isNum: true,
                    price: args["price"] ?? 0,
                  ),
                  MyTxtField(
                    icon: "assets/icons/quantity.png",
                    controller: _productQuantity,
                    hint: "Quantity",
                    isNum: true,
                    price: args["quantity"] ?? 0,
                  ),
                  TextField(
                    controller: dateCtrl,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          selectDate();
                        },
                        color: Colors.black,
                        icon: const Icon(Icons.calendar_month),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: MyColor.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: MyColor.yellow, width: 2),
                      ),
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  MyDropDown(
                    category: args["category"] ?? "",
                  ),
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
                  (args["action"] == "add")
                      ? (_img == null)
                          ? Container(
                              height: _size.height * 0.3,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/blank.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: _size.height * 0.1,
                                  child:
                                      Image.asset("assets/images/camera.png"),
                                ),
                              ),
                            )
                          : Container(
                              height: _size.height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: FileImage(_img!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                      : (_img == null)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                height: _size.height * 0.3,
                                child: CachedNetworkImage(
                                  imageUrl: args["image"],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : Container(
                              height: _size.height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: FileImage(_img!),
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
                              : (_img == null && args["image"] == null)
                                  ? null
                                  : () async {
                                      if (_productQuantity.text.isEmpty ||
                                          _productPrice.text.isEmpty ||
                                          _productName.text.isEmpty ||
                                          product.category == "Category" ||
                                          (_img == null &&
                                              args["image"] == null)) {
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
                                      (_img != null)
                                          ? await uploadImg(
                                              imgFile: _img,
                                              imgName:
                                                  "$_imgName${_date.millisecond}")
                                          : null;
                                      (_img != null)
                                          ? await getImgUrl(
                                              imgName:
                                                  "$_imgName${_date.millisecond}")
                                          : null;
                                      (args["action"] == "add")
                                          ? product
                                              .insertData(
                                                  productName:
                                                      _productName.text,
                                                  quantity: int.parse(
                                                      _productQuantity.text),
                                                  price: int.parse(
                                                      _productPrice.text),
                                                  categoryId: categoryId(
                                                      product.category),
                                                  userId: user.getUser.id,
                                                  imgUrl: _imgUrl,
                                                  date: _date,
                                                  storeId: args["store_id"])
                                              .then(
                                              (_) {
                                                product.category = "Category";
                                                product.icon =
                                                    "assets/icons/category.png";
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration:
                                                        Duration(seconds: 3),
                                                    content: Text(
                                                      "Produk berhasil ditambahkan",
                                                    ),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 91, 195, 46),
                                                  ),
                                                );
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                            )
                                          : product
                                              .updateData(
                                                  productId: args["product_id"],
                                                  productName:
                                                      _productName.text,
                                                  quantity: int.parse(
                                                      _productQuantity.text),
                                                  price: int.parse(
                                                      _productPrice.text),
                                                  categoryId: categoryId(
                                                      product.category),
                                                  userId: user.getUser.id,
                                                  imgUrl:
                                                      _imgUrl ?? args["image"],
                                                  date: _date,
                                                  storeId: args["store_id"])
                                              .then(
                                              (_) {
                                                product.category = "Category";
                                                product.icon =
                                                    "assets/icons/category.png";
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration:
                                                        Duration(seconds: 3),
                                                    content: Text(
                                                      "Produk berhasil diubah",
                                                    ),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 59, 147, 255),
                                                  ),
                                                );
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                            );
                                    },
                      child: (args["action"] == "add")
                          ? const Text(
                              "Add Item",
                              textAlign: TextAlign.center,
                            )
                          : const Text(
                              "Update Item",
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
