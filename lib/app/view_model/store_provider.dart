import 'package:flutter/material.dart';

import '../constant/collection.dart';
import '../models/store_model.dart';

class StoreProvider with ChangeNotifier {
  StoreModel? _storeModel;

  Future<void> getById(String storeId) async {
    final data = await MyCollection.store.doc(storeId).get();
    setStore = StoreModel.fromJson(data.data() as Map<String, dynamic>);
  }

  set setStore(StoreModel val) => _storeModel = val;

  StoreModel get getStore => _storeModel!;
}
