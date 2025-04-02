class PredictionInput {
  final String country;
  final String province;
  final String product;
  final String seasonName;
  final int timeToHarvest;
  final double area;
  final double production;

  PredictionInput({
    required this.country,
    required this.province,
    required this.product,
    required this.seasonName,
    required this.timeToHarvest,
    required this.area,
    required this.production,
  });

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'province': province,
      'product': product,
      'season_name': seasonName,
      'time_to_harvest': timeToHarvest,
      'area': area,
      'production': production,
    };
  }
} 