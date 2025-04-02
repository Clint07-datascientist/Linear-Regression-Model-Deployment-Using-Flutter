import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/prediction_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PredictionProvider(),
      child: MaterialApp(
        title: 'Crop Yield Predictor',
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
} 