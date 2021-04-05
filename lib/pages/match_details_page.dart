import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';
import 'package:keepscore/bloc/new_match/new_match_bloc.dart';
import 'package:keepscore/components/formatted_timer.dart';
import 'package:keepscore/components/match_tile.dart';
import 'package:keepscore/components/square_avatar.dart';
import 'package:keepscore/defaults.dart';

class MatchDetailsPageArguments {
  final Match match;
  MatchDetailsPageArguments(this.match);
}

class MatchDetailsPage extends StatelessWidget {
  static const routeName = '/match/details';

  Widget build(BuildContext context) {
    final MatchDetailsPageArguments args =
        ModalRoute.of(context)!.settings.arguments as MatchDetailsPageArguments;

    final match = args.match;

    // Reorder timeline entries from latest to earliest
    match.timeline.sort((a, b) => b.seconds - a.seconds);

    var startedAt = Jiffy(match.startedAt.toDate());
    // var createdAt = Jiffy(match.createdAt.toDate());
    var lastTimestamp = match.timeline.first.seconds;
    // Duration(seconds: lastTimestamp)
    var createdAt = Jiffy(startedAt).add(seconds: lastTimestamp);

    var matchSeconds = createdAt.diff(startedAt, Units.SECOND);

    log(match.timeline[0].uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('Match Details'),
      ),
      body: Column(
        children: [
          Container(
            child: MatchTile(args.match),
          ),
          // FormattedTimer(matchSeconds.toInt()),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BORDER_RADIUS,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.alarm,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Timeline',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: 1.5,
                      color: Colors.black,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: match.timeline.map((entry) {
                      var player = match.getPlayer(entry.uid);
                      return Column(
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              // For some reason, using Colors.white10 or
                              // referring to the theme color doesn't work.
                              // This color mirrors the background color in BASE_THEME
                              color: Color(0xffFAFAFA),
                              child: Text(
                                entry.score[0].toString() +
                                    ':' +
                                    entry.score[1].toString(),
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              TimelinePlayerEntry(entry, player),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BORDER_RADIUS,
                                  ),
                                  child: FormattedTimer(
                                    entry.seconds.toInt(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimelinePlayerEntry extends StatelessWidget {
  final TimelineEntry entry;
  final Player player;

  TimelinePlayerEntry(this.entry, this.player);

  @override
  Widget build(BuildContext context) {
    if (player.team == PlayerTeam.A) {
      return Row(
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Row(
                  children: [
                    SquaredAvatar(player.user.photoURL, 36),
                    SizedBox(
                      width: 4,
                    ),
                    Text(player.user.firstName),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(),
          )
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SquaredAvatar(player.user.photoURL, 36),
                  SizedBox(
                    width: 4,
                  ),
                  Text(player.user.firstName),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  )
                ].reversed.toList(),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(),
        )
      ].reversed.toList(),
    );
  }
}
