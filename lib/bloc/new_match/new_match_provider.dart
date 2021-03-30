part of 'new_match_bloc.dart';

class NewMatchBlocProvider extends InheritedWidget {
  final NewMatchBloc bloc;

  NewMatchBlocProvider({
    Key? key,
    required Widget child,
  })   : bloc = newMatchBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static NewMatchBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<NewMatchBlocProvider>())!
        .bloc;
  }
}
