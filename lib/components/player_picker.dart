import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepscore/bloc/auth/auth_model.dart';
import 'package:keepscore/bloc/users/users_bloc.dart';
import 'package:keepscore/components/square_avatar.dart';
import 'package:keepscore/components/user_tile.dart';
import 'package:keepscore/defaults.dart';
import 'package:keepscore/pages/match_in_progress_page.dart';

class PlayerPicker extends StatefulWidget {
  const PlayerPicker({super.key});

  @override
  _PlayerPickerState createState() => _PlayerPickerState();
}

class _PlayerPickerState extends State<PlayerPicker> {
  List<dynamic> _players = List.filled(4, null, growable: false);

  void addPlayer(String uid) {
    setState(() {
      // Unselect and keep position if already added
      if (_players.contains(uid)) {
        int replaceIndex = _players.indexOf(uid);
        _players[replaceIndex] = null;
        log(_players.toString());
        return;
      }

      // Replace the first available position in the array
      int firstNull = _players.indexOf(null);
      _players[firstNull] = uid;
    });
  }

  void resetPlayers() {
    setState(() {
      _players = List.filled(4, null, growable: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = UsersProvider.of(context);

    // Fetch data
    bloc.getUsers();

    return StreamBuilder(
      stream: bloc.users,
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        // @todo; Remove null check
        List<User> users = snapshot.data!;
        bool allPlayersSelected = !_players.contains(null);

        bool noSelection = _players.every((element) => element == null);

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: users.map((user) {
                    bool isSelected = _players.contains(user.uid);
                    int position = _players.indexOf(user.uid) + 1;

                    bool teamA = position.clamp(1, 2) == position;

                    return Opacity(
                      opacity: allPlayersSelected && !isSelected ? 0.5 : 1,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isSelected ? GRAY_DARK : null,
                          borderRadius: BORDER_RADIUS,
                        ),
                        child: GestureDetector(
                          onTap: () => addPlayer(user.uid),
                          child: Stack(
                            children: [
                              isSelected
                                  ? Row(
                                      children: [
                                        Text(teamA ? 'Team A' : 'Team B'),
                                        const Text('-'),
                                        Text((position % 2 == 1)
                                            ? '[A]'
                                            : '[D]'),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              UserTile(user),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              noSelection
                  ? const SizedBox.shrink()
                  : PlayerPickerSummary(
                      users,
                      _players,
                      addPlayer,
                      resetPlayers,
                      allPlayersSelected,
                    )
            ],
          ),
        );
      },
    );
  }
}

class PlayerPickerSummary extends StatelessWidget {
  final List<User> users;
  final List<dynamic> players;
  final bool allPlayersSelected;
  final void Function(String) addPlayer;
  final void Function() resetPlayers;

  const PlayerPickerSummary(
    this.users,
    this.players,
    this.addPlayer,
    this.resetPlayers,
    this.allPlayersSelected,
  );

  User findPlayer(String uid, List<User> users) {
    return users.firstWhere((u) => u.uid == uid);
  }

  @override
  Widget build(BuildContext context) {
    List teamA = players.sublist(0, 2);
    List teamB = players.sublist(2, 4);

    return Container(
      // height: 140,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 5,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: GRAY_DEFAULT,
        borderRadius: BORDER_RADIUS,
      ),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Merge different lists to place a "vs." text in the middle
              children: [
                teamA
                    .map(
                      (player) => GestureDetector(
                        onTap: () => addPlayer(player),
                        child: Container(
                          height: 56,
                          width: 56,
                          color: GRAY_DARK,
                          child: player == null
                              ? const SizedBox.shrink()
                              : SquaredAvatar(
                                  findPlayer(player, users).photoURL,
                                  48,
                                ),
                        ),
                      ),
                    )
                    .toList(),
                [
                  Text(
                    'vs.',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                ],
                teamB
                    .map(
                      (player) => GestureDetector(
                        onTap: () => addPlayer(player),
                        child: Container(
                          height: 56,
                          width: 56,
                          color: GRAY_DARK,
                          child: player == null
                              ? const SizedBox.shrink()
                              : SquaredAvatar(
                                  findPlayer(player, users).photoURL,
                                  48,
                                ),
                        ),
                      ),
                    )
                    .toList(),
              ].expand((x) => x).toList()),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 56,
                child: ElevatedButton(
                  onPressed: () => resetPlayers(),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                  ),
                  child: const Icon(
                    Icons.refresh,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Opacity(
                  opacity: allPlayersSelected ? 1 : 0.2,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        if (!allPlayersSelected) {
                          return;
                        }

                        // Navigate to Match Start and pass 4 selected players
                        Navigator.pushNamed(
                          context,
                          MatchInProgressPage.routeName,
                          arguments: MatchInProgressPageArguments(players
                              .map(
                                (player) => findPlayer(player, users),
                              )
                              .toList()),
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                      ),
                      icon: const Icon(
                        Icons.bolt,
                        size: 24,
                      ),
                      label: const Text('Start Match')),
                ),
              )
            ],
          )
          // SquaredAvatar(findPlayer(players[1], users).photoURL, 48),
        ],
      ),
    );
  }
}
