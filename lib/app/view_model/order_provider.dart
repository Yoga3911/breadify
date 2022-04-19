import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/models/orders_models.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _historyData = [];

  //fungsi get
  Future<void> getAllHistory(String statusId) async {
    final data = await MyCollection.order.where("status", isEqualTo: statusId).get(); //dr provider "MyCollection"

    _historyData = <OrderModel>[
      for (DocumentSnapshot<Object?> item in data.docs)
        OrderModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }

  //fungsi set
  set setHistory(List<OrderModel> val) => _historyData = val;

  List<OrderModel> get getHistory => _historyData;

///////////////////////////// ON GOING ////////////////////////////////
  
  List<OrderModel> _ongoingData = [];

  //fungsi get
  Future<void> getAllOngoing(String statusId) async {
    final data = await MyCollection.order.where("status", isEqualTo: statusId).get(); //dr provider "MyCollection"

    _ongoingData = <OrderModel>[
      for (DocumentSnapshot<Object?> item in data.docs)
        OrderModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }

  //fungsi set
  set setOngoing(List<OrderModel> val) => _ongoingData = val;

  List<OrderModel> get getOngoing => _ongoingData;
}
