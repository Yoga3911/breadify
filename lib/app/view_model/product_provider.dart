import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant/collection.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  Future<List<ProductModel>> getDataById(String storeId) async {
    final data =
        await MyCollection.product.where("store_id", isEqualTo: storeId).get();

    return <ProductModel>[
      for (QueryDocumentSnapshot<Object?> item in data.docs)
        ProductModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }

  Future<List<ProductModel>> getDataByCategory(String category) async {
    switch (category) {
      case "Popular":
        final data = await MyCollection.product.get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      case "Bread":
        final data = await MyCollection.product.where("category_id", isEqualTo: "1").get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      case "Cookies":
        final data = await MyCollection.product.where("category_id", isEqualTo: "2").get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      case "Cakes":
        final data = await MyCollection.product.where("category_id", isEqualTo: "3").get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      case "Pastry":
        final data = await MyCollection.product.where("category_id", isEqualTo: "4").get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];
      case "Brownies":
        final data = await MyCollection.product.where("category_id", isEqualTo: "5").get();
        return <ProductModel>[
          for (QueryDocumentSnapshot<Object?> item in data.docs)
            ProductModel.fromJson(item.data() as Map<String, dynamic>)
        ];  
      default:
        return <ProductModel>[];
    }
  }
}
