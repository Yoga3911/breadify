import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/models/favorite_model.dart';

class FavoriteProvider with ChangeNotifier {
  List<String> listLiked = [];
  List<String> listIdLiked = [];
  Future<List<FavoriteModel>> getAllFav({required String userId}) async {
    listLiked = [];
    listIdLiked = [];
    final data =
        await MyCollection.user.doc(userId).collection("favorite").get();
    for (QueryDocumentSnapshot i in data.docs) {
      listLiked.add((i.data() as Map<String, dynamic>)["product_id"]);
      listIdLiked.add(i.id);
    }

    return <FavoriteModel>[
      for (QueryDocumentSnapshot i in data.docs)
        FavoriteModel(
            id: i.id,
            productId: (i.data() as Map<String, dynamic>)["product_id"])
    ];
  }

  Future<void> likeProduct({
    required String productId,
    required String userId,
  }) async {
    final favorite = MyCollection.user.doc(userId).collection("favorite").doc();
    await favorite.set(
      FavoriteModel(
        id: favorite.id,
        productId: productId,
      ).toJson(),
    );
    listLiked.add(productId);
    listIdLiked.add(favorite.id);
    notifyListeners();
  }

  Future<void> dislikeProduct({
    required String favId,
    required String userId,
    required String productId,
  }) async {
    await MyCollection.user
        .doc(userId)
        .collection("favorite")
        .doc(favId)
        .delete();
    listLiked.remove(productId);
    listIdLiked.remove(favId);
    notifyListeners();
  }
}