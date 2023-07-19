import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

// Make sure to enable google sign in via XCode
// @see: https://developers.google.com/identity/sign-in/ios/start-integrating#add_a_url_scheme_to_your_project

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
  BehaviorSubject<AuthStatus> status = BehaviorSubject.seeded(
    AuthStatus.uninitialized,
  );

  // Constructor
  AuthBloc() {
    // Initialize
    // status.add(AuthStatus.uninitialized);

    // Listeners
    status.listen((value) => log('Auth changed: $value'));

    // Check current authentication state
    getCurrentAuth();
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    status.add(AuthStatus.loading);

    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);

      status.add(AuthStatus.authenticated);
    } catch (error) {
      log(error.toString());
      status.add(AuthStatus.failed);
    }
  }

  fakeLogIn() {
    status.add(AuthStatus.authenticated);
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);

      status.add(AuthStatus.unauthenticated);
    } on Exception {
      // throw LogOutFailure();
    }
  }

  Future<void> getCurrentAuth() async {
    status.add(AuthStatus.loading);

    User? user = _firebaseAuth.currentUser;
    if (user == null) {
      status.add(AuthStatus.unauthenticated);
      return;
    }

    log('user: $user');
    status.add(AuthStatus.authenticated);
  }
}

// Instantiate
final AuthBloc authBloc = AuthBloc();
