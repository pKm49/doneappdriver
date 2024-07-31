import 'package:flutter/material.dart';

class CurvedClipPath extends StatelessWidget {
  const CurvedClipPath({super.key, required this.size, required this.color});

  final Size size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
        height: 90,
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1542167, size.height * -0.0092000);
    path_0.lineTo(size.width * 0.1414667, size.height * -0.0158667);
    path_0.quadraticBezierTo(size.width * 0.1859833, size.height * 0.9448667,
        size.width * 0.3134667, size.height * 0.9967333);
    path_0.cubicTo(
        size.width * 0.4558583,
        size.height * 1.0059333,
        size.width * 0.4491083,
        size.height * 0.3961333,
        size.width * 0.5140000,
        size.height * 0.4067333);
    path_0.cubicTo(
        size.width * 0.5679833,
        size.height * 0.3968667,
        size.width * 0.6667250,
        size.height * 0.8359333,
        size.width * 0.7223417,
        size.height * 0.6956000);
    path_0.quadraticBezierTo(size.width * 0.7841417, size.height * 0.6442667,
        size.width * 0.8412667, size.height * -0.0191567);
    path_0.lineTo(size.width * 0.8400583, size.height * -0.0200967);
    path_0.lineTo(size.width * 0.1542167, size.height * -0.0092000);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CurvedClipPath2 extends StatelessWidget {
  const CurvedClipPath2({super.key, required this.size, required this.color});

  final Size size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath2(),
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
        height: size.height * 0.10,
      ),
    );
  }
}

class CustomClipPath2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.1790167, size.height * 1.0033559);
    path_0.lineTo(size.width * 1.1783667, size.height * 1.0033727);
    path_0.quadraticBezierTo(size.width * 1.1182750, size.height * 0.0291627,
        size.width * 0.9765750, size.height * -0.0073336);
    path_0.cubicTo(
        size.width * 0.8182917,
        size.height * -0.0141295,
        size.width * 0.8070167,
        size.height * 0.4621356,
        size.width * 0.7348750,
        size.height * 0.4546014);
    path_0.cubicTo(
        size.width * 0.6748667,
        size.height * 0.4613469,
        size.width * 0.5818500,
        size.height * 0.3105792,
        size.width * 0.5199750,
        size.height * 0.4084901);
    path_0.quadraticBezierTo(size.width * 0.4512583, size.height * 0.4441811,
        size.width * 0.3902417, size.height * 1.0040103);
    path_0.lineTo(size.width * 0.3906583, size.height * 1.0046647);
    path_0.lineTo(size.width * 1.1790167, size.height * 1.0033559);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
