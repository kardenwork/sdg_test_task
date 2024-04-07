part of 'location_pick_bloc.dart';

@freezed
class LocationPickState with _$LocationPickState {
  const LocationPickState._();

  const factory LocationPickState({
    required Country? pickedCountry,
    required CountryState? pickedCountryState,
    required CountryFieldError? countryFieldError,
    required CountryStateFieldError? countryStateFieldError,
    required bool isSubmitting,
  }) = _LocationPickState;

  factory LocationPickState.initial() => const LocationPickState(
        pickedCountry: null,
        pickedCountryState: null,
        countryFieldError: null,
        countryStateFieldError: null,
        isSubmitting: false,
      );

  bool get canSubmit =>
      !isSubmitting &&
      pickedCountry != null &&
      pickedCountryState != null &&
      countryFieldError == null &&
      countryStateFieldError == null;
}
