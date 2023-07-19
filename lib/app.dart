import 'package:flutter/material.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';
import 'package:keepscore/defaults.dart';

// Pages
import 'package:keepscore/pages/home_page.dart';
import 'package:keepscore/pages/match_details_page.dart';
import 'package:keepscore/pages/match_in_progress_page.dart';
import 'package:keepscore/pages/new_match_players_page.dart';
import 'package:keepscore/pages/profile_page.dart';
import 'package:keepscore/pages/splash_page.dart';

class AppFrame extends StatelessWidget {
  const AppFrame({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keepscore',
      theme: BASE_THEME,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/new/players': (context) => const NewMatchPlayersPage(),
        MatchInProgressPage.routeName: (context) => const MatchInProgressPage(),
        MatchDetailsPage.routeName: (context) => const MatchDetailsPage(),
      },
      onGenerateRoute: (_) => SplashPage.route(),
      home: MatchesProvider(
        child: const HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
