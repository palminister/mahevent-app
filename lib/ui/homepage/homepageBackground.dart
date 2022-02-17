import 'package:flutter/material.dart';

class HomePageBackground extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final screenHeight;
  const HomePageBackground({Key? key, required this.screenHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BackgroundShapeClipper(),
      child: Container(
        height: screenHeight * 0.7,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 232, 6, 104),
              // Color.fromARGB(255, 255, 140, 0),
              Color.fromARGB(255, 252, 143, 27),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset startPoint = Offset(0, size.height * 0.5);
    Offset endPoint = Offset(size.width, size.height);
    path.lineTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(
        size.width / 4, size.height, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        size.width / 2, size.height / 8, endPoint.dx / 200, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}
