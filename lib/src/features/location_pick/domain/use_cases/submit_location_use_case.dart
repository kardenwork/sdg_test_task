import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/repositories/location_pick_repository.dart';

abstract interface class SubmitLocationUseCase {
  Future<void> call(Country country, CountryState countryState);
}

final class SubmitLocationUseCaseImpl implements SubmitLocationUseCase {
  const SubmitLocationUseCaseImpl({
    required this.repository,
  });

  final LocationPickRepository repository;

  @override
  Future<void> call(Country country, CountryState countryState) {
    return Future.delayed(const Duration(seconds: 1));
  }
}
