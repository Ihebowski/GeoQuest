import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryService {
  final String _url = 'https://restcountries.com/v3.1/all';

  Future<List<dynamic>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load country data');
      }
    } catch (e) {
      throw Exception('Error fetching countries: $e');
    }
  }
}
