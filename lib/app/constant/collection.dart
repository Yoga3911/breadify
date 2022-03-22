import 'package:cloud_firestore/cloud_firestore.dart';

class MyCollection {
  MyCollection._();

  static final CollectionReference products = FirebaseFirestore.instance.collection("product");
  static final CollectionReference category = FirebaseFirestore.instance.collection("category");
}
