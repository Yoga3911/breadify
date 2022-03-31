import 'package:flutter/cupertino.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/models/store_model.dart';

class StoreProvider with ChangeNotifier {
  Future<StoreModel> getStoreById(String storeId) async {
    final data = await MyCollection.store.doc(storeId).get();
    return StoreModel.fromJson(data.data() as Map<String, dynamic>);
  }
}
