part of 'matches_bloc.dart';

class MatchesProvider extends InheritedWidget {
  final MatchesBloc bloc;

  MatchesProvider({
    Key? key,
    required Widget child,
  })   : bloc = matchesBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MatchesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<MatchesProvider>())!
        .bloc;
  }
}
