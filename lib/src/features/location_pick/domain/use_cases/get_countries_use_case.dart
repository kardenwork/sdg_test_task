import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/repositories/location_pick_repository.dart';

abstract interface class GetCountriesUseCase {
  Future<List<Country>> call();
}

final class GetCountriesUseCaseImpl implements GetCountriesUseCase {
  const GetCountriesUseCaseImpl({
    required this.repository,
  });

  final LocationPickRepository repository;

  @override
  Future<List<Country>> call() {
    return repository.getCountries();
  }
}
