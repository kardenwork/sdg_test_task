import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/use_cases/submit_location_use_case.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/location_pick/location_pick_bloc.dart';

void main() {
  final mockSubmitUseCase = _MockSubmitLocationUseCase();

  LocationPickBlocImpl getUut() => LocationPickBlocImpl(
        submitLocationUseCase: mockSubmitUseCase,
      );

  group(
    'LocationPickBloc',
    () {
      blocTest(
        'Initial',
        build: getUut,
        expect: () => [],
        verify: (bloc) => expect(
          bloc.state,
          const TypeMatcher<LocationPickState>()
              .having(
                (state) => state.pickedCountry,
                'No country picked',
                isNull,
              )
              .having(
                (state) => state.pickedCountryState,
                'No country state picked',
                isNull,
              )
              .having(
                (state) => state.canSubmit,
                'Unable to submit empty fields',
                isFalse,
              ),
        ),
      );

      const fakeCountry = Country(id: 1, name: 'Fake Country');

      blocTest(
        'Sets country in state on first pick. '
        'On subsequent picks of the same country does nothing. ',
        build: getUut,
        act: (bloc) {
          bloc.add(const LocationPickCountryPickedEvent(fakeCountry));
          bloc.add(const LocationPickCountryPickedEvent(fakeCountry));
        },
        expect: () => [
          const TypeMatcher<LocationPickState>().having(
            (state) => state.pickedCountry,
            'Country is picked',
            fakeCountry,
          ),
        ],
      );

      const fakeCountryState = CountryState(id: 1, name: 'Fake Country State');

      blocTest(
        'Submit is enabled only after both country and country state have been picked',
        build: getUut,
        act: (bloc) {
          bloc.add(const LocationPickCountryPickedEvent(fakeCountry));
          bloc.add(const LocationPickCountryStatePickedEvent(fakeCountryState));
        },
        expect: () => [
          const TypeMatcher<LocationPickState>()
              .having(
                (state) => state.pickedCountry,
                'Country is picked',
                fakeCountry,
              )
              .having(
                (state) => state.pickedCountryState,
                'Country state has not been picked yet',
                isNull,
              )
              .having(
                (state) => state.canSubmit,
                'Can not submit',
                isFalse,
              ),
          const TypeMatcher<LocationPickState>()
              .having(
                (state) => state.pickedCountry,
                'Country is picked',
                fakeCountry,
              )
              .having(
                (state) => state.pickedCountryState,
                'Country state is picked',
                fakeCountryState,
              )
              .having(
                (state) => state.canSubmit,
                'Can submit',
                isTrue,
              ),
        ],
      );
    },
  );
}

final class _MockSubmitLocationUseCase extends Mock
    implements SubmitLocationUseCase {}
