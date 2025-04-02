import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://linear-regression-model-deployment-using-aak4.onrender.com';
  
  Future<double> predictYield({
    required double area,
    required String country,
    required String product,
    required double production,
    required String province,
    required String seasonName,
    required double timeToHarvest,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'area': area,
          'country': country,
          'product': product,
          'production': production,
          'province': province,
          'season_name': seasonName,
          'time_to_harvest': timeToHarvest,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['prediction'].toDouble();
      } else {
        throw Exception('Failed to get prediction: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }
} 