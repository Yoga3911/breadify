import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant/collection.dart';
import '../models/product_model.dart';

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

  Future<List<ProductModel>> getByCategory(String category) async {
    switch (category) {
      case "Popular":
        final data = await MyCollection.product.get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      case "Bread":
        final data = await MyCollection.product
            .where("category_id", isEqualTo: "1")
            .get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      case "Cookies":
        final data = await MyCollection.product
            .where("category_id", isEqualTo: "2")
            .get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      case "Cakes":
        final data = await MyCollection.product
            .where("category_id", isEqualTo: "3")
            .get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      case "Pastry":
        final data = await MyCollection.product
            .where("category_id", isEqualTo: "4")
            .get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      case "Brownies":
        final data = await MyCollection.product
            .where("category_id", isEqualTo: "5")
            .get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      default:
        return <ProductModel>[];
    }
  }

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
  }
}
