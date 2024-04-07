import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/use_cases/get_country_states_use_case.dart';

part 'country_state_pick_event.dart';
part 'country_state_pick_state.dart';

abstract class CountryStatePickBloc
    extends Bloc<CountryStatePickEvent, CountryStatePickState> {
  CountryStatePickBloc(super.initialState);
}

class CountryStatePickBlocImpl extends CountryStatePickBloc {
  CountryStatePickBlocImpl({
    required GetCountryStatesUseCase getCountryStatesUseCase,
  })  : _getCountryStatesUseCase = getCountryStatesUseCase,
        super(const CountryStatePickInitialState()) {
    on<CountryStatePickCountryChangedEvent>(_onCountryChangedRequested);
    on<CountryStatePickCountryStatePickedEvent>(_onCountryStatePicked);
    on<CountryStatePickRefreshRequestedEvent>(_onRefreshRequested);
  }

  final GetCountryStatesUseCase _getCountryStatesUseCase;

  Future<void> _onCountryChangedRequested(
    CountryStatePickCountryChangedEvent event,
    Emitter emit,
  ) async {
    final newCountry = event.country;

    if (state.country == newCountry) return;

    if (newCountry == null) {
      emit(const CountryStatePickInitialState());
      return;
    }

    await _loadAndSetCountryStates(newCountry, emit);
  }

  void _onCountryStatePicked(
    CountryStatePickCountryStatePickedEvent event,
    Emitter emit,
  ) {
    switch (state) {
      case CountryStatePickLoadedState(countryStates: final countryStates):
        _emitLoadedState(
          countryStates: countryStates,
          emit: emit,
          pickedCountryState: event.countryState,
        );
        break;
      default:
        break;
    }
  }

  Future<void> _onRefreshRequested(
    CountryStatePickRefreshRequestedEvent _,
    Emitter emit,
  ) async {
    final country = state.country;

    if (country == null) {
      emit(const CountryStatePickInitialState());
      return;
    }

    await _loadAndSetCountryStates(country, emit);
  }

  Future<void> _loadAndSetCountryStates(Country country, Emitter emit) async {
    emit(CountryStatePickLoadingState(country: country));

    try {
      final countryStates = await _getCountryStatesUseCase(country);

      _emitLoadedState(countryStates: countryStates, emit: emit);
    } catch (_, __) {
      _emitErrorState(emit);
    }
  }

  void _emitLoadedState({
    required List<CountryState> countryStates,
    CountryState? pickedCountryState,
    required Emitter emit,
  }) {
    emit(
      CountryStatePickLoadedState(
        countryStates: countryStates,
        pickedCountryState: pickedCountryState,
        country: state.country,
      ),
    );
  }

  void _emitErrorState(Emitter emit) {
    emit(CountryStatePickErrorState(country: state.country));
  }
}
