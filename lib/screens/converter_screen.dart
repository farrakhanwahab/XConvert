/*
// DEPRECATED: This screen is no longer used. See the new modular converter screens.

import 'package:flutter/material.dart';
import '../widgets/x_input.dart';
import '../widgets/x_dropdown.dart';
import '../app_theme.dart';
import '../services/currency_service.dart';
import '../services/converter_service.dart';

class ConverterScreen extends StatefulWidget {
  final String type;
  final String title;
  final IconData icon;
  final Color iconColor;

  const ConverterScreen({
    super.key,
    required this.type,
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  String fromUnit = '';
  String toUnit = '';
  String input = '';
  String result = '';
  late final TextEditingController inputController;

  // Currency state
  Map<String, double>? rates;
  String? error;

  // Example unit lists (replace with real data/logic)
  List<String> get units {
    switch (widget.type) {
      case 'currency':
        if (rates != null && rates!.isNotEmpty) {
          // Create a sorted list of unique currencies
          final allCurrencies = {'USD', ...rates!.keys};
          return allCurrencies.toList()..sort();
        }
        return ['USD']; // Only show USD until rates are loaded
      case 'length':
        return ConverterService.getLengthUnits();
      case 'weight':
        return ConverterService.getWeightUnits();
      case 'temperature':
        return ConverterService.getTemperatureUnits();
      default:
        return [];
    }
  }

  String getFormula() {
    switch (widget.type) {
      case 'currency':
        return 'value × (rate of $toUnit)';
      case 'length':
        return 'value × (from factor) / (to factor)';
      case 'weight':
        return 'value × (from factor) / (to factor)';
      case 'temperature':
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
      default:
        return '';
    }
  }

  void showFormulaDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Conversion Formula'),
        content: Text(getFormula()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
    // Set initial values based on type
    if (widget.type == 'currency') {
      // Start with just USD until rates load
      fromUnit = 'USD';
      toUnit = 'USD';
      // Fetch rates in background
      WidgetsBinding.instance.addPostFrameCallback((_) => fetchRates());
    } else if (units.isNotEmpty) {
      // For non-currency converters
      fromUnit = units[0];
      toUnit = units.length > 1 ? units[1] : units[0];
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  Future<void> fetchRates() async {
    try {
      final fetched = await CurrencyService.fetchRates(fromUnit);
      if (!mounted) return;
      
      setState(() {
        rates = fetched;
        if (rates == null || rates!.isEmpty) {
          error = 'No currencies available.';
        } else {
          // Set initial 'to' currency once rates are loaded
          toUnit = rates!.keys.firstWhere(
            (rate) => rate != fromUnit,
            orElse: () => rates!.keys.first
          );
          if (input.isNotEmpty) {
            calculateResult();
          }
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = 'Failed to fetch rates.';
      });
    }
  }

  void calculateResult() {
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
      double converted;
      switch (widget.type) {
        case 'currency':
          if (rates == null || !rates!.containsKey(toUnit)) {
            setState(() => result = '');
            return;
          }
          converted = ConverterService.convertCurrency(value, rates![toUnit]!);
          break;

        case 'length':
          converted = ConverterService.convertLength(value, fromUnit, toUnit);
          break;

        case 'weight':
          converted = ConverterService.convertWeight(value, fromUnit, toUnit);
          break;

        case 'temperature':
          converted = ConverterService.convertTemperature(value, fromUnit, toUnit);
          break;

        default:
          setState(() => result = '');
          return;
      }

      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.iconColor.withAlpha(33),
              child: Icon(widget.icon, color: widget.iconColor),
            ),
            const SizedBox(width: 12),
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Show formula',
            onPressed: showFormulaDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.type == 'currency' && error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Center(
                  child: Text(
                    error!,
                    style: TextStyle(color: scheme.error, fontSize: 16),
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: XDropdown<String>(
                    label: 'From',
                    value: fromUnit,
                    items: units
                        .map((u) => DropdownMenuItem(
                              value: u,
                              child: Text(u, style: Theme.of(context).textTheme.bodyLarge),
                            ))
                        .toList(),
                    onChanged: (val) async {
                      if (val == null) return;
                      setState(() => fromUnit = val);
                      if (widget.type == 'currency') {
                        await fetchRates();
                      } else {
                        calculateResult();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.swap_horiz, color: scheme.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: XDropdown<String>(
                    label: 'To',
                    value: toUnit,
                    items: units
                        .map((u) => DropdownMenuItem(
                              value: u,
                              child: Text(u, style: Theme.of(context).textTheme.bodyLarge),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val == null) return;
                      setState(() => toUnit = val);
                      calculateResult();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            XInput(
              label: 'Enter value',
              controller: inputController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (val) {
                // Only allow digits and one decimal point
                if (val.isEmpty || RegExp(r'^\d*\.?\d*$').hasMatch(val)) {
                  setState(() => input = val);
                  calculateResult();
                }
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Result',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: scheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: scheme.outline.withAlpha(33)),
              ),
              child: Text(
                result.isEmpty ? '--' : result,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/ 