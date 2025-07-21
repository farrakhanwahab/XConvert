import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class PowerConverterScreen extends BaseConverterScreen {
  const PowerConverterScreen({super.key})
      : super(
          title: 'Power Converter',
          icon: Icons.flash_on,
          iconColor: Colors.redAccent,
        );

  @override
  State<PowerConverterScreen> createState() => _PowerConverterScreenState();
}

class _PowerConverterScreenState extends BaseConverterScreenState<PowerConverterScreen> {
  @override
  List<String> get units => ConverterService.getPowerUnits();

  @override
  String getToUnitFullName() => ConverterService.getPowerFullName(toUnit);

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
      final converted = ConverterService.convertPower(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 