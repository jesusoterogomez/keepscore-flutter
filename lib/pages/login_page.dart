import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: bloc.status,
        builder: (BuildContext context, AsyncSnapshot<AuthStatus> snapshot) {
          return Center(
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Status:${snapshot.data}',
                    ),
                    ElevatedButton(
                      onPressed: () => bloc.logInWithGoogle(),
                      child: const Text('Log in with Google'),
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
