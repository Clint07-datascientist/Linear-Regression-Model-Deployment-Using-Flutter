import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prediction_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _areaController = TextEditingController();
  final _countryController = TextEditingController();
  final _productController = TextEditingController();
  final _productionController = TextEditingController();
  final _provinceController = TextEditingController();
  final _seasonNameController = TextEditingController();
  final _timeToHarvestController = TextEditingController();

  @override
  void dispose() {
    _areaController.dispose();
    _countryController.dispose();
    _productController.dispose();
    _productionController.dispose();
    _provinceController.dispose();
    _seasonNameController.dispose();
    _timeToHarvestController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await context.read<PredictionProvider>().predictYield(
        area: double.parse(_areaController.text),
        country: _countryController.text,
        product: _productController.text,
        production: double.parse(_productionController.text),
        province: _provinceController.text,
        seasonName: _seasonNameController.text,
        timeToHarvest: double.parse(_timeToHarvestController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Yield Predictor'),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade700,
              Colors.green.shade50,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.eco,
                          size: 50,
                          color: Colors.green.shade700,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Enter Crop Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Fill in the information below to get your prediction',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Form Fields
                _buildTextField(
                  controller: _areaController,
                  label: 'Area (hectares)',
                  hint: 'Enter area in hectares',
                  icon: Icons.landscape,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _countryController,
                  label: 'Country',
                  hint: 'Enter country name',
                  icon: Icons.public,
                  isNumeric: false,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _productController,
                  label: 'Product',
                  hint: 'Enter product name',
                  icon: Icons.agriculture,
                  isNumeric: false,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _productionController,
                  label: 'Production (tons)',
                  hint: 'Enter production in tons',
                  icon: Icons.production_quantity_limits,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _provinceController,
                  label: 'Province',
                  hint: 'Enter province name',
                  icon: Icons.location_city,
                  isNumeric: false,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _seasonNameController,
                  label: 'Season Name',
                  hint: 'Enter season name',
                  icon: Icons.wb_sunny,
                  isNumeric: false,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _timeToHarvestController,
                  label: 'Time to Harvest (days)',
                  hint: 'Enter time to harvest in days',
                  icon: Icons.timer,
                ),
                const SizedBox(height: 24),
                // Prediction Button and Result
                Consumer<PredictionProvider>(
                  builder: (context, predictionProvider, child) {
                    return Column(
                      children: [
                        // Prediction Button
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Get Prediction',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Prediction Result
                        if (predictionProvider.isLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 16),
                                  Text(
                                    'Getting prediction...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (predictionProvider.error != null)
                          Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red.shade700,
                                  size: 48,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  predictionProvider.error!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    predictionProvider.clearPrediction();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade700,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Try Again'),
                                ),
                              ],
                            ),
                          )
                        else if (predictionProvider.predictedYield != null)
                          Column(
                            children: [
                              const SizedBox(height: 24),
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.analytics,
                                        size: 50,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Predicted Yield',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${predictionProvider.predictedYield!.toStringAsFixed(2)} tons',
                                        style: const TextStyle(
                                          fontSize: 36,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isNumeric = true,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.green.shade700),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          if (isNumeric && double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }
} 