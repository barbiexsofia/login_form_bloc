import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(
        'OBSERVER |  Bloc: ${bloc.runtimeType} - Event: ${transition.event.runtimeType} - CurrentState : ${transition.currentState.runtimeType} - NextState : ${transition.nextState.runtimeType} ');
  }
}
