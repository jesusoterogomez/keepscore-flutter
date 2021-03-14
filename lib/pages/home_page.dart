import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_bloc.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
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
            title: Text('Home'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Status:' + snapshot.data.toString(),
                ),
                ElevatedButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, '/profile'),
                  },
                  child: Text('Go to my profile'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
