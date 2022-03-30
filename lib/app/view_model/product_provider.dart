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
}
