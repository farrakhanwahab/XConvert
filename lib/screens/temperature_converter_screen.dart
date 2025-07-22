import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class TemperatureConverterScreen extends BaseConverterScreen {
  const TemperatureConverterScreen({super.key})
      : super(
          title: 'Temperature Converter',
          icon: Icons.thermostat,
          iconColor: Colors.deepOrangeAccent,
        );

  @override
  State<TemperatureConverterScreen> createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends BaseConverterScreenState<TemperatureConverterScreen> {
  @override
  List<String> get units => ConverterService.getTemperatureUnits();

  @override
  String getToUnitFullName() {
    switch (toUnit) {
      case 'Celsius':
        return 'Celsius';
      case 'Fahrenheit':
        return 'Fahrenheit';
      case 'Kelvin':
        return 'Kelvin';
      case 'Rankine':
        return 'Rankine';
      default:
        return toUnit;
    }
  }

  String getFormula() {
    if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
      return 'C × 9/5 + 32';
    } else if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
      return '(F - 32) × 5/9';
    } else if (fromUnit == 'Celsius' && toUnit == 'Kelvin') {
      return 'C + 273.15';
    } else if (fromUnit == 'Kelvin' && toUnit == 'Celsius') {
      return 'K - 273.15';
    } else if (fromUnit == 'Fahrenheit' && toUnit == 'Kelvin') {
      return '(F - 32) × 5/9 + 273.15';
    } else if (fromUnit == 'Kelvin' && toUnit == 'Fahrenheit') {
      return '(K - 273.15) × 9/5 + 32';
    } else if (fromUnit == 'Celsius' && toUnit == 'Rankine') {
      return '(C + 273.15) × 9/5';
    } else if (fromUnit == 'Rankine' && toUnit == 'Celsius') {
      return '(R - 491.67) × 5/9';
    } else {
      return 'Standard temperature conversion';
    }
  }
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
      final converted = ConverterService.convertTemperature(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 