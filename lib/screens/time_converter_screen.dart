import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class TimeConverterScreen extends BaseConverterScreen {
  const TimeConverterScreen({super.key})
      : super(
          title: 'Time Converter',
          icon: Icons.access_time,
          iconColor: Colors.deepOrangeAccent,
        );

  @override
  State<TimeConverterScreen> createState() => _TimeConverterScreenState();
}

class _TimeConverterScreenState extends BaseConverterScreenState<TimeConverterScreen> {
  @override
  List<String> get units => ConverterService.getTimeUnits();

  @override
  String getToUnitFullName() => ConverterService.getTimeFullName(toUnit);

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
      final converted = ConverterService.convertTime(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 