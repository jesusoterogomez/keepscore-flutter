import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:keepscore/bloc/auth/auth_bloc.dart';
import 'package:keepscore/pages/login_page.dart';
import 'package:keepscore/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      child: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return StreamBuilder(
      stream: bloc.status,
      builder: (_, AsyncSnapshot<AuthStatus> snapshot) {
        switch (snapshot.data) {
          case AuthStatus.authenticated:
            return AppFrame();
          default:
            return LoginPage();
        }
      },
    );
  }
}
