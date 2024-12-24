import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CountryService {
  static const int _timeout = 3000;
  static const int _maxRetries = 3;

  final String baseUrl = dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:3000/countries';

  Future<List<dynamic>> fetchCountries() async {
    int retryCount = 0;

    while (retryCount < _maxRetries) {
      try {
        final Uri url = Uri.parse('$baseUrl/all');
        final response =
        await http.get(url).timeout(const Duration(seconds: _timeout));

        if (response.statusCode == 200) {
          return json.decode(response.body);
        } else if (response.statusCode == 404) {
          throw Exception('Countries data not found');
        } else if (response.statusCode >= 500) {
          throw Exception('Server error: ${response.statusCode}');
        } else {
          throw Exception(
              'Failed to load country data: ${response.statusCode}');
        }
      } on TimeoutException {
        retryCount++;
        if (retryCount == _maxRetries) {
          throw Exception('Connection timed out after $_maxRetries attempts');
        }
        await Future.delayed(Duration(seconds: retryCount));
      } on http.ClientException catch (e) {
        retryCount++;
        if (retryCount == _maxRetries) {
          throw Exception(
              'Network error after $_maxRetries attempts: ${e.message}');
        }
        await Future.delayed(Duration(seconds: retryCount));
      } catch (e) {
        if (e is Exception) {
          rethrow;
        }
        throw Exception('Unexpected error: $e');
      }
    }
    throw Exception('Failed to fetch countries after $_maxRetries attempts');
  }
}
