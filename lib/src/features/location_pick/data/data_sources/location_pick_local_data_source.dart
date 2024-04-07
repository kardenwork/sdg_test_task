import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';

abstract interface class LocationPickLocalDataSource {
  Future<List<Country>?> getCountries();

  Future<List<CountryState>?> getCountryStates(Country country);

  Future<void> saveCountries(List<Country> countries);

  Future<void> saveCountryStates(Country country, List<CountryState> states);

  Future<void> clearCountries();

  Future<void> clearAllStates();
}

final class RamLocationPickLocalDataSourceImpl
    implements LocationPickLocalDataSource {
  List<Country>? _countriesCache;
  Map<int, List<CountryState>>? _statesCache;

  @override
  Future<void> clearAllStates() {
    return Future.sync(() => _statesCache = null);
  }

  @override
  Future<void> clearCountries() {
    return Future.sync(() => _countriesCache = null);
  }

  @override
  Future<List<Country>?> getCountries() {
    return Future.sync(() => _countriesCache);
  }

  @override
  Future<List<CountryState>?> getCountryStates(Country country) {
    return Future.sync(() => _statesCache?[country.id]);
  }

  @override
  Future<void> saveCountries(List<Country> countries) {
    return Future.sync(() => _countriesCache = countries);
  }

  @override
  Future<void> saveCountryStates(Country country, List<CountryState> states) {
    return Future.sync(
      () {
        final cache = _statesCache ?? {};
        cache[country.id] = states;
        _statesCache = cache;
      },
    );
  }
}
