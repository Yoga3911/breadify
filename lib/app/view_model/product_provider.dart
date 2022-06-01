import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant/collection.dart';
import '../models/product_model.dart';

enum state { loading, done, empty }

class ProductProvider with ChangeNotifier {
  ProductProvider({
    this.category = "Category",
    this.icon = "assets/icons/category.png",
  });

  Future<List<ProductModel>> getAll() async {
    final data = await MyCollection.product.get();

    return <ProductModel>[
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        ProductModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }

  Future<ProductModel> getById(String id) async {
    final data = await MyCollection.product.doc(id).get();
    return ProductModel.fromJson(data.data() as Map<String, dynamic>);
  }

  Future<List<ProductModel>> getByStoreId(String storeId) async {
    final data =
        await MyCollection.product.where("store_id", isEqualTo: storeId).get();

    return <ProductModel>[
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        ProductModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }

  List<ProductModel> _dataProduct = [];
  List<ProductModel> _dataFilter = [];

  state? _status;

  set setStatus(state val) => _status = val;

  state get getStatus => _status!;

  Future<void> getByCategory(String category) async {
    setStatus = state.loading;
    switch (category) {
      case "Popular":
        final data = await MyCollection.product.get();
        setDataProduct = <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
        break;
      case "Bread":
        final data = await MyCollection.product
            .where("category_id", isEqualTo: "1")
            .get();
        setDataProduct = <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
        break;
      case "Cookies":
        final data = await MyCollection.product
            .where("category_id", isEqualTo: "2")
            .get();
        setDataProduct = <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
        break;
      case "Cakes":
        final data = await MyCollection.product
            .where("category_id", isEqualTo: "3")
            .get();
        setDataProduct = <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
        break;
      case "Pastry":
        final data = await MyCollection.product
            .where("category_id", isEqualTo: "4")
            .get();
        setDataProduct = <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
        break;
      case "Brownies":
        final data = await MyCollection.product
            .where("category_id", isEqualTo: "5")
            .get();
        setDataProduct = <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
        break;
    }
  }

  set setDataProduct(List<ProductModel> val) {
    _dataProduct = val;
    _dataFilter = val;
    notifyListeners();
  }

  getDataProduct(String categoryId) {
    if (categoryId == "Popular") {
      _dataFilter = _dataProduct;
    } else {
      _dataFilter = _dataProduct
          .where((element) => element.categoryId == categoryId)
          .toList();
    }
    notifyListeners();
  }

  List<ProductModel> get getDataFilter => _dataFilter;

  List<ProductModel> get getAllProduct => _dataProduct;

  String category;
  String icon;

  bool isShow = false;
  double rotate = pi * 0;

  void changeCategory(String cat) {
    if (rotate == pi * 0) {
      rotate = pi * 180;
    } else {
      rotate = pi * 0;
    }
    isShow = !isShow;
    if (cat == "Bread") {
      category = "Bread";
      icon = "assets/icons/bread.png";
    } else if (cat == "Cookies") {
      category = "Cookies";
      icon = "assets/icons/cookies.png";
    } else if (cat == "Cakes") {
      category = "Cakes";
      icon = "assets/icons/cakes.png";
    } else if (cat == "Pastry") {
      category = "Pastry";
      icon = "assets/icons/pastry.png";
    } else if (cat == "Brownies") {
      category = "Brownies";
      icon = "assets/icons/brownie.png";
    }
    notifyListeners();
  }

  Future<void> updateQuantity(String productId, int val) async {
    await MyCollection.product.doc(productId).update({"quantity": val});
  }

  Future<void> updateFavorite(String productId, bool val) async {
    await MyCollection.product.doc(productId).update({"is_checked": val});
    notifyListeners();
  }

  // * >>>>>>>>>>> GET PRODUCT QUANTITY <<<<<<<<<<
  Stream<DocumentSnapshot<Object?>>? dataQuantity;
  Stream getQuantity(String productId) async* {
    final data = MyCollection.product.doc(productId).snapshots();
    dataQuantity = data;
  }

  // * >>>>>>>>>>> ADD PRODUCT <<<<<<<<<<<<

  bool isError = true;

  Future<void> insertData({
    String? productName,
    int? price,
    int? quantity,
    String? userId,
    String? categoryId,
    String? imgUrl,
    DateTime? date,
    String? storeId,
  }) async {
    final product = MyCollection.product.doc();
    await product.set(
      ProductModel(
        id: product.id,
        name: productName!,
        price: price!,
        quantity: quantity!,
        image: imgUrl!,
        categoryId: categoryId!,
        storeId: storeId!,
        createAt: date!,
        updateAt: date,
        isChecked: false,
      ).toJson(),
    );
  }

  // * >>>>>>>>>>> UPDATE PRODUCT <<<<<<<<<<<<

  Future<void> updateData({
    String? productId,
    String? productName,
    int? price,
    int? quantity,
    String? userId,
    String? categoryId,
    String? imgUrl,
    DateTime? date,
    String? storeId,
  }) async {
    final product = MyCollection.product.doc(productId);
    await product.set(
      ProductModel(
        id: product.id,
        name: productName!,
        price: price!,
        quantity: quantity!,
        image: imgUrl!,
        categoryId: categoryId!,
        storeId: storeId!,
        createAt: date!,
        updateAt: date,
        isChecked: false,
      ).toJson(),
    );
  }

  // * >>>>>>>> DELETE PRODUCT <<<<<<<<<

  Future<void> deleteById(String productId) async {
    await MyCollection.product.doc(productId).delete();
  }

  int _countItem = 0;

  set setCountItem(int val) {
    _countItem += val;
    notifyListeners();
  }

  int get getCountItem => _countItem;
}
