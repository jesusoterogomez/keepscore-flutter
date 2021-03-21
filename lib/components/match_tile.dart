import 'package:flutter/material.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';

class MatchTile extends StatelessWidget {
  final Match match;
  const MatchTile(this.match);

  @override
  Widget build(BuildContext context) {
    Team teamA = match.teams[0];
    Team teamB = match.teams[1];

    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      match.createdAt.toDate().toString(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('[A] '),
                    CircleAvatar(
                      maxRadius: 12,
                      backgroundImage: NetworkImage(teamA.attack.photoURL),
                    ),
                    Text(teamA.attack.firstName),
                    Text(' [D] '),
                    CircleAvatar(
                      maxRadius: 12,
                      backgroundImage: NetworkImage(teamA.defense.photoURL),
                    ),
                    Text(teamA.defense.firstName),
                    Text(' [S] '),
                    Text(teamA.score.toString()),
                  ],
                ),
                Row(
                  children: [
                    Text('[A] '),
                    CircleAvatar(
                      maxRadius: 12,
                      backgroundImage: NetworkImage(teamB.attack.photoURL),
                    ),
                    Text(teamB.attack.firstName),
                    Text(' [D] '),
                    CircleAvatar(
                      maxRadius: 12,
                      backgroundImage: NetworkImage(teamB.defense.photoURL),
                    ),
                    Text(teamB.defense.firstName),
                    Text(' [S] '),
                    Text(teamB.score.toString()),
                  ],
                ),

                // ListTile(
                //   // leading: CircleAvatar(
                //   //   backgroundImage: NetworkImage(plan.author.avatarUrl),
                //   // ),
                //   title: Text(match.teams[0].attack.displayName),
                //   subtitle: Text(match.teams[0].defense.displayName),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
