// lib/screens/history_chart_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:xconvert/services/currency_service.dart';

class HistoryChartScreen extends StatefulWidget {
  const HistoryChartScreen({super.key});

  @override
  State<HistoryChartScreen> createState() => _HistoryChartScreenState();
}

class _HistoryChartScreenState extends State<HistoryChartScreen> {
  final CurrencyService _currencyService = CurrencyService();
  List<String> _currencies = ['USD', 'EUR', 'JPY', 'GBP'];
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  Map<String, dynamic> _historicalData = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCurrencies();
    _fetchHistoricalData();
  }

  Future<void> _fetchCurrencies() async {
    try {
      final data = await _currencyService.getLatestRates('USD');
      setState(() {
        _currencies = (data['rates'] as Map<String, dynamic>).keys.toList();
        _currencies.add('USD');
        _currencies.sort();
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _fetchHistoricalData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final data = await _currencyService.getHistoricalRates(
        startDate: _startDate,
        endDate: _endDate,
        from: _fromCurrency,
        to: _toCurrency,
      );
      setState(() {
        _historicalData = data['rates'];
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: _fromCurrency,
                items: _currencies
                    .map((c) => DropdownMenuItem(value: c, child: Builder(
                      builder: (context) => Text(c, style: Theme.of(context).textTheme.bodyMedium),
                    )))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _fromCurrency = val;
                    });
                  }
                },
              ),
              const Icon(Icons.arrow_forward),
              DropdownButton<String>(
                value: _toCurrency,
                items: _currencies
                    .map((c) => DropdownMenuItem(value: c, child: Builder(
                      builder: (context) => Text(c, style: Theme.of(context).textTheme.bodyMedium),
                    )))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _toCurrency = val;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _startDate,
                    firstDate: DateTime(2000),
                    lastDate: _endDate,
                  );
                  if (picked != null) {
                    setState(() {
                      _startDate = picked;
                    });
                  }
                },
                child: Text(
                  'From: ${_startDate.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _endDate,
                    firstDate: _startDate,
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _endDate = picked;
                    });
                  }
                },
                child: Text(
                  'To: ${_endDate.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _fetchHistoricalData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Get History'),
          ),
          const SizedBox(height: 24),
          _isLoading
              ? const CircularProgressIndicator()
              : _historicalData.isEmpty
                  ? const Text('No data available')
                  : Expanded(
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [_lineChartBarData()],
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles:false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }

  LineChartBarData _lineChartBarData() {
    final spots = <FlSpot>[];
    if (_historicalData.isNotEmpty) {
      final sortedDates = _historicalData.keys.toList()..sort();
      for (var i = 0; i < sortedDates.length; i++) {
        final date = sortedDates[i];
        final rate = _historicalData[date][_toCurrency];
        if (rate != null) {
          spots.add(FlSpot(i.toDouble(), rate.toDouble()));
        }
      }
    }

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: Theme.of(context).colorScheme.primary,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: Theme.of(context).colorScheme.primary.withAlpha(40),
      ),
    );
  }
}