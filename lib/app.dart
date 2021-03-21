import 'package:flutter/material.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';

// Pages
import 'package:keepscore/pages/home_page.dart';
import 'package:keepscore/pages/profile_page.dart';
import 'package:keepscore/pages/splash_page.dart';

class AppFrame extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      home: MatchesProvider(
        child: HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
