import 'package:flutter/material.dart';
import 'base_converter_screen.dart';
import '../services/converter_service.dart';
import '../services/currency_service.dart';

class CurrencyConverterScreen extends BaseConverterScreen {
  const CurrencyConverterScreen({super.key})
      : super(
          title: 'Currency Converter',
          icon: Icons.currency_exchange,
          iconColor: Colors.orange,
        );

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends BaseConverterScreenState<CurrencyConverterScreen> {
  Map<String, double>? rates;
  String? error;

  @override
  List<String> get units {
    if (rates != null && rates!.isNotEmpty) {
      final allCurrencies = {'USD', ...rates!.keys};
      return allCurrencies.toList()..sort();
    }
    return ['USD'];
  }

  @override
  String getToUnitFullName() => toUnit;

  @override
  void initState() {
    fromUnit = 'USD';
    toUnit = 'USD';
    super.initState();
    // Fetch rates in background
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchRates());
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

  String getFormula() => 'value × (rate of $toUnit)';

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
      if (rates == null || !rates!.containsKey(toUnit)) {
        setState(() => result = '');
        return;
      }
      final converted = ConverterService.convertCurrency(value, rates![toUnit]!);
      setState(() {
        result = ConverterService.formatResult(converted);
      });
    } catch (e) {
      setState(() => result = 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseWidget = super.build(context) as Scaffold;
    if (error != null) {
      // Insert error message at the top of the body
      return Scaffold(
        appBar: baseWidget.appBar,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: Text(
                  error!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            if (baseWidget.body != null)
              Expanded(child: baseWidget.body!),
          ],
        ),
      );
    }
    return baseWidget;
  }
} 