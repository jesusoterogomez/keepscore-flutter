part of 'new_match_bloc.dart';

class NewMatch {
  int secondsElapsed = 0;
  NewMatchStatus status = NewMatchStatus.not_started;
  Timestamp startedAt = Timestamp.now();
  late List<TimelineEntry> timeline;

  // Teams
  late Team teamA;
  late Team teamB;

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
}

enum TimelineEntryType {
  goal,
}

enum NewMatchStatus {
  not_started,
  started,
  paused,
  finished,
}
