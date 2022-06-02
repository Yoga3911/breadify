import 'package:cloud_firestore/cloud_firestore.dart';

class NotifModel {
    NotifModel({
        required this.id,
        required this.message,
        required this.note,
        required this.price,
        required this.product,
        required this.date,
        required this.status,
    });

    final String id;
    final String message;
    final String note;
    final int price;
    final String product;
    final DateTime date;
    final String status;

    factory NotifModel.fromJson(Map<String, dynamic> json) => NotifModel(
        id: json["id"],
        message: json["message"],
        note: json["note"],
        price: json["price"],
        product: json["product"],
        date: (json["date"] as Timestamp).toDate(),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "note": note,
        "price": price,
        "product": product,
        "date": date,
        "status": status,
    };
}