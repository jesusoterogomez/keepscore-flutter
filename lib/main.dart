import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_bloc.dart';
import 'package:keepscore/pages/login_page.dart';
import 'package:keepscore/app.dart';

// Flutter
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      child: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return StreamBuilder(
      stream: bloc.status,
      builder: (_, AsyncSnapshot<AuthStatus> snapshot) {
        switch (snapshot.data) {
          case AuthStatus.authenticated:
            return const AppFrame();
          default:
            return const LoginPage();
        }
      },
    );
  }
}
