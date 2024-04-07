import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';

final class ApiCountryStateConverter {
  const ApiCountryStateConverter();

  CountryState fromJson(dynamic json) {
    if (json
        case {
          'id': int id,
          'value': String name,
        }) {
      return CountryState(id: id, name: name);
    } else {
      throw Exception('Could not parse CountryState from $json');
    }
  }

  List<CountryState> listFromJson(List jsonList) {
    return jsonList.map((e) => fromJson(e)).toList();
  }
}
