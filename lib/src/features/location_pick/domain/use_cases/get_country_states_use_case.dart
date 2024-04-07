import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/repositories/location_pick_repository.dart';

abstract interface class GetCountryStatesUseCase {
  Future<List<CountryState>> call(Country country);
}

final class GetCountryStatesUseCaseImpl implements GetCountryStatesUseCase {
  const GetCountryStatesUseCaseImpl({
    required this.repository,
  });

  final LocationPickRepository repository;

  @override
  Future<List<CountryState>> call(Country country) {
    return repository.getCountryStates(country);
  }
}
