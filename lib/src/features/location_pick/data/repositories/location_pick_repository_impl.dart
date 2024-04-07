import 'package:sdg_test_task/src/features/location_pick/data/data_sources/location_pick_local_data_source.dart';
import 'package:sdg_test_task/src/features/location_pick/data/data_sources/location_pick_remote_data_source.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/repositories/location_pick_repository.dart';

final class LocationPickRepositoryImpl implements LocationPickRepository {
  const LocationPickRepositoryImpl({
    required LocationPickRemoteDataSource remoteDataSource,
    required LocationPickLocalDataSource localDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  final LocationPickRemoteDataSource _remoteDataSource;
  final LocationPickLocalDataSource _localDataSource;

  @override
  Future<List<Country>> getCountries() async {
    List<Country>? countries = await _localDataSource.getCountries();

    if (countries == null) {
      countries = await _remoteDataSource.fetchCountries();
      _localDataSource.saveCountries(countries);
    }

    return countries;
  }

  @override
  Future<List<CountryState>> getCountryStates(Country country) async {
    List<CountryState>? countryStates =
        await _localDataSource.getCountryStates(country);

    if (countryStates == null) {
      countryStates = await _remoteDataSource.fetchCountryStates(country.id);
      _localDataSource.saveCountryStates(country, countryStates);
    }

    return countryStates;
  }
}
