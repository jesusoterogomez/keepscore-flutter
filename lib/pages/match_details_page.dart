import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';
import 'package:keepscore/components/formatted_timer.dart';
import 'package:keepscore/components/match_tile.dart';
import 'package:keepscore/components/square_avatar.dart';

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

    var startedAt = Jiffy(match.startedAt.toDate());
    var createdAt = Jiffy(match.createdAt.toDate());

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
          FormattedTimer(matchSeconds.toInt()),
          Container(
            child: Text('Timeline'),
          ),
          Expanded(
            child: ListView(
              children: match.timeline
                  .map(
                    (entry) => Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        FormattedTimer(
                          matchSeconds.toInt() - entry.seconds.toInt(),
                        ),
                        SquaredAvatar(
                            match.getPlayer(entry.uid).user.photoURL, 32),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
