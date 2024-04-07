import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sdg_test_task/src/core/bloc/ui_commands.dart';

class UiCommandsListener<T> extends StatefulWidget {
  const UiCommandsListener({
    required this.emitter,
    required this.listener,
    this.child,
    super.key,
  });

  final UiCommands<T> emitter;
  final void Function(BuildContext context, T command) listener;
  final Widget? child;

  @override
  State<UiCommandsListener<T>> createState() => _UiCommandsListenerState<T>();
}

class _UiCommandsListenerState<T> extends State<UiCommandsListener<T>> {
  StreamSubscription<T>? _subscription;

  @override
  void didChangeDependencies() {
    _subscription ??= widget.emitter.uiCommandsStream.listen(
      (command) => widget.listener(context, command),
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
