import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_model.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';
import 'package:keepscore/defaults.dart';
import 'package:rxdart/rxdart.dart';

part 'new_match_provider.dart';
part 'new_match_model.dart';

const FIRESTORE_COLLECTION = 'matches_2';

class NewMatchBloc {
  // Streams
  late Timer timer;
  final Duration interval = const Duration(seconds: 1);
  final counter = BehaviorSubject<int>.seeded(0);
  final match = BehaviorSubject<NewMatch>.seeded(NewMatch.empty());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collection;

  // Constructor
  NewMatchBloc() {
    // Create reference to DB collection
    collection = firestore.collection(FIRESTORE_COLLECTION);

    // Timers don't have any helpers for initializing
    // in stopped/paused mode. This initializes it and cancels it
    // immediately to have a proper Timer instance assigned
    // And avoid going around the non-nullable types
    timer = Timer.periodic(interval, (_) => {});
    timer.cancel();
  }

  void dispose() {
    reset();
  }

  void tick(_) {
    int prev = counter.value;
    counter.add(prev + 1);
  }

  void start(players) {
    log('Timer Started');

    startTimer();

    match.add(NewMatch.start(players));
  }

  void resume() {
    startTimer();
    setStatus(NewMatchStatus.started);

    log('Timer Resumed');
  }

  void startTimer() {
    timer = Timer.periodic(interval, tick);
  }

  void stopTimer() {
    if (!timer.isActive) {
      return;
    }

    timer.cancel();
  }

  void setStatus(NewMatchStatus status) {
    NewMatch data = match.value;
    data.status = status;

    match.add(data);
  }

  void pause() {
    stopTimer();
    setStatus(NewMatchStatus.paused);

    log('Timer Paused');
  }

  void setTeams(players) {}

  void recordGoal(User player) {
    NewMatch data = match.value;

    int score = data.recordGoal(player.uid, counter.value);

    // Transition to finished when score limit is reached
    if (score == MATCH_WIN_LIMIT) {
      endMatch();
    }

    match.add(data);
  }

  void endMatch() {
    stopTimer();
    setStatus(NewMatchStatus.finished);
  }

  void reset() {
    NewMatch data = match.value;

    if (data.status == NewMatchStatus.not_started) {
      return;
    }

    stopTimer();
    counter.drain();
    match.drain();

    counter.add(0);
    setStatus(NewMatchStatus.not_started);
  }

  Future<void> saveMatch() async {
    // Prepare to send data
    var data = match.value.toMap();

    print('Saving match: $data');

    try {
      await collection.add(data);
    } catch (error) {
      print('Error $error');
    }
  }
}

// Instantiate
final NewMatchBloc newMatchBloc = NewMatchBloc();
