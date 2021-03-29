part of 'users_bloc.dart';

class UsersProvider extends InheritedWidget {
  final UsersBloc bloc;

  UsersProvider({
    Key? key,
    required Widget child,
  })   : bloc = usersBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UsersBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<UsersProvider>())!.bloc;
  }
}
