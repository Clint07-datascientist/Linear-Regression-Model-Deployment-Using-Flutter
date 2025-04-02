import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

class PredictionProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  double? _predictedYield;
  bool _isLoading = false;
  String? _error;

  double? get predictedYield => _predictedYield;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> predictYield({
    required double area,
    required String country,
    required String product,
    required double production,
    required String province,
    required String seasonName,
    required double timeToHarvest,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      _predictedYield = null;
      notifyListeners();

      final prediction = await _apiService.predictYield(
        area: area,
        country: country,
        product: product,
        production: production,
        province: province,
        seasonName: seasonName,
        timeToHarvest: timeToHarvest,
      );

      _predictedYield = prediction;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _predictedYield = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearPrediction() {
    _predictedYield = null;
    _error = null;
    notifyListeners();
  }
} 