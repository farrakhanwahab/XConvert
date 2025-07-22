import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:xconvert/screens/area_converter_screen.dart';
import 'package:xconvert/screens/currency_converter_screen.dart';
import 'package:xconvert/screens/data_converter_screen.dart';
import 'package:xconvert/screens/energy_converter_screen.dart';
import 'package:xconvert/screens/frequency_converter_screen.dart';
import 'package:xconvert/screens/length_converter_screen.dart';
import 'package:xconvert/screens/power_converter_screen.dart';
import 'package:xconvert/screens/speed_converter_screen.dart';
import 'package:xconvert/screens/temperature_converter_screen.dart';
import 'package:xconvert/screens/time_converter_screen.dart';
import 'package:xconvert/screens/volume_converter_screen.dart';
import 'package:xconvert/screens/weight_converter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = _buildCategories(context);
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.2,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CategoryCard(category: categories[index]);
              },
              childCount: categories.length,
            ),
          ),
        ),
      ],
    );
  }

  List<Category> _buildCategories(BuildContext context) {
    return [
      Category(
          name: 'Currency',
          icon: LucideIcons.dollarSign,
          screen: const CurrencyConverterScreen(),
          color: Colors.orange,
          description: 'Live exchange rates'),
      Category(
          name: 'Length',
          icon: LucideIcons.ruler,
          screen: const LengthConverterScreen(),
          color: Colors.blue,
          description: 'Meters, feet, miles...'),
      Category(
          name: 'Weight',
          icon: LucideIcons.scale,
          screen: const WeightConverterScreen(),
          color: Colors.red,
          description: 'Kilograms, pounds...'),
      Category(
          name: 'Temperature',
          icon: LucideIcons.thermometer,
          screen: const TemperatureConverterScreen(),
          color: Colors.purple,
          description: 'Celsius, Fahrenheit...'),
      Category(
          name: 'Area',
          icon: LucideIcons.square,
          screen: const AreaConverterScreen(),
          color: Colors.green,
          description: 'Square meters, acres...'),
      Category(
          name: 'Volume',
          icon: LucideIcons.box,
          screen: const VolumeConverterScreen(),
          color: Colors.cyan,
          description: 'Liters, gallons...'),
      Category(
          name: 'Speed',
          icon: LucideIcons.gauge,
          screen: const SpeedConverterScreen(),
          color: Colors.lightBlue,
          description: 'Km/h, mph...'),
      Category(
          name: 'Time',
          icon: LucideIcons.clock,
          screen: const TimeConverterScreen(),
          color: Colors.amber,
          description: 'Seconds, minutes, hours...'),
      Category(
          name: 'Energy',
          icon: LucideIcons.zap,
          screen: const EnergyConverterScreen(),
          color: Colors.lime,
          description: 'Joules, calories...'),
      Category(
          name: 'Power',
          icon: LucideIcons.activity,
          screen: const PowerConverterScreen(),
          color: Colors.yellow,
          description: 'Watts, horsepower...'),
      Category(
          name: 'Data',
          icon: LucideIcons.database,
          screen: const DataConverterScreen(),
          color: Colors.grey,
          description: 'Bytes, kilobytes...'),
      Category(
          name: 'Frequency',
          icon: LucideIcons.radio,
          screen: const FrequencyConverterScreen(),
          color: Colors.pink,
          description: 'Hertz, gigahertz...'),
    ];
  }
}

class Category {
  final String name;
  final IconData icon;
  final Widget screen;
  final Color color;
  final String description;

  Category({
    required this.name,
    required this.icon,
    required this.screen,
    required this.color,
    required this.description,
  });
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => category.screen),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 32, color: category.color),
            const SizedBox(height: 12),
            Text(
              category.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              category.description,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
} 