import 'package:flutter/material.dart';

class ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;

    var path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, height);
    path.lineTo(size.width, 0);

    var cp2 = const Offset(0, 0);
    var point2 = Offset(width * .2, height * .3);
    path.quadraticBezierTo(cp2.dx, cp2.dy, point2.dx, point2.dy);

    var cp5 = Offset(width * .3, height * .5);
    var point5 = Offset(width * .23, height * .6);
    path.quadraticBezierTo(cp5.dx, cp5.dy, point5.dx, point5.dy);

    var cp3 = Offset(0, height);
    var point3 = Offset(width, height);
    path.quadraticBezierTo(cp3.dx, cp3.dy, point3.dx, point3.dy);

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
