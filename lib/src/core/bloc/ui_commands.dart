import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin UiCommands<T> on Closable {
  final StreamController<T> _controller = StreamController();

  Stream<T> get uiCommandsStream => _controller.stream;

  @protected
  void addUiCommand(T command) {
    _controller.add(command);
  }

  @override
  Future<void> close() async {
    _controller.close();
    await super.close();
  }
}
