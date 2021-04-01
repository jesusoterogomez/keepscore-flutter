part of 'new_match_bloc.dart';

class NewMatch {
  int secondsElapsed = 0;
  NewMatchStatus status = NewMatchStatus.not_started;
  Timestamp startedAt = Timestamp.now();
  FieldValue createdAt = FieldValue.serverTimestamp();
  MatchType type = MatchType.doubles;
  late List<TimelineEntry> timeline;

  // Teams
  late Team teamA;
  late Team teamB;

  NewMatch.empty() {
    teamA = Team.empty();
    teamB = Team.empty();
    startedAt = Timestamp.now();
    timeline = [];
  }

  NewMatch.start(List<User> players) {
    status = NewMatchStatus.started;
    secondsElapsed = 0;
    teamA = Team.fromMatchStart(players[0], players[1]);
    teamB = Team.fromMatchStart(players[2], players[3]);
    startedAt = Timestamp.now();
    timeline = [];
  }

  NewMatch();

  int recordGoal(String uid, int seconds) {
    int score = 0;

    if (teamA.containsPlayer(uid)) {
      score = teamA.recordGoal(uid);
    }

    if (teamB.containsPlayer(uid)) {
      score = teamB.recordGoal(uid);
    }

    // Add goal to timeline
    timeline.add(TimelineEntry.record(uid, seconds));

    return score;
  }

  Map<String, dynamic> toMap() {
    return {
      'startedAt': startedAt,
      'createdAt': createdAt,
      'teams': [
        teamA.toMap(),
        teamB.toMap(),
      ].toList(),
      'type': type.toString().split('.').last,
      'timeline': timeline.map((t) => t.toMap()).toList()
    };
  }
}

class TimelineEntry {
  late String uid;
  late int seconds;

  TimelineEntryType type = TimelineEntryType.goal;

  TimelineEntry.record(String _uid, int _seconds) {
    uid = _uid;
    seconds = _seconds;
    type = TimelineEntryType.goal;
  }

  TimelineEntry();

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'seconds': seconds,
    };
  }
}

enum TimelineEntryType {
  goal,
}

enum MatchType {
  singles,
  doubles,
}

enum NewMatchStatus {
  not_started,
  started,
  paused,
  finished,
}
