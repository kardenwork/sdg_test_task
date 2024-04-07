import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';

abstract interface class LocationPickRepository {
  Future<List<Country>> getCountries();

  Future<List<CountryState>> getCountryStates(Country country);
}

final class FakeLocationPickRepository implements LocationPickRepository {
  @override
  Future<List<Country>> getCountries() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => const [
        Country(id: 1, name: 'Africa'),
        Country(id: 2, name: 'America'),
        Country(id: 3, name: 'Australia'),
        Country(id: 4, name: 'Japan'),
        Country(id: 5, name: 'China'),
      ],
    );
  }

  @override
  Future<List<CountryState>> getCountryStates(Country country) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => List.generate(
        5,
        (index) => CountryState(
          id: index + 1,
          name: '${country.name} State ${index + 1}',
        ),
      ),
    );
  }
}
