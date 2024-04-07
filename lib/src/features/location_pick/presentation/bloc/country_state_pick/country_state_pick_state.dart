part of 'country_state_pick_bloc.dart';

sealed class CountryStatePickState extends Equatable {
  const CountryStatePickState({required this.country});

  final Country? country;

  @override
  List<Object?> get props => [country];
}

final class CountryStatePickInitialState extends CountryStatePickState {
  const CountryStatePickInitialState() : super(country: null);
}

final class CountryStatePickLoadingState extends CountryStatePickState {
  const CountryStatePickLoadingState({
    required super.country,
  });
}

final class CountryStatePickErrorState extends CountryStatePickState {
  const CountryStatePickErrorState({
    required super.country,
  });
}

final class CountryStatePickLoadedState extends CountryStatePickState {
  const CountryStatePickLoadedState({
    required this.countryStates,
    required this.pickedCountryState,
    required super.country,
  });

  final List<CountryState> countryStates;
  final CountryState? pickedCountryState;

  @override
  List<Object?> get props => [
        ...super.props,
        countryStates,
        pickedCountryState,
      ];
}
