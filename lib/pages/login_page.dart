import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: bloc.status,
        // initialData: bloc.,
        builder: (BuildContext context, AsyncSnapshot<AuthStatus> snapshot) {
          return Center(
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Status:' + snapshot.data.toString(),
                    ),
                    ElevatedButton(
                      // onPressed: () => bloc.logInWithGoogle(),
                      onPressed: () => bloc.logInWithGoogle(),
                      child: Text('Log in with Google'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
