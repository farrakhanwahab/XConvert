import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class WeightConverterScreen extends BaseConverterScreen {
  const WeightConverterScreen({super.key})
      : super(
          title: 'Weight Converter',
          icon: Icons.monitor_weight,
          iconColor: Colors.brown,
        );

  @override
  State<WeightConverterScreen> createState() => _WeightConverterScreenState();
}

class _WeightConverterScreenState extends BaseConverterScreenState<WeightConverterScreen> {
  @override
  List<String> get units => ConverterService.getWeightUnits();

  @override
  String getToUnitFullName() => ConverterService.getWeightFullName(toUnit);

  @override
  Future<void> calculateResult() async {
    if (input.isEmpty) {
      setState(() => result = '');
      return;
    }
    final value = double.tryParse(input);
    if (value == null) {
      setState(() => result = '');
      return;
    }
    try {
      final converted = ConverterService.convertWeight(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 