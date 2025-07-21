import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'currency_converter_screen.dart';
import 'length_converter_screen.dart';
import 'weight_converter_screen.dart';
import 'temperature_converter_screen.dart';
import 'area_converter_screen.dart';
import 'volume_converter_screen.dart';
import 'speed_converter_screen.dart';
import 'time_converter_screen.dart';
import 'energy_converter_screen.dart';
import 'power_converter_screen.dart';
import 'data_converter_screen.dart';
import 'frequency_converter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final categories = [
      {
        'title': 'Currency',
        'icon': Icons.currency_exchange,
        'color': scheme.surface,
        'iconColor': Colors.blueAccent,
        'screen': const CurrencyConverterScreen(),
        'desc': 'Convert between 150+ world currencies with live rates.',
      },
      {
        'title': 'Length',
        'icon': Icons.straighten,
        'color': scheme.surface,
        'iconColor': Colors.green,
        'screen': const LengthConverterScreen(),
        'desc': 'Meters, feet, inches, and more.',
      },
      {
        'title': 'Weight',
        'icon': Icons.monitor_weight,
        'color': scheme.surface,
        'iconColor': Colors.brown,
        'screen': const WeightConverterScreen(),
        'desc': 'Kilograms, pounds, ounces, and more.',
      },
      {
        'title': 'Temperature',
        'icon': Icons.thermostat,
        'color': scheme.surface,
        'iconColor': Colors.deepOrangeAccent,
        'screen': const TemperatureConverterScreen(),
        'desc': 'Celsius, Fahrenheit, Kelvin, and more.',
      },
      {
        'title': 'Area',
        'icon': Icons.crop_square,
        'color': AppTheme.areaGreen.withAlpha(20),
        'iconColor': AppTheme.areaGreen,
        'screen': const AreaConverterScreen(),
        'desc': 'Square meters, acres, hectares, and more.',
      },
      {
        'title': 'Volume',
        'icon': Icons.local_drink,
        'color': AppTheme.volumeIndigo.withAlpha(20),
        'iconColor': AppTheme.volumeIndigo,
        'screen': const VolumeConverterScreen(),
        'desc': 'Liters, gallons, cups, and more.',
      },
      {
        'title': 'Speed',
        'icon': Icons.speed,
        'color': AppTheme.speedPurple.withAlpha(20),
        'iconColor': AppTheme.speedPurple,
        'screen': const SpeedConverterScreen(),
        'desc': 'Meters/sec, km/h, mph, knots, and more.',
      },
      {
        'title': 'Time',
        'icon': Icons.access_time,
        'color': AppTheme.timeOrange.withAlpha(20),
        'iconColor': AppTheme.timeOrange,
        'screen': const TimeConverterScreen(),
        'desc': 'Seconds, minutes, hours, days, and more.',
      },
      {
        'title': 'Energy',
        'icon': Icons.bolt,
        'color': AppTheme.energyGreen.withAlpha(20),
        'iconColor': AppTheme.energyGreen,
        'screen': const EnergyConverterScreen(),
        'desc': 'Joules, calories, kWh, BTU, and more.',
      },
      {
        'title': 'Power',
        'icon': Icons.flash_on,
        'color': AppTheme.powerRed.withAlpha(20),
        'iconColor': AppTheme.powerRed,
        'screen': const PowerConverterScreen(),
        'desc': 'Watts, kilowatts, horsepower, and more.',
      },
      {
        'title': 'Data',
        'icon': Icons.sd_storage,
        'color': AppTheme.dataBlueGrey.withAlpha(20),
        'iconColor': AppTheme.dataBlueGrey,
        'screen': const DataConverterScreen(),
        'desc': 'Bytes, KB, MB, GB, TB, and more.',
      },
      {
        'title': 'Frequency',
        'icon': Icons.waves,
        'color': AppTheme.freqDeepOrange.withAlpha(20),
        'iconColor': AppTheme.freqDeepOrange,
        'screen': const FrequencyConverterScreen(),
        'desc': 'Hertz, kHz, MHz, GHz.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'XConvert',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = categories[index];
                    return CategoryCard(
                      icon: category['icon'] as IconData,
                      label: category['title'] as String,
                      color: category['color'] as Color,
                      iconColor: category['iconColor'] as Color,
                      description: category['desc'] as String,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => category['screen'] as Widget),
                        );
                      },
                    );
                  },
                  childCount: categories.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  final String description;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: iconColor.withAlpha(25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withAlpha(46),
              ),
              padding: const EdgeInsets.all(18),
              child: Icon(icon, color: iconColor, size: 36),
            ),
            const SizedBox(height: 18),
            Text(
              label,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
} 