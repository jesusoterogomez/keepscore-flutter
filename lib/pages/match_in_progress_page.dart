import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_model.dart';
import 'package:keepscore/bloc/new_match/new_match_bloc.dart';
import 'package:keepscore/components/formatted_timer.dart';
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

    // Start Match
    newMatchBloc.dispose();
    newMatchBloc.start(args.players);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          child: NewMatchBlocProvider(
            child: MatchInProgressPageContent(args.players),
          ),
        ),
      ),
    );
  }
}

class MatchInProgressPageContent extends StatefulWidget {
  final List<User> players;
  MatchInProgressPageContent(this.players);

  @override
  _MatchInProgressPageContentState createState() =>
      _MatchInProgressPageContentState();
}

class _MatchInProgressPageContentState
    extends State<MatchInProgressPageContent> {
  @override
  Widget build(BuildContext context) {
    final bloc = NewMatchBlocProvider.of(context);

    var teamA = widget.players.sublist(0, 2);
    var teamB = widget.players.sublist(2, 4);

    // Start Match
    bloc.dispose();
    bloc.start(widget.players);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 80, 20, 40),
          child: StreamBuilder(
            stream: bloc.match,
            builder: (BuildContext context, AsyncSnapshot<NewMatch> snapshot) {
              NewMatch match = snapshot.data!;

              // if (match.status == NewMatchStatus.finished) {
              //   bloc.();
              // }

              return Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: teamA
                          .map((user) => MatchInProgressPlayerTile(user))
                          .toList(),
                    ),
                    Text(match.status.toString()),
                    MatchInProgressScore(match),
                    MatchInProgressTimer(),
                    MatchInProgressControls(match),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: teamB
                          .map((user) => MatchInProgressPlayerTile(user))
                          .toList(),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Back'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    log('Clear timer from new match bloc');
    super.dispose();
    newMatchBloc.dispose();
  }
}

class MatchInProgressControls extends StatelessWidget {
  final NewMatch match;

  MatchInProgressControls(this.match);

  @override
  Widget build(BuildContext context) {
    switch (match.status) {
      case NewMatchStatus.finished:
        return Center(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Save'),
              )
            ],
          ),
        );
      case NewMatchStatus.paused:
        return Center(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => newMatchBloc.resume(),
                child: Text('Resume'),
              )
            ],
          ),
        );
      default:
        return Center(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => newMatchBloc.pause(),
                child: Text('Pause'),
              )
            ],
          ),
        );
    }
  }
}

class MatchInProgressScore extends StatelessWidget {
  final NewMatch match;

  MatchInProgressScore(this.match);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Score: ' +
              match.teamA.score.toString() +
              ':' +
              match.teamB.score.toString(),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MatchInProgressTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = NewMatchBlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.counter,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return FormattedTimer(snapshot.data!);
      },
    );
  }
}

class MatchInProgressPlayerTile extends StatelessWidget {
  final User user;

  MatchInProgressPlayerTile(this.user);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => newMatchBloc.recordGoal(user),
      child: UserTile(user),
    );
  }
}
