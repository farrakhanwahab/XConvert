import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class EnergyConverterScreen extends BaseConverterScreen {
  const EnergyConverterScreen({super.key})
      : super(
          title: 'Energy Converter',
          icon: Icons.bolt,
          iconColor: Colors.teal,
        );

  @override
  State<EnergyConverterScreen> createState() => _EnergyConverterScreenState();
}

class _EnergyConverterScreenState extends BaseConverterScreenState<EnergyConverterScreen> {
  @override
  List<String> get units => ConverterService.getEnergyUnits();

  @override
  String getToUnitFullName() => ConverterService.getEnergyFullName(toUnit);

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
      final converted = ConverterService.convertEnergy(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 