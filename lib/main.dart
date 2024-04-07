import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdg_test_task/src/app_di.dart';
import 'package:sdg_test_task/src/cdg_test_task_app.dart';
import 'package:sdg_test_task/src/core/bloc/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final di = AppDi();
  final getItInstance = await di.initialize();

  if (kDebugMode) Bloc.observer = AppBlocObserver();

  runApp(CdgTestTaskApp(getIt: getItInstance));
}
