import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepscore/bloc/matches/matches_bloc.dart';
import 'package:keepscore/components/match_tile.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MatchesProvider.of(context);
    // Fetch data
    bloc.getMatches();

    return StreamBuilder(
      stream: bloc.matches,
      builder: (BuildContext context, AsyncSnapshot<List<Match>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<Match> matches = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: matches.map((match) => MatchTile(match)).toList(),
          ),
          bottomNavigationBar: Container(
            height: 100,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: BoxDecoration(
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
                            EdgeInsets.all(14),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFFE5E5E5),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                        ),
                        icon: Icon(
                          Icons.grid_view,
                          size: 22,
                        ),
                        label: Row(
                          children: [
                            SizedBox(
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
                            EdgeInsets.all(14),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFFE5E5E5).withOpacity(0),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                        ),
                        icon: Icon(
                          Icons.bar_chart,
                          size: 22,
                        ),
                        label: Row(
                          children: [
                            SizedBox(
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
                            EdgeInsets.symmetric(
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
                        child: Center(
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
                            EdgeInsets.all(14),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                        ),
                        child: Text('Me'),
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
