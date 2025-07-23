import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class SpeedConverterScreen extends BaseConverterScreen {
  const SpeedConverterScreen({super.key})
      : super(
          title: 'Speed Converter',
          icon: Icons.speed,
          iconColor: Colors.lightBlue,
        );

  @override
  State<SpeedConverterScreen> createState() => _SpeedConverterScreenState();
}

class _SpeedConverterScreenState extends BaseConverterScreenState<SpeedConverterScreen> {
  @override
  List<String> get units => ConverterService.getSpeedUnits();

  @override
  String getToUnitFullName() => ConverterService.getSpeedFullName(toUnit);

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
      final converted = ConverterService.convertSpeed(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 