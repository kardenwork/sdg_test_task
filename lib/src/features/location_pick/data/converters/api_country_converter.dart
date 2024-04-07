import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';

final class ApiCountryConverter {
  const ApiCountryConverter();

  Country fromJson(dynamic json) {
    if (json
        case {
          'id': int id,
          'value': String name,
        }) {
      return Country(id: id, name: name);
    } else {
      throw Exception('Could not parse Country from $json');
    }
  }

  List<Country> listFromJson(List json) {
    return json.map((e) => fromJson(e)).toList();
  }
}
