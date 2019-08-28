import 'package:flutter/material.dart';

class CircularClipper extends CustomClipper<Rect> {
  final Offset center;
  final double fraction;

  CircularClipper(this.fraction, [this.center]);
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromCircle(
        center: center ?? Offset(size.width / 2, size.height / 2),
        radius: size.height * this.fraction);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
