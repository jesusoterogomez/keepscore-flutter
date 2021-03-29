import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'users_provider.dart';

const FIRESTORE_COLLECTION = 'users';

class UsersBloc {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference collection;

  // Streams
  late Stream<QuerySnapshot> collectionState;

  final users = BehaviorSubject<List<User>>();

  // Constructor
  UsersBloc() {
    // Create reference to DB collection
    collection = firestore.collection(FIRESTORE_COLLECTION);

    // Reload plans on DB change
    onCollectionChanged();
  }

  void onCollectionChanged() {
    collectionState = collection.snapshots();
    collectionState.listen((data) => getUsers());
  }

  void getUsers([String filter = '']) async {
    QuerySnapshot snapshot = await collection.orderBy('displayName').get();

    // Extract data from snapshots
    Iterable<User> data = snapshot.docs.map(
      (DocumentSnapshot s) => User.fromFirestore(s.data()),
    );

    // log(data.first.createdAt.toString());
    // Add to matches stream
    users.add(List<User>.from(data));
  }
}

// Instantiate
final UsersBloc usersBloc = UsersBloc();
