import 'package:flutter/material.dart';
import '../defaults.dart';

class SquaredAvatar extends StatelessWidget {
  final String photoURL;
  final double size;

  const SquaredAvatar(this.photoURL, this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BORDER_RADIUS,
      child: SizedBox(
        height: size,
        width: size,
        // color: Color(0xffFF0E58),
        child: Image.network(photoURL),
      ),
    );
  }
}
