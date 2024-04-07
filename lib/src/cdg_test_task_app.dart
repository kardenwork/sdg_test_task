import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/country_pick/country_pick_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/country_state_pick/country_state_pick_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/location_pick/location_pick_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/view/location_pick_screen.dart';

class CdgTestTaskApp extends StatelessWidget {
  const CdgTestTaskApp({required this.getIt, super.key});

  final GetIt getIt;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CDG Test Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LocationPickScreen(
        formBlocFactory: getIt.call<LocationPickBloc>,
        countryPickBlocFactory: getIt.call<CountryPickBloc>,
        countryStatePickBlocFactory: getIt.call<CountryStatePickBloc>,
      ),
    );
  }
}
