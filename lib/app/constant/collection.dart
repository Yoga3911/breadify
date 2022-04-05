import 'package:cloud_firestore/cloud_firestore.dart';

class MyCollection {
  MyCollection._();

  static final CollectionReference user = FirebaseFirestore.instance.collection("user");
  static final CollectionReference product = FirebaseFirestore.instance.collection("product");
  static final CollectionReference category = FirebaseFirestore.instance.collection("category");
  static final CollectionReference store = FirebaseFirestore.instance.collection("store");
  static final CollectionReference cart = FirebaseFirestore.instance.collection("cart");
}
