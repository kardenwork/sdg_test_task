part of 'location_pick_bloc.dart';

sealed class LocationPickUiCommand extends Equatable {
  const LocationPickUiCommand();

  @override
  List<Object?> get props => [];
}

final class LocationPickSuccessUiCommand extends LocationPickUiCommand {
  const LocationPickSuccessUiCommand(this.country, this.countryState);

  final Country country;
  final CountryState countryState;

  @override
  List<Object?> get props => [country, countryState];
}

final class LocationPickErrorUiCommand extends LocationPickUiCommand {}
