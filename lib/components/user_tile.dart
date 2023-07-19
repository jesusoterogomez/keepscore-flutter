import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepscore/bloc/auth/auth_model.dart';
import 'package:keepscore/components/square_avatar.dart';
import 'package:keepscore/defaults.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    // Reorder matches so that winners are on top
    return Container(
      padding: const EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          // color: GRAY_DEFAULT,
          borderRadius: BORDER_RADIUS,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SquaredAvatar(
                user.photoURL,
                52,
              ),
              const SizedBox(height: 10), // give it width
              Text(
                user.firstName,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
