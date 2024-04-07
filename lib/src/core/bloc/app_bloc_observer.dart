import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint(
      '$bloc state changed!\n'
      'Old state: ${change.currentState}\n'
      'New state: ${change.nextState}',
    );
    super.onChange(bloc, change);
  }
}
