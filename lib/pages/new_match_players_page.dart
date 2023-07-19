import 'package:flutter/material.dart';
import 'package:keepscore/bloc/users/users_bloc.dart';
import 'package:keepscore/components/player_picker.dart';

class NewMatchPlayersPage extends StatelessWidget {
  const NewMatchPlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Players'),
      ),
      body: UsersProvider(
        child: const PlayerPicker(),
      ),
    );
  }
}
