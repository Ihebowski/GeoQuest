import 'package:geoquest/src/models/contry_model.dart';
import 'package:geoquest/src/services/country_service.dart';

class CountryRepository {
  final CountryService _countryService = CountryService();

  Future<List<CountryModel>> getCountries() async {
    try {
      List<dynamic> data = await _countryService.fetchCountries();
      return data.map((countryJson) => CountryModel.fromJson(countryJson)).toList();
    } catch (e) {
      throw Exception('Error fetching countries: $e');
    }
  }
}
