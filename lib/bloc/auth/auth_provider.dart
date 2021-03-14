part of 'auth_bloc.dart';

/// Adds support for Auth Bloc
class AuthProvider extends InheritedWidget {
  final AuthBloc bloc;

  AuthProvider({
    Key? key,
    required Widget child,
  })   : bloc = authBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AuthProvider>())!.bloc;
  }
}
