import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  OrderModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.message,
    required this.orderDate,
    required this.status,
    required this.data,
  });

  final String id;
  final String userId;
  final String address;
  final String message;
  final DateTime orderDate;
  final String status;
  final List<dynamic> data;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        userId: json["user_id"],
        address: json["address"],
        message: json["message"],
        orderDate: (json["order_date"] as Timestamp).toDate(),
        status: json["status"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "address": address,
        "message": message,
        "order_date": orderDate,
        "status": status,
        "data": data,
      };
}