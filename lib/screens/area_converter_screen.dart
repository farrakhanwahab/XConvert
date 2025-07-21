import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class AreaConverterScreen extends BaseConverterScreen {
  const AreaConverterScreen({super.key})
      : super(
          title: 'Area Converter',
          icon: Icons.crop_square,
          iconColor: Colors.teal,
        );

  @override
  State<AreaConverterScreen> createState() => _AreaConverterScreenState();
}

class _AreaConverterScreenState extends BaseConverterScreenState<AreaConverterScreen> {
  @override
  List<String> get units => ConverterService.getAreaUnits();

  @override
  String getToUnitFullName() => ConverterService.getAreaFullName(toUnit);

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
      final converted = ConverterService.convertArea(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 