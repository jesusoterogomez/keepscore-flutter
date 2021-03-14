import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:keepscore/app.dart';
import 'package:keepscore/bloc/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      child: AppFrame(),
    );
  }
}

// class App extends StatelessWidget {
//   final Future<FirebaseApp> flutterFireInit = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: flutterFireInit, // Initialize FlutterFire
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               snapshot.toString(),
//               textDirection: TextDirection.ltr,
//             ),
//           );
//         }

//         // Display app on a successful connection to Firebase
//         if (snapshot.connectionState == ConnectionState.done) {
//           // return Center(
//           //   child: Text(
//           //     'Not loading anymore!',
//           //     textDirection: TextDirection.ltr,
//           //   ),
//           // );
//           return AppContainer();
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return Center(
//           child: Text(
//             'Loading!',
//             textDirection: TextDirection.ltr,
//           ),
//         );
//       },
//     );
//   }
// }
