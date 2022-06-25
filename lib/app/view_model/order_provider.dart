import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/app/constant/collection.dart';
import 'package:project/app/models/orders_models.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _historyData = [];

  //fungsi get
  Future<void> getAllHistory(String statusId) async {
    final data = await MyCollection.order
        .where("status", isEqualTo: statusId)
        .get(); //dr provider "MyCollection"

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
  Future<List<OrderModel>> getAllOngoing(String statusId, String userId) async {
    final data = await MyCollection.order
        .where("user_id", isEqualTo: userId)
        .where("status", isEqualTo: "1")
        .get(); //dr provider "MyCollection"

    return <OrderModel>[
      for (DocumentSnapshot<Object?> item in data.docs)
        OrderModel.fromJson(item.data() as Map<String, dynamic>)
    ];
  }

  //fungsi set
  set setOngoing(List<OrderModel> val) => _ongoingData = val;

  List<OrderModel> get getOngoing => _ongoingData;

  //insert data
  Future<void> insertData({
    required String userId,
    required String address,
    required List<String> productId,
  }) async {
    final date = DateTime.now();
    final doc = MyCollection.order.doc();
    await doc.set(
      OrderModel(
        id: doc.id,
        userId: userId,
        address: address,
        message: "Order successfuly delivered",
        orderDate: date,
        status: "1",
        data: productId,
      ).toJson(),
    );
  }

  Future<void> deleteOrder({required String orderId}) async {
    await MyCollection.order.doc(orderId).delete();
    notifyListeners();
  }

  Future<void> updateOrder({required orderId}) async {
    await MyCollection.order.doc(orderId).update(
      {
        "status": "2",
      },
    );
    notifyListeners();
  }
}