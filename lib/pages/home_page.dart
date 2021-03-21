import 'package:flutter/material.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';
import 'package:keepscore/components/match_tile.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MatchesProvider.of(context);
    // Fetch data
    bloc.getMatches();

    return StreamBuilder(
      stream: bloc.matches,
      builder: (BuildContext context, AsyncSnapshot<List<Match>> snapshot) {
        // @todo; Remove null check
        List<Match> matches = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: matches
                .map(
                  (match) => MatchTile(match),
                )
                .toList(),
            // children: matches
            //     .map(
            //       (match) => Container(
            //         height: 30,
            //         color: Colors.amber[600],
            //         child: Center(
            //           child: Text(match.teams[0].attack.displayName),
            //         ),
            //       ),
            //     )
            //     .toList(),
          ),
        );
      },
    );
  }
}
