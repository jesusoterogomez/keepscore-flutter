part of 'matches_bloc.dart';

class Match {
  late String type;
  late Timestamp createdAt;
  late List<Team> teams;

  Match.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()!;

    type = data['type'];

    // The server timestamp might be slightly ahead of the local time, when the
    // match collection refreshes, the createdAt value might be null for a few milliseconds.
    createdAt = data['createdAt'] != null ? data['createdAt'] : Timestamp.now();

    teams = List<Team>.from(data['teams'].map(
      (item) => Team.fromFirestore(item),
    ));
  }

  Match();
}

class Team {
  late User attack;
  late User defense;
  bool win = false;
  int score = 0;

  Team.empty() {
    this.attack = User.empty();
    this.defense = User.empty();
  }

  Team.fromFirestore(dynamic team) {
    this.attack = User.fromFirestore(team['attack']);
    this.defense = User.fromFirestore(team['defense']);
    this.score = team['score'];
    this.win = team['win'];
  }

  Team.fromMatchStart(User user1, User user2) {
    attack = user1;
    defense = user2;
    win = false;
    score = 0;
  }

  Team(attack, defense);

  int recordGoal(String uid) {
    score = score + 1;
    // Record goal for the specific player
    if (attack.uid == uid) {}
    if (defense.uid == uid) {}
    if (score == MATCH_WIN_LIMIT) {
      win = true;
    }

    return score;
  }

  // Check if a specific user (by ID) is part of the team.
  bool containsPlayer(String uid) {
    return [
      attack.uid,
      defense.uid,
    ].contains(uid);
  }

  Map<String, dynamic> toMap() {
    return {
      'attack': attack.toMap(),
      'defense': defense.toMap(),
      'win': win,
      'score': score,
    };
  }
}
