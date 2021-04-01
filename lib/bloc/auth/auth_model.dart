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
    this.email = '';
    this.emailVerified = false;
    this.photoURL = '';
    this.displayName = '';
    this.uid = '';
    this.lastLogin = Timestamp.now();
    this.firstName = '';
  }

  User.fromFirestore(dynamic user) {
    this.email = user['email'];
    this.emailVerified = user['emailVerified'];
    this.photoURL = user['photoURL'];
    this.displayName = user['displayName'];
    this.uid = user['uid'];
    this.lastLogin = user['lastLogin'];
    this.firstName = user['displayName'].toString().split(' ')[0];
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
