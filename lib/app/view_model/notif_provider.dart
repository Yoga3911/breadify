import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/models/notif_models.dart';

class NotifProvider with ChangeNotifier {
  List<NotifModel> _notifData = [];

  //fungsi get
  Future<void> getAllNotif(String statusId, String userId) async {
    final data = await MyCollection.notif
        .where("user_id", isEqualTo: userId)
        .where("status", isEqualTo: statusId)
        .get();

    setNotif = <NotifModel>[
      for (DocumentSnapshot<Object?> item in data.docs)
        NotifModel.fromJson((item.data() as Map<String, dynamic>))
    ];
  }

  //fungsi set
  set setNotif(List<NotifModel> value) {
    _notifData = value;
    _notifData.sort((a, b) => b.date.compareTo(a.date));
  }

  List<NotifModel> get getNotif => _notifData;

  Future<void> sendNotif({
    required String message,
    required String note,
    required int price,
    required String productName,
    required String userId,
  }) async {
    final notifId = MyCollection.notif.doc().id;
    MyCollection.notif.doc(notifId).set(
          NotifModel(
            id: notifId,
            message: message,
            note: note,
            price: price,
            product: productName,
            date: DateTime.now(),
            status: "3",
            userId: userId
          ).toJson(),
        );
  }
}
