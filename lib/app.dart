import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_bloc.dart';

// Pages
import 'package:keepscore/pages/login_page.dart';
import 'package:keepscore/pages/home_page.dart';
import 'package:keepscore/pages/profile_page.dart';
import 'package:keepscore/pages/splash_page.dart';

class AppFrame extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return MaterialApp(
      title: 'Keepscore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
      },
      onGenerateRoute: (_) => SplashPage.route(),
      home: HomePage(),
      // home: StreamBuilder(
      //   stream: bloc.status,
      //   builder: (_, AsyncSnapshot<AuthStatus> snapshot) {
      //     log('Data! ' + snapshot.data.toString());
      //     switch (snapshot.data) {
      //       case AuthStatus.authenticated:
      //         return HomePage();
      //       default:
      //         log('Render login page!');
      //         return P();
      //     }
      //   },
      // ),
      debugShowCheckedModeBanner: false,
    );
  }
}
