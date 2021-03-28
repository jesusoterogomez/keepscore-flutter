part of 'matches_bloc.dart';

class Match {
  late String type;
  late Timestamp createdAt;
  late List<Team> teams;

  Match.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()!;

    type = data['type'];
    createdAt = data['createdAt'];
    teams = List<Team>.from(data['teams'].map(
      (item) => Team.fromFirestore(item),
    ));
  }

  Match();
}

class Team {
  late User attack;
  late User defense;
  late int score;
  late bool win;

  Team.fromFirestore(dynamic team) {
    this.attack = User.fromFirestore(team['attack']);
    this.defense = User.fromFirestore(team['defense']);
    this.score = team['score'];
    this.win = team['win'];
  }

  Team(attack, defense);
}
