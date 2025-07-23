import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class LengthConverterScreen extends BaseConverterScreen {
  const LengthConverterScreen({super.key})
      : super(
          title: 'Length Converter',
          icon: Icons.straighten,
          iconColor: Colors.blue,
        );

  @override
  State<LengthConverterScreen> createState() => _LengthConverterScreenState();
}

class _LengthConverterScreenState extends BaseConverterScreenState<LengthConverterScreen> {
  @override
  List<String> get units => ConverterService.getLengthUnits();

  @override
  String getToUnitFullName() => ConverterService.getLengthFullName(toUnit);

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
      final converted = ConverterService.convertLength(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 