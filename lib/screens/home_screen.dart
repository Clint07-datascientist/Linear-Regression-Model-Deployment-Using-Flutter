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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _areaController,
                label: 'Area (hectares)',
                hint: 'Enter area in hectares',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _countryController,
                label: 'Country',
                hint: 'Enter country name',
                isNumeric: false,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _productController,
                label: 'Product',
                hint: 'Enter product name',
                isNumeric: false,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _productionController,
                label: 'Production (tons)',
                hint: 'Enter production in tons',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _provinceController,
                label: 'Province',
                hint: 'Enter province name',
                isNumeric: false,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _seasonNameController,
                label: 'Season Name',
                hint: 'Enter season name',
                isNumeric: false,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _timeToHarvestController,
                label: 'Time to Harvest (days)',
                hint: 'Enter time to harvest in days',
              ),
              const SizedBox(height: 24),
              Consumer<PredictionProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Predict Yield'),
                      ),
                      if (provider.error != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          provider.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                      if (provider.prediction != null) ...[
                        const SizedBox(height: 16),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Predicted Yield',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${provider.prediction!.toStringAsFixed(2)} tons',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isNumeric = true,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
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
    );
  }
} 