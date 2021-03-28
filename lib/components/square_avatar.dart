import 'package:flutter/material.dart';
import '../defaults.dart';

class SquaredAvatar extends StatelessWidget {
  final String photoURL;
  final double size;

  SquaredAvatar(
    this.photoURL,
    this.size,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BORDER_RADIUS,
      child: Container(
        height: size,
        width: size,
        // color: Color(0xffFF0E58),
        child: Image.network(photoURL),
      ),
    );
  }
}
