import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HistoryChartScreen extends StatefulWidget {
  const HistoryChartScreen({super.key});

  @override
  State<HistoryChartScreen> createState() => _HistoryChartScreenState();
}

class _HistoryChartScreenState extends State<HistoryChartScreen> {
  String base = 'USD';
  String target = 'EUR';
  DateTimeRange? range;
  bool loading = false;
  String? error;
  List<FlSpot> spots = [];
  List<String> labels = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    range = DateTimeRange(
      start: now.subtract(const Duration(days: 30)),
      end: now,
    );
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    if (range == null) return;
    setState(() {
      loading = true;
      error = null;
      spots = [];
      labels = [];
    });
    final start = range!.start.toIso8601String().substring(0, 10);
    final end = range!.end.toIso8601String().substring(0, 10);
    final url = Uri.parse(
      'https://api.frankfurter.app/${start}..${end}?from=$base&to=$target',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rates = Map<String, dynamic>.from(data['rates']);
        final sortedDates = rates.keys.toList()..sort();
        final List<FlSpot> chartSpots = [];
        final List<String> chartLabels = [];
        int i = 0;
        for (final date in sortedDates) {
          final rate = (rates[date][target] as num).toDouble();
          chartSpots.add(FlSpot(i.toDouble(), rate));
          chartLabels.add(date.substring(5)); // MM-DD
          i++;
        }
        setState(() {
          spots = chartSpots;
          labels = chartLabels;
          loading = false;
        });
      } else {
        setState(() {
          error = 'API Error: ${response.statusCode}';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Failed to fetch data.';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency History'),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: base,
                    decoration: const InputDecoration(labelText: 'Base'),
                    items: ['USD', 'EUR', 'GBP', 'JPY', 'INR', 'CAD', 'AUD', 'CHF', 'CNY', 'BRL']
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null && val != base) {
                        setState(() => base = val);
                        fetchHistory();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.arrow_forward, color: scheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: target,
                    decoration: const InputDecoration(labelText: 'Target'),
                    items: ['USD', 'EUR', 'GBP', 'JPY', 'INR', 'CAD', 'AUD', 'CHF', 'CNY', 'BRL']
                        .where((c) => c != base)
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null && val != target) {
                        setState(() => target = val);
                        fetchHistory();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('Date Range:', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(1999, 1, 1),
                      lastDate: DateTime.now(),
                      initialDateRange: range,
                    );
                    if (picked != null && picked != range) {
                      setState(() => range = picked);
                      fetchHistory();
                    }
                  },
                  child: Text(
                    range == null
                        ? 'Select'
                        : '${range!.start.toString().substring(0, 10)} to ${range!.end.toString().substring(0, 10)}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (loading)
              const Center(child: CircularProgressIndicator()),
            if (error != null)
              Center(
                child: Text(error!, style: TextStyle(color: scheme.error)),
              ),
            if (!loading && error == null && spots.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12, left: 4),
                  child: LineChart(
                    LineChartData(
                      minY: spots.map((e) => e.y).reduce((a, b) => a < b ? a : b) * 0.98,
                      maxY: spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.02,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final idx = value.toInt();
                              if (idx < 0 || idx >= labels.length) return const SizedBox.shrink();
                              return Text(labels[idx], style: const TextStyle(fontSize: 10));
                            },
                            interval: (labels.length / 6).ceilToDouble().clamp(1, 999),
                          ),
                        ),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: scheme.primary,
                          barWidth: 3,
                          dotData: FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (!loading && error == null && spots.isEmpty)
              const Center(child: Text('No data for selected range.')),
          ],
        ),
      ),
    );
  }
} 