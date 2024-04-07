part of 'country_pick_bloc.dart';

sealed class CountryPickState extends Equatable {
  const CountryPickState();

  @override
  List<Object?> get props => [];
}

final class CountryPickLoadingState extends CountryPickState {
  const CountryPickLoadingState();
}

final class CountryPickErrorState extends CountryPickState {
  const CountryPickErrorState();
}

final class CountryPickLoadedState extends CountryPickState {
  const CountryPickLoadedState({
    required this.countries,
    required this.pickedCountry,
  });

  final List<Country> countries;
  final Country? pickedCountry;

  @override
  List<Object?> get props => [countries, pickedCountry];
}
