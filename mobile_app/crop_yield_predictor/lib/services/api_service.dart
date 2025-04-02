import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/prediction_input.dart';

class ApiService {
  // Update this URL to your Render deployment URL
  static const String baseUrl = 'https://your-render-app-name.onrender.com';
  
  // For local development, uncomment one of these lines:
  // static const String baseUrl = 'http://10.0.2.2:8000'; // For Android emulator
  // static const String baseUrl = 'http://localhost:8000'; // For iOS simulator

  Future<Map<String, dynamic>> getPrediction(PredictionInput input) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(input.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get prediction: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }
} 