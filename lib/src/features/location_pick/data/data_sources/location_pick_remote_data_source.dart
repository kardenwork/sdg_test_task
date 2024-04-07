import 'package:dio/dio.dart';
import 'package:sdg_test_task/src/core/api/api_config.dart';
import 'package:sdg_test_task/src/features/location_pick/data/converters/api_country_converter.dart';
import 'package:sdg_test_task/src/features/location_pick/data/converters/api_country_state_converter.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';

abstract interface class LocationPickRemoteDataSource {
  Future<List<Country>> fetchCountries();

  Future<List<CountryState>> fetchCountryStates(int countryId);
}

final class ApiLocationPickRemoteDataSourceImpl
    implements LocationPickRemoteDataSource {
  const ApiLocationPickRemoteDataSourceImpl({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;
  final ApiCountryConverter _countryConverter = const ApiCountryConverter();
  final ApiCountryStateConverter _countryStateConverter =
      const ApiCountryStateConverter();

  @override
  Future<List<Country>> fetchCountries() async {
    final response = await _dio.get(ApiConfig.countriesPath);

    if (response.statusCode != 200 || response.data is! List) {
      throw Exception(
        'Received incorrect/error response from ${ApiConfig.countriesPath}',
      );
    }

    return _countryConverter.listFromJson(response.data);
  }

  @override
  Future<List<CountryState>> fetchCountryStates(int countryId) async {
    final url = ApiConfig.countryStatesPath(countryId);
    final response = await _dio.get(url);

    if (response.statusCode != 200 || response.data is! List) {
      throw Exception(
        'Received incorrect/error response from ${ApiConfig.countriesPath}',
      );
    }

    return _countryStateConverter.listFromJson(response.data);
  }
}
