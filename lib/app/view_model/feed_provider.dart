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

  List<FeedModel> _myFeedData = [];

  Future<void> getAllById({
    required String userId,
  }) async {
    final data =
        await MyCollection.feed.where("user_id", isEqualTo: userId).get();
    setMyData = <FeedModel>[
      for (DocumentSnapshot<Object?> item in data.docs)
        FeedModel.fromJson((item.data() as Map<String, dynamic>))
    ];
  }

  set setMyData(List<FeedModel> value) => _myFeedData = value;
  List<FeedModel> get getMyData => _myFeedData;

  Future<void> addData({
    required String caption,
    required String userId,
    required String image,
  }) async {
    final date = DateTime.now();
    final idFeed = MyCollection.feed.doc();
    await idFeed.set(
      FeedModel(
        idFeed: idFeed.id,
        caption: caption,
        date: date,
        userId: userId,
        image: image,
      ).toJson(),
    );
    notifyListeners();
  }

  Future<void> editData({
    required String caption,
    required String userId,
    required String image,
    required String feedId,
  }) async {
    final date = DateTime.now();
    await MyCollection.feed.doc(feedId).update(
          FeedModel(
            idFeed: feedId,
            caption: caption,
            date: date,
            userId: userId,
            image: image,
          ).toJson(),
        );
    notifyListeners();
  }

  Future<void> deleteData({
    required String feedId,
  }) async {
    await MyCollection.feed.doc(feedId).delete();
    notifyListeners();
  }
}