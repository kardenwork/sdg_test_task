import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/country_pick/country_pick_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/country_state_pick/country_state_pick_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/location_pick/location_pick_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/view/location_pick_screen.dart';

void main() {
  testGoldens(
    'Initial layout',
    (widgetTester) async {
      final builder = DeviceBuilder();

      final mockLocationPickBloc = _MockLocationPickBloc();
      final mockCountryPickBloc = _MockCountryPickBloc();
      final mockCountryStatePickBloc = _MockCountryStatePickBloc();

      when(() => mockLocationPickBloc.stream).thenAnswer(
        (_) => Stream.value(LocationPickState.initial()),
      );
      when(() => mockLocationPickBloc.state).thenReturn(
        LocationPickState.initial(),
      );
      when(() => mockLocationPickBloc.uiCommandsStream).thenAnswer(
        (_) => const Stream.empty(),
      );
      when(() => mockCountryPickBloc.stream).thenAnswer(
        (_) => Stream.value(
          const CountryPickLoadedState(countries: [], pickedCountry: null),
        ),
      );
      when(() => mockCountryPickBloc.state).thenReturn(
        const CountryPickLoadedState(countries: [], pickedCountry: null),
      );
      when(() => mockCountryStatePickBloc.stream).thenAnswer(
        (_) => Stream.value(
          const CountryStatePickInitialState(),
        ),
      );
      when(() => mockCountryStatePickBloc.state).thenReturn(
        const CountryStatePickInitialState(),
      );

      const testName = 'location_pick_screen_initial';

      builder.addScenario(
        name: testName,
        widget: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LocationPickScreen(
            formBlocFactory: () => mockLocationPickBloc,
            countryPickBlocFactory: () => mockCountryPickBloc,
            countryStatePickBlocFactory: () => mockCountryStatePickBloc,
          ),
        ),
      );

      await widgetTester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(widgetTester, testName);
    },
  );
}

class _MockLocationPickBloc extends Mock implements LocationPickBloc {
  @override
  Future<void> close() async {}
}

class _MockCountryPickBloc extends Mock implements CountryPickBloc {
  @override
  Future<void> close() async {}
}

class _MockCountryStatePickBloc extends Mock implements CountryStatePickBloc {
  @override
  Future<void> close() async {}
}
