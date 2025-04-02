import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

class PredictionProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  double? _prediction;
  String? _error;

  bool get isLoading => _isLoading;
  double? get prediction => _prediction;
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
    _isLoading = true;
    _error = null;
    _prediction = null;
    notifyListeners();

    try {
      _prediction = await _apiService.predictYield(
        area: area,
        country: country,
        product: product,
        production: production,
        province: province,
        seasonName: seasonName,
        timeToHarvest: timeToHarvest,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearPrediction() {
    _prediction = null;
    _error = null;
    notifyListeners();
  }
} 