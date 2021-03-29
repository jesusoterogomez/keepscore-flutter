import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_model.dart';
import 'package:keepscore/bloc/users/users_bloc.dart';
import 'package:keepscore/components/user_tile.dart';

class PlayerPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = UsersProvider.of(context);

    // Fetch data
    bloc.getUsers();

    return StreamBuilder(
      stream: bloc.users,
      // initialData: bloc.,
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        // @todo; Remove null check
        List<User> users = snapshot.data!;

        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GridView.count(
            crossAxisCount: 3,
            children: users.map((user) => UserTile(user)).toList(),
          ),
        );
      },
    );
  }
}
