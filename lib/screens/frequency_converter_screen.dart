import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class FrequencyConverterScreen extends BaseConverterScreen {
  const FrequencyConverterScreen({super.key})
      : super(
          title: 'Frequency Converter',
          icon: Icons.waves,
          iconColor: Colors.pink,
        );

  @override
  State<FrequencyConverterScreen> createState() => _FrequencyConverterScreenState();
}

class _FrequencyConverterScreenState extends BaseConverterScreenState<FrequencyConverterScreen> {
  @override
  List<String> get units => ConverterService.getFrequencyUnits();

  @override
  String getToUnitFullName() => ConverterService.getFrequencyFullName(toUnit);

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
      final converted = ConverterService.convertFrequency(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 