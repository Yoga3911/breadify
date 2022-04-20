import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
    OrderModel({
        required this.id,
        required this.address,
        required this.message,
        required this.orderDate,
        required this.status,
    });

    final String id;
    final String address;
    final String message;
    final DateTime orderDate;
    final String status;

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        address: json["address"],
        message: json["message"],
        orderDate: (json["order_date"] as Timestamp).toDate(),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "message": message,
        "order_date": orderDate,
        "status": status,
    };
}
