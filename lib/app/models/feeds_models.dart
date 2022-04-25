//dari quicktype
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedModel {
  FeedModel({
    required this.idFeed,
    required this.caption,
    required this.date,
    required this.userId,
    required this.image,
  });

  final String idFeed;
  final String caption;
  final DateTime date;
  final String userId;
  final String image;

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        idFeed: json["id_feed"],
        caption: json["caption"],
        date: (json["date"] as Timestamp).toDate(),
        userId: json["user_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id_feed": idFeed,
        "caption": caption,
        "date": date,
        "user_id": userId,
        "image": image,
      };
}
