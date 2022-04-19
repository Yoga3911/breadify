import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/models/feeds_models.dart';

class FeedProvider with ChangeNotifier {
  List<FeedModel> _feedData = [];

  Future<void> getAll() async {
    final data = await MyCollection.feed.get();
    setData = <FeedModel>[
      for (DocumentSnapshot<Object?> item in data.docs)
        FeedModel.fromJson((item.data() as Map<String, dynamic>))
    ];
  }

  set setData(List<FeedModel> value) => _feedData = value;
  List<FeedModel> get getData => _feedData;
}
