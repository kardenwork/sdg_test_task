part of 'country_pick_bloc.dart';

sealed class CountryPickEvent {}

final class CountryPickLoadRequestedEvent implements CountryPickEvent {}

final class CountryPickCountryPickedEvent implements CountryPickEvent {
  const CountryPickCountryPickedEvent(this.country);

  final Country? country;
}
