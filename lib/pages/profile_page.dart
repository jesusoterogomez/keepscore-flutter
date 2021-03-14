import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return StreamBuilder(
      stream: bloc.status,
      // initialData: bloc.,
      builder: (BuildContext context, AsyncSnapshot<AuthStatus> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Go back'),
                ),
                ElevatedButton(
                  onPressed: () => bloc.logOut(),
                  child: Text('Log out'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
