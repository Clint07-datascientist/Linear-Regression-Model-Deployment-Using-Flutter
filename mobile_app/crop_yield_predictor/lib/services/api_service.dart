import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://linear-regression-model-deployment-using-aak4.onrender.com';
  static const Duration timeoutDuration = Duration(seconds: 30);
  
  // For local development, uncomment one of these lines:
  // static const String baseUrl = 'http://10.0.2.2:8000'; // For Android emulator
  // static const String baseUrl = 'http://localhost:8000'; // For iOS simulator

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
      ).timeout(
        timeoutDuration,
        onTimeout: () {
          throw TimeoutException('Request timed out after ${timeoutDuration.inSeconds} seconds');
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return data['predicted_yield'].toDouble();
        } else {
          throw Exception(data['detail'] ?? 'Unknown error occurred');
        }
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['detail'] ?? 'Failed to get prediction: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timed out. Please check your internet connection and try again.');
    } on FormatException {
      throw Exception('Invalid response from server. Please try again later.');
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }
} 