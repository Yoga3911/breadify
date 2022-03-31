import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constant/color.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _spinkit = SpinKitCircle(
      itemBuilder: (BuildContext context, int index) => DecoratedBox(
        decoration:
            BoxDecoration(color: index.isEven ? MyColor.yellow : Colors.black),
      ),
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: _size.height * 0.2,
          height: _size.height * 0.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _spinkit,
              const Text(
                "Loading ...",
                style: TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        )
      ],
    );
  }
}
