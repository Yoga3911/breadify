import 'package:flutter/material.dart';

//memanggil kerangka orders :
import '../order.dart';

class OngoingPage extends StatelessWidget {
  const OngoingPage({required this.index, Key? key}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.2,
        color: Colors.purple,
      ),
    );
  }
}
