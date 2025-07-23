import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';

class VolumeConverterScreen extends BaseConverterScreen {
  const VolumeConverterScreen({super.key})
      : super(
          title: 'Volume Converter',
          icon: Icons.local_drink,
          iconColor: Colors.cyan,
        );

  @override
  State<VolumeConverterScreen> createState() => _VolumeConverterScreenState();
}

class _VolumeConverterScreenState extends BaseConverterScreenState<VolumeConverterScreen> {
  @override
  List<String> get units => ConverterService.getVolumeUnits();

  @override
  String getToUnitFullName() => ConverterService.getVolumeFullName(toUnit);

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
      final converted = ConverterService.convertVolume(value, fromUnit, toUnit);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }
} 