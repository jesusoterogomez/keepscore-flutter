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

  const MatchInProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MatchInProgressPageArguments args = ModalRoute.of(context)!
        .settings
        .arguments as MatchInProgressPageArguments;

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
  const MatchInProgressPageContent(this.players, {super.key});

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
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
          child: StreamBuilder(
            stream: bloc.match,
            initialData: NewMatch.empty(),
            builder: (BuildContext context, AsyncSnapshot<NewMatch> snapshot) {
              NewMatch match = snapshot.data!;

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
                    const MatchInProgressTimer(),
                    MatchInProgressControls(match),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: teamB
                          .map((user) => MatchInProgressPlayerTile(user))
                          .toList(),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Back'),
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

  const MatchInProgressControls(this.match, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (match.status) {
      case NewMatchStatus.finished:
        return Center(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => newMatchBloc.saveMatch(),
                child: const Text('Save'),
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
                child: const Text('Resume'),
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
                child: const Text('Pause'),
              )
            ],
          ),
        );
    }
  }
}

class MatchInProgressScore extends StatelessWidget {
  final NewMatch match;

  const MatchInProgressScore(this.match, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Score: ${match.teamA.score}:${match.teamB.score}',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MatchInProgressTimer extends StatelessWidget {
  const MatchInProgressTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = NewMatchBlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.counter,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return FormattedTimer(snapshot.data!);
      },
    );
  }
}

class MatchInProgressPlayerTile extends StatelessWidget {
  final User user;

  const MatchInProgressPlayerTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => newMatchBloc.recordGoal(user),
      child: UserTile(user),
    );
  }
}
