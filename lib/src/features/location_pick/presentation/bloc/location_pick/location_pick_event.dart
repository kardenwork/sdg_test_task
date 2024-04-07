part of 'location_pick_bloc.dart';

sealed class LocationPickEvent {}

final class LocationPickCountryPickedEvent implements LocationPickEvent {
  const LocationPickCountryPickedEvent(this.country);

  final Country? country;
}

final class LocationPickCountryStatePickedEvent implements LocationPickEvent {
  const LocationPickCountryStatePickedEvent(this.countryState);

  final CountryState? countryState;
}

final class LocationPickSubmitRequestedEvent implements LocationPickEvent {}
