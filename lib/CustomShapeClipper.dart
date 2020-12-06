import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
     
    final Path path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPaint = Offset(size.width * .45, size.height - 30.0);
    var fisrtControlpoint = Offset(size.width * 0.45, size.height - 90.0);
    path.quadraticBezierTo(fisrtControlpoint.dx, fisrtControlpoint.dy, firstEndPaint.dx, firstEndPaint.dy);

    var secondEndPaint = Offset(size.width, size.height - 90.0);
    var secondControlpoint = Offset(size.width * 85, size.height - 50);
     path.quadraticBezierTo(secondControlpoint.dx, secondControlpoint.dy, secondEndPaint.dx, secondEndPaint.dy);
     
     path.lineTo(size.width, 0.0);
     path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
  

}