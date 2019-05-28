import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class PagerBackground extends StatelessWidget {
  final Widget child;
  PagerBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    return new ClipPath(
      clipper: new WaveShapeClipper(),
      child: new DecoratedBox(
        decoration: BoxDecoration(
      ),
        child: child,
      ),
    );
  }
}

class WaveShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.8);

    path.quadraticBezierTo(size.width * 0.0, size.height, size.width * 0.2, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.2);
    path.quadraticBezierTo(size.width, size.height * 0.0, size.width  * 0.8, size.height  * 0.0);
    path.lineTo(size.width * 0.8, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}