import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const defaultBase = 'USD'; // Default base currency

  static Future<Map<String, double>> fetchRates(String? base) async {
    try {
      // Validate and set default base currency if needed
      final validBase = (base?.isNotEmpty == true) ? base! : defaultBase;
      
      final url = Uri.parse('http://api.frankfurter.app/latest?from=$validBase');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Check if we have rates in the response
        if (data.containsKey('rates')) {
          final rates = Map<String, dynamic>.from(data['rates']);
          if (rates.isNotEmpty) {
            return rates.map((k, v) => MapEntry(k, (v as num).toDouble()));
          }
        }
        throw Exception('No rates found in response');
      } else {
        throw Exception('API Error: Status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getLatestRates(String base) async {
    try {
      final url = Uri.parse('http://api.frankfurter.app/latest?from=$base');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load currency rates');
      }
    } catch (e) {
      throw Exception('Failed to load currency rates');
    }
  }

  Future<Map<String, dynamic>> getHistoricalRates({
    required DateTime startDate,
    required DateTime endDate,
    required String from,
    required String to,
  }) async {
    final uri = Uri.https(
      'api.frankfurter.app',
      '/${startDate.toIso8601String().split('T').first}..${endDate.toIso8601String().split('T').first}',
      {'from': from, 'to': to},
    );
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load historical rates');
      }
    } catch (e) {
      throw Exception('Failed to load historical rates');
    }
  }
} 