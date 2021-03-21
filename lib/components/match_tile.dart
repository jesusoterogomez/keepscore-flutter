import 'package:flutter/material.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';

class MatchTile extends StatelessWidget {
  final Match match;
  const MatchTile(this.match);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                // leading: CircleAvatar(
                //   backgroundImage: NetworkImage(plan.author.avatarUrl),
                // ),
                title: Text(match.teams[0].attack.displayName),
                subtitle: Text(match.teams[0].defense.displayName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
