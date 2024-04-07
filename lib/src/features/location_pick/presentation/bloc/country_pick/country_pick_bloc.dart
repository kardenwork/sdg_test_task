import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/use_cases/get_countries_use_case.dart';

part 'country_pick_event.dart';
part 'country_pick_state.dart';

abstract class CountryPickBloc
    extends Bloc<CountryPickEvent, CountryPickState> {
  CountryPickBloc(super.initialState);
}

class CountryPickBlocImpl extends CountryPickBloc {
  CountryPickBlocImpl({
    required GetCountriesUseCase getCountriesUseCase,
  })  : _getCountriesUseCase = getCountriesUseCase,
        super(const CountryPickLoadingState()) {
    on<CountryPickLoadRequestedEvent>(_onLoadRequested);
    on<CountryPickCountryPickedEvent>(_onCountryPicked);
  }

  final GetCountriesUseCase _getCountriesUseCase;

  Future<void> _onLoadRequested(
    CountryPickLoadRequestedEvent _,
    Emitter emit,
  ) async {
    emit(const CountryPickLoadingState());

    try {
      final countries = await _getCountriesUseCase();

      emit(CountryPickLoadedState(countries: countries, pickedCountry: null));
    } catch (_, __) {
      emit(const CountryPickErrorState());
    }
  }

  void _onCountryPicked(
    CountryPickCountryPickedEvent event,
    Emitter emit,
  ) {
    switch (state) {
      case CountryPickLoadedState(
          :final countries,
          :final pickedCountry,
        ):
        if (event.country == pickedCountry) return;

        emit(
          CountryPickLoadedState(
            countries: countries,
            pickedCountry: event.country,
          ),
        );
        break;
      default:
        break;
    }
  }
}
