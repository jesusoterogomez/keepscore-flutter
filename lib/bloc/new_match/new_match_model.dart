part of 'new_match_bloc.dart';

class NewMatch {
  late Timer timer;
  final Duration timerInterval = Duration(seconds: 1);
  late List<TimelineEntry> timeline;

  // late String email;
  // late bool emailVerified;
  // late String photoURL;
  // late String displayName;
  // late String uid;
  // late Timestamp lastLogin;
  // late String firstName;

  NewMatch();
}

class TimelineEntry {
  late String uid;
  TimelineEntryType type = TimelineEntryType.goal;
  late Duration time;

  TimelineEntry();
}

enum TimelineEntryType {
  goal,
}
