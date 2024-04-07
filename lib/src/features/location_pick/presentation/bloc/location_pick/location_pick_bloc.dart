import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sdg_test_task/src/core/bloc/ui_commands.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/use_cases/submit_location_use_case.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/models/country_field_error.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/models/country_state_field_error.dart';

part 'location_pick_bloc.freezed.dart';
part 'location_pick_event.dart';
part 'location_pick_state.dart';
part 'location_pick_ui_command.dart';

abstract class LocationPickBloc
    extends Bloc<LocationPickEvent, LocationPickState>
    with UiCommands<LocationPickUiCommand> {
  LocationPickBloc(super.initialState);
}

class LocationPickBlocImpl extends LocationPickBloc {
  LocationPickBlocImpl({
    required SubmitLocationUseCase submitLocationUseCase,
  })  : _submitLocationUseCase = submitLocationUseCase,
        super(LocationPickState.initial()) {
    on<LocationPickCountryPickedEvent>(_onCountryPicked);
    on<LocationPickCountryStatePickedEvent>(_onCountryStatePicked);
    on<LocationPickSubmitRequestedEvent>(_onSubmitRequested);
  }

  final SubmitLocationUseCase _submitLocationUseCase;

  void _onCountryPicked(
    LocationPickCountryPickedEvent event,
    Emitter emit,
  ) {
    if (state.pickedCountry == event.country) return;

    emit(state.copyWith(pickedCountry: event.country));
  }

  void _onCountryStatePicked(
    LocationPickCountryStatePickedEvent event,
    Emitter emit,
  ) {
    if (state.pickedCountryState == event.countryState) return;

    emit(state.copyWith(pickedCountryState: event.countryState));
  }

  Future<void> _onSubmitRequested(
    LocationPickSubmitRequestedEvent _,
    Emitter emit,
  ) async {
    if (!state.canSubmit) return;

    emit(state.copyWith(isSubmitting: true));

    try {
      final country = state.pickedCountry!;
      final countryState = state.pickedCountryState!;

      await _submitLocationUseCase(country, countryState);

      emit(state.copyWith(isSubmitting: false));
      addUiCommand(LocationPickSuccessUiCommand(country, countryState));
    } catch (_, __) {
      addUiCommand(LocationPickErrorUiCommand());
      emit(state.copyWith(isSubmitting: false));
    }
  }
}
