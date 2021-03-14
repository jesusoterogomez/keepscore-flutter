import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_provider.dart';

enum AuthStatus {
  uninitialized,
  loading,
  authenticated,
  unauthenticated,
  failed,
}

class AuthBloc {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Streams
  // Stream<User> user;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  // BehaviorSubject profile = BehaviorSubject(); // User data in Firestore
  BehaviorSubject<AuthStatus> status =
      BehaviorSubject(); // authentication status

  // Constructor
  AuthBloc() {
    // Initialize
    status.add(AuthStatus.uninitialized);
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    status.add(AuthStatus.loading);

    try {
      log(AuthStatus.loading.toString());

      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);

      status.add(AuthStatus.authenticated);
    } on Exception {
      // throw LogInWithGoogleFailure();

      status.add(AuthStatus.failed);
    }
  }
}

// Instantiate
final AuthBloc authBloc = AuthBloc();
