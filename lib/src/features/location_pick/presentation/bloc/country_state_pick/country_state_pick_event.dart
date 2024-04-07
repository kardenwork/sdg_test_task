part of 'country_state_pick_bloc.dart';

sealed class CountryStatePickEvent {}

final class CountryStatePickCountryChangedEvent
    implements CountryStatePickEvent {
  const CountryStatePickCountryChangedEvent(this.country);

  final Country? country;
}

final class CountryStatePickCountryStatePickedEvent
    implements CountryStatePickEvent {
  const CountryStatePickCountryStatePickedEvent(this.countryState);

  final CountryState? countryState;
}

final class CountryStatePickRefreshRequestedEvent
    implements CountryStatePickEvent {}
