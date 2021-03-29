import 'package:flutter/material.dart';
import 'package:keepscore/bloc/users/users_bloc.dart';
import 'package:keepscore/components/player_picker.dart';

class NewMatchPlayersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Players'),
      ),
      body: UsersProvider(
        child: PlayerPicker(),
      ),
    );
  }
}
