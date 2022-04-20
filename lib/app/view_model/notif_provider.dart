import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/models/notif_models.dart';

class NotifProvider with ChangeNotifier {
  List<NotifModel> _notifData = [];

  //fungsi get
  Future<void> getAllNotif(String statusId) async {
    final data = await MyCollection.notif.where("status", isEqualTo: statusId).get();
    
    _notifData = <NotifModel>[
      for (DocumentSnapshot<Object?> item in data.docs)
        NotifModel.fromJson((item.data() as Map<String, dynamic>))
    ];
  }

  //fungsi set
  set setNotif(List<NotifModel> value) => _notifData = value;
  
  List<NotifModel> get getNotif => _notifData;
}
