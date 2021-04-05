part of 'matches_bloc.dart';

class Match {
  late String id;
  late String type;
  late List<TimelineEntry> timeline;
  late Timestamp createdAt;
  late Timestamp startedAt;
  late List<Team> teams;

  Match.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    id = snapshot.id;
    type = data['type'];

    timeline = List<TimelineEntry>.from(data['timeline'].map(
      (item) => TimelineEntry.fromFirestore(item),
    ));

    // The server timestamp might be slightly ahead of the local time, when the
    // match collection refreshes, the createdAt value might be null for a few milliseconds.
    createdAt = data['createdAt'] != null ? data['createdAt'] : Timestamp.now();
    startedAt = data['startedAt'];

    teams = List<Team>.from(data['teams'].map(
      (item) => Team.fromFirestore(item),
    ));
  }

  Match();

  Player getPlayer(String uid) {
    if (teams[0].attack.uid == uid) {
      return Player.fromUser(
          teams[0].attack, PlayerPosition.attack, PlayerTeam.A);
    }

    if (teams[0].defense.uid == uid) {
      return Player.fromUser(
          teams[0].defense, PlayerPosition.defense, PlayerTeam.A);
    }

    if (teams[1].attack.uid == uid) {
      return Player.fromUser(
          teams[1].attack, PlayerPosition.attack, PlayerTeam.B);
    }

    if (teams[1].defense.uid == uid) {
      return Player.fromUser(
          teams[1].defense, PlayerPosition.defense, PlayerTeam.B);
    }

    return Player();
  }
}

class Player {
  late PlayerPosition position;
  late PlayerTeam team;
  late User user;

  Player.fromUser(User user, position, team) {
    log(user.displayName.toString());
    this.user = user;
    this.position = position;
    this.team = team;
  }

  Player();
}

enum PlayerPosition {
  defense,
  attack,
}

enum PlayerTeam {
  A,
  B,
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
