import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';
import 'package:keepscore/components/match_tile.dart';
import 'package:keepscore/pages/match_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MatchesProvider.of(context);
    // Fetch data
    bloc.getMatches();
    // timeDilation = 5.0;

    return StreamBuilder(
      stream: bloc.matches,
      builder: (BuildContext context, AsyncSnapshot<List<Match>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        List<Match> matches = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: matches
                .map(
                  (match) => MatchTile(
                    match,
                    () => Navigator.pushNamed(
                      context,
                      MatchDetailsPage.routeName,
                      arguments: MatchDetailsPageArguments(match),
                    ),
                  ),
                )
                .toList(),
          ),
          bottomNavigationBar: Container(
            height: 100,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Respond to button press
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(14),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFE5E5E5),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                        ),
                        icon: const Icon(
                          Icons.grid_view,
                          size: 22,
                        ),
                        label: Row(
                          children: [
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Home",
                              style: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Respond to button press
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(14),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFE5E5E5).withOpacity(0),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                        ),
                        icon: const Icon(
                          Icons.bar_chart,
                          size: 22,
                        ),
                        label: Row(
                          children: [
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "",
                              style: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/new/players');
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 0,
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                        ),
                        child: const Center(
                          heightFactor: 1,
                          child: Icon(
                            Icons.bolt,
                            size: 24,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(14),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                        ),
                        child: const Text('Me'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
