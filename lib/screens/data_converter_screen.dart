import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class DataConverterScreen extends BaseConverterScreen {
  const DataConverterScreen({super.key})
      : super(
          title: 'Data Converter',
          icon: Icons.sd_storage,
          iconColor: Colors.grey,
        );

  @override
  State<DataConverterScreen> createState() => _DataConverterScreenState();
}

class _DataConverterScreenState extends BaseConverterScreenState<DataConverterScreen> {
  @override
  List<String> get units => ConverterService.getDataUnits();

  @override
  String getToUnitFullName() => ConverterService.getDataFullName(toUnit);

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
      final converted = ConverterService.convertData(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 