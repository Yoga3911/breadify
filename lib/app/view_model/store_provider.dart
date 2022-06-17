import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/collection.dart';
import '../models/store_model.dart';

class StoreProvider with ChangeNotifier {
  StoreModel? _storeModel;

  Future<void> getById(String storeId) async {
    final data = await MyCollection.store.doc(storeId).get();
    setStore = StoreModel.fromJson(data.data() as Map<String, dynamic>);
  }

  set setStore(StoreModel val) {
    _storeModel = val;
    notifyListeners();
  }

  Future<StoreModel> getStoreById(String storeId) async {
    final data = await MyCollection.store.doc(storeId).get();
    return StoreModel.fromJson(data.data() as Map<String, dynamic>);
  }

  StoreModel get getStore => _storeModel!;

  Future<void> insertStore({
    required String address,
    required String storeName,
    required String open,
    required String close,
    required String userId,
  }) async {
    final store = MyCollection.store.doc();
    await MyCollection.user.doc(userId).update({
      "store_id": store.id,
    });
    await store.set(
      StoreModel(
        id: store.id,
        address: address,
        open: open,
        close: close,
        storeName: storeName,
        userId: userId,
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
      ).toJson(),
    );
  }
}
