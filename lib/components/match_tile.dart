import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';
import 'package:keepscore/components/square_avatar.dart';
import 'package:keepscore/defaults.dart';

class MatchTile extends StatelessWidget {
  final Match match;
  final VoidCallback? onTap;
  const MatchTile(this.match, [this.onTap]);

  @override
  Widget build(BuildContext context) {
    // Reorder matches so that winners are on top
    match.teams.sort((a, b) => b.win ? 1 : -1);

    return Hero(
      tag: 'hero-match-tile-' + match.id,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              decoration: BoxDecoration(
                color: GRAY_DEFAULT,
                borderRadius: BORDER_RADIUS,
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        Jiffy(match.createdAt.toDate()).fromNow(),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  MatchTileRow(match.teams[0]),
                  MatchTileRow(match.teams[1]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MatchTileRow extends StatelessWidget {
  final Team team;
  const MatchTileRow(
    this.team,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: team.win ? GRAY_DARK : null,
          borderRadius: BORDER_RADIUS,
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 46,
              child: Center(
                child: Text(
                  team.score.toString(),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SquaredAvatar(
                        team.attack.photoURL,
                        32,
                      ),
                      SizedBox(width: 10), // give it width
                      Text(
                        team.attack.firstName,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SquaredAvatar(
                        team.defense.photoURL,
                        32,
                      ),
                      SizedBox(width: 10), // give it width
                      Text(
                        team.defense.firstName,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
