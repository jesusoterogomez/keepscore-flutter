import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_model.dart';
import 'package:keepscore/components/user_tile.dart';

class MatchInProgressPageArguments {
  final List<User> players;

  MatchInProgressPageArguments(this.players);
}

class MatchInProgressPage extends StatelessWidget {
  static const routeName = '/match/start';

  @override
  Widget build(BuildContext context) {
    final MatchInProgressPageArguments args = ModalRoute.of(context)!
        .settings
        .arguments as MatchInProgressPageArguments;

    var teamA = args.players.sublist(0, 2);
    var teamB = args.players.sublist(2, 4);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 80, 20, 40),
        child: Column(
          children: [
            Row(
              children: teamA.map((user) => UserTile(user)).toList(),
            ),
            Row(
              children: teamB.map((user) => UserTile(user)).toList(),
            )
          ],
        ),
        // child: Text(args.players.toString()),
      ),
    );
  }
}
