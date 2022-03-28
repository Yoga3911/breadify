import 'package:flutter/material.dart';
import 'package:project/app/constant/color.dart';

class DropDownShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = MyColor.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0343750, size.height * 0.1262500);
    path0.lineTo(0, size.height * 0.2562500);
    path0.lineTo(size.width * 0.0012500, size.height * 0.8687500);
    path0.lineTo(size.width * 0.0309375, size.height);
    path0.lineTo(size.width * 0.9675000, size.height);
    path0.lineTo(size.width, size.height * 0.8687500);
    path0.lineTo(size.width * 0.9987500, size.height * 0.2462500);
    path0.lineTo(size.width * 0.9643750, size.height * 0.1300000);
    path0.lineTo(size.width * 0.1512500, size.height * 0.1262500);
    path0.lineTo(size.width * 0.1237500, size.height * 0.0150000);
    path0.lineTo(size.width * 0.0953125, size.height * 0.1312500);
    path0.lineTo(size.width * 0.0343750, size.height * 0.1262500);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
