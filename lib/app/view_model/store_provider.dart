import 'package:flutter/material.dart';

import '../constant/collection.dart';
import '../models/store_model.dart';

class StoreProvider with ChangeNotifier {
  Future<StoreModel> getById(String storeId) async {
    final data = await MyCollection.store.doc(storeId).get();
    return StoreModel.fromJson(data.data() as Map<String, dynamic>);
  }
}
