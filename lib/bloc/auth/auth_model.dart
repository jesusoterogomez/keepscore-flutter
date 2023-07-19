import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late String email;
  late bool emailVerified;
  late String photoURL;
  late String displayName;
  late String uid;
  late Timestamp lastLogin;
  late String firstName;

  User.empty() {
    email = '';
    emailVerified = false;
    photoURL = '';
    displayName = '';
    uid = '';
    lastLogin = Timestamp.now();
    firstName = '';
  }

  User.fromFirestore(dynamic user) {
    email = user['email'];
    emailVerified = user['emailVerified'];
    photoURL = user['photoURL'];
    displayName = user['displayName'];
    uid = user['uid'];
    lastLogin = user['lastLogin'];
    firstName = user['displayName'].toString().split(' ')[0];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'emailVerified': emailVerified,
      'photoURL': photoURL,
      'displayName': displayName,
      'uid': uid,
      'lastLogin': lastLogin,
      'firstName': firstName,
    };
  }

  User();
}
