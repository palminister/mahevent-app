import 'package:flutter/material.dart';
import 'package:mahevent/model/event.dart';
import 'package:provider/provider.dart';

class EventDetailsBackground extends StatelessWidget {
  const EventDetailsBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final event = Provider.of<Event>(context);
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        clipper: ImageClipper(),
        child: Image(
          image: NetworkImage(event.imagePath),
          fit: BoxFit.cover,
          width: screenWidth,
          height: screenHeight * 0.5,
          color: Colors.pink,
          colorBlendMode: BlendMode.darken,
        ),
      ),
    );
  }
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset startPoint = Offset(0, size.height * 0.85);
    Offset endPoint = Offset(size.width, size.height * 0.85);
    path.lineTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(
        size.width / 2, size.height, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}
