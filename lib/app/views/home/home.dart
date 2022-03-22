import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project/app/constant/style.dart';

import '../../constant/firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: Collection.products.orderBy("create_at").get(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return MasonryGridView.count(
            itemCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: 2, itemBuilder: (_, index) {
            return Container(
              color: MyColor.hitam,
              height: index.isOdd? 200 : 300,
              width: 100,
            );
          });
        },
      ),
    );
  }
}
