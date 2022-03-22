import 'package:cloud_firestore/cloud_firestore.dart';

class Collection {
  Collection._();

  static final CollectionReference products = FirebaseFirestore.instance.collection("product");
  static final CollectionReference category = FirebaseFirestore.instance.collection("category");
}
