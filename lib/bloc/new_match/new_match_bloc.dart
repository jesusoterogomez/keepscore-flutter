import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'new_match_provider.dart';
part 'new_match_model.dart';

class NewMatchBloc {
  // Streams
  // final timer = BehaviorSubject<Timer>();
  late Timer timer;
  final Duration interval = Duration(seconds: 1);
  final counter = BehaviorSubject<int>.seeded(0);

  // Constructor
  NewMatchBloc() {
    // Create reference to DB collection
    // Reload plans on DB change
  }

  void dispose() {
    reset();
  }

  void tick(_) {
    int prev = counter.value!;
    log(prev.toString());
    counter.add(prev + 1);
  }

  void start() {
    // reset();
    timer = Timer.periodic(interval, tick);
  }

  void pause() {
    if (!timer.isActive) {
      return;
    }

    timer.cancel();
  }

  void reset() {
    if (timer.isActive) {
      timer.cancel();
      counter.drain();
    }

    counter.add(0);
  }
}

// Instantiate
final NewMatchBloc newMatchBloc = NewMatchBloc();
