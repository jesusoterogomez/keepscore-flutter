import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_model.dart';
import 'package:keepscore/defaults.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'matches_provider.dart';
part 'matches_model.dart';

const FIRESTORE_COLLECTION = 'matches';

class MatchesBloc {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collection;

  // Streams
  late Stream<QuerySnapshot> collectionState;

  final matches = BehaviorSubject<List<Match>>();

  // Constructor
  MatchesBloc() {
    // Create reference to DB collection
    collection = firestore.collection(FIRESTORE_COLLECTION);

    // Reload plans on DB change
    onCollectionChanged();
  }

  void onCollectionChanged() {
    collectionState = collection.snapshots();
    collectionState.listen((data) => getMatches());
  }

  void getMatches([String filter = '']) async {
    QuerySnapshot snapshot = await collection
        .orderBy(
          'createdAt',
          descending: true,
        )
        .get();

    // Extract data from snapshots
    Iterable<Match> data = snapshot.docs.map(
      (DocumentSnapshot s) => Match.fromSnapshot(s),
    );

    // log(data.first.createdAt.toString());
    // Add to matches stream
    matches.add(List<Match>.from(data));
  }
}

// Instantiate
final MatchesBloc matchesBloc = MatchesBloc();
